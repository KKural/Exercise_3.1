import os
import sys
from docx import Document
from docx.shared import Pt, Inches, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
import glob


def simple_markdown_to_word(md_file, output_file):
    try:
        # Read the markdown file
        with open(md_file, 'r', encoding='utf-8') as file:
            md_content = file.read()

        print(f"Successfully read Markdown file: {md_file}")

        # Create a new Word document
        doc = Document()

        # Set font for the entire document
        style = doc.styles['Normal']
        style.font.name = 'Times New Roman'
        style.font.size = Pt(11)

        # Update heading styles to use Times New Roman and black color
        for i in range(1, 10):
            if f'Heading {i}' in doc.styles:
                heading_style = doc.styles[f'Heading {i}']
                heading_style.font.name = 'Times New Roman'
                heading_style.font.color.rgb = RGBColor(0, 0, 0)

        # Process each line of the markdown
        current_list = []
        in_list = False
        in_table = False
        table_data = []

        # Get the base directory for image resolution
        base_dir = os.path.dirname(os.path.abspath(md_file))
        project_root = find_project_root(base_dir)

        # Debug image paths
        print(f"Base directory: {base_dir}")
        print(f"Project root: {project_root}")

        # List all image files in the project
        all_images = []
        for root, _, files in os.walk(project_root):
            for file in files:
                if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif')):
                    all_images.append(os.path.join(root, file))

        print(f"Found {len(all_images)} images in project")

        lines = md_content.split('\n')
        i = 0
        while i < len(lines):
            line = lines[i]

            # Check for headers
            if line.startswith('# '):
                heading = doc.add_heading(line[2:], 0)  # Title
                for run in heading.runs:
                    run.font.name = 'Times New Roman'
                    run.font.color.rgb = RGBColor(0, 0, 0)
            elif line.startswith('## '):
                heading = doc.add_heading(line[3:], 1)
                for run in heading.runs:
                    run.font.name = 'Times New Roman'
                    run.font.color.rgb = RGBColor(0, 0, 0)
            elif line.startswith('### '):
                heading = doc.add_heading(line[4:], 2)
                for run in heading.runs:
                    run.font.name = 'Times New Roman'
                    run.font.color.rgb = RGBColor(0, 0, 0)
            elif line.startswith('#### '):
                heading = doc.add_heading(line[5:], 3)
                for run in heading.runs:
                    run.font.name = 'Times New Roman'
                    run.font.color.rgb = RGBColor(0, 0, 0)

            # Check for bullet points and numbered lists
            elif line.strip().startswith('- ') or line.strip().startswith('* '):
                doc.add_paragraph(line.strip()[2:], style='List Bullet')
            elif line.strip().startswith('1. ') and line.strip()[3:].strip():
                # Check if it's a numbered list
                doc.add_paragraph(line.strip()[3:], style='List Number')

            # Check for tables
            elif line.strip().startswith('|') and line.strip().endswith('|'):
                if not in_table:
                    in_table = True
                    table_data = []

                # Extract cells from the table row
                cells = [cell.strip() for cell in line.strip('|').split('|')]
                table_data.append(cells)

                # Check if the next line is a separator row
                if i + 1 < len(lines) and lines[i + 1].strip().startswith('|') and set(c for c in lines[i + 1].strip('|') if c not in '|-: ') == set():
                    i += 1  # Skip the separator row

            # Check for end of table
            elif in_table and not line.strip().startswith('|'):
                # Create the table in the document
                if table_data:
                    num_rows = len(table_data)
                    num_cols = max(len(row) for row in table_data)

                    if num_rows > 0 and num_cols > 0:
                        table = doc.add_table(rows=num_rows, cols=num_cols)
                        table.style = 'Table Grid'

                        # Fill the table with data
                        for row_idx, row_data in enumerate(table_data):
                            for col_idx, cell_data in enumerate(row_data):
                                if col_idx < num_cols:  # Ensure we don't exceed columns
                                    cell = table.cell(row_idx, col_idx)
                                    cell.text = cell_data
                                    # Apply Times New Roman font to table text
                                    for paragraph in cell.paragraphs:
                                        for run in paragraph.runs:
                                            run.font.name = 'Times New Roman'

                in_table = False
                table_data = []

                # Process the current line (non-table line)
                if line.strip():
                    doc.add_paragraph(line)

            # Check for images
            elif line.strip().startswith('!['):
                try:
                    # Extract image details
                    alt_text = line.split('![')[1].split(']')[0]
                    img_path = line.split('(')[1].split(')')[0]

                    print(
                        f"Processing image: {img_path}, alt text: {alt_text}")

                    # Try multiple approaches to find the actual image file
                    img_full_path = find_image_file(
                        img_path, base_dir, project_root, all_images)

                    if img_full_path and os.path.exists(img_full_path):
                        try:
                            p = doc.add_paragraph()
                            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                            doc.add_picture(img_full_path, width=Inches(6))
                            caption = doc.add_paragraph(alt_text)
                            caption.alignment = WD_ALIGN_PARAGRAPH.CENTER
                            caption.style = 'Caption'
                            # Customize caption style
                            for run in caption.runs:
                                run.font.name = 'Times New Roman'
                                run.font.italic = True
                                run.font.size = Pt(10)
                            print(f"Successfully added image: {img_full_path}")
                        except Exception as e:
                            p = doc.add_paragraph(
                                f"[Image: {alt_text} - {img_path}]")
                            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                            p.italic = True
                            print(
                                f"Error adding image {img_full_path}: {str(e)}")
                    else:
                        p = doc.add_paragraph(
                            f"[Image: {alt_text} - {img_path}]\nFile not found")
                        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                        p.italic = True
                        print(
                            f"Image not found: {img_path}, tried looking for: {img_full_path}")
                        print(f"Paths searched:")
                        possible_paths = generate_possible_paths(
                            img_path, base_dir, project_root)
                        for path in possible_paths:
                            print(
                                f" - {path} (exists: {os.path.exists(path)})")
                except Exception as e:
                    p = doc.add_paragraph(
                        f"[Error processing image: {str(e)}]")
                    p.italic = True
                    print(f"Error processing image reference: {str(e)}")

            # Check for descriptions with bold formatting
            elif line.strip().startswith('**Description:**'):
                p = doc.add_paragraph()
                # Split the line to get the bold part and the rest
                parts = line.split('**Description:**', 1)
                # Add the bold part
                p.add_run('Description:').bold = True
                # Add the rest of the text
                p.add_run(parts[1])

            # Check for purpose with bold formatting
            elif line.strip().startswith('**Purpose:**'):
                p = doc.add_paragraph()
                # Split the line to get the bold part and the rest
                parts = line.split('**Purpose:**', 1)
                # Add the bold part
                p.add_run('Purpose:').bold = True
                # Add the rest of the text
                p.add_run(parts[1])

            # Handle other Markdown bold text
            elif '**' in line and not line.startswith('#'):
                p = doc.add_paragraph()
                # Split by bold markers
                parts = line.split('**')
                is_bold = False
                for i, part in enumerate(parts):
                    # Skip empty parts
                    if not part:
                        continue
                    # Toggle bold state (odd indices will be bold)
                    is_bold = (i % 2 == 1)
                    run = p.add_run(part)
                    run.bold = is_bold

            # Regular paragraph (not a header, list, image, or bold text)
            elif line.strip() and not line.startswith('---') and not line.startswith('#') and '**' not in line:
                if in_list:
                    # Continue the list
                    doc.add_paragraph(line, style='List Bullet')
                else:
                    doc.add_paragraph(line)

            # Process horizontal rule
            elif line.strip() == '---':
                doc.add_paragraph('_' * 50)

            i += 1  # Move to next line

        # Save the document
        doc.save(output_file)
        print(f"Document successfully saved to {output_file}")
        return f"Document successfully saved to {output_file}"

    except Exception as e:
        print(f"Error: {str(e)}")
        return f"Error: {str(e)}"


def generate_possible_paths(img_path, base_dir, project_root):
    """Generate all possible paths for an image"""
    possible_paths = []

    # Direct path
    possible_paths.append(img_path)

    # Relative to markdown file
    possible_paths.append(os.path.join(base_dir, img_path))

    # Try direct path to the images folder at project root
    possible_paths.append(os.path.join(
        project_root, 'images', os.path.basename(img_path)))

    # Look one level up for images folder (common pattern)
    possible_paths.append(os.path.join(os.path.dirname(
        base_dir), 'images', os.path.basename(img_path)))

    # For ../images/ pattern
    if img_path.startswith('../'):
        # Remove '../' and join with parent directory
        relative_path = img_path.replace('../', '')
        possible_paths.append(os.path.normpath(
            os.path.join(os.path.dirname(base_dir), relative_path)))

    # Try without 'images/' prefix if it's there
    if 'images/' in img_path:
        clean_path = os.path.basename(img_path)
        possible_paths.append(os.path.join(project_root, 'images', clean_path))
        possible_paths.append(os.path.join(
            os.path.dirname(base_dir), 'images', clean_path))

    # Try with common variations of image filenames
    # Sometimes image names might have spaces, underscores, or different casing
    variations = [
        os.path.basename(img_path),
        os.path.basename(img_path).replace('-', '_'),
        os.path.basename(img_path).replace('_', '-'),
        os.path.basename(img_path).replace(' ', '_'),
        os.path.basename(img_path).replace(' ', '-'),
        os.path.basename(img_path).lower(),
    ]

    for var in variations:
        possible_paths.append(os.path.join(project_root, 'images', var))
        possible_paths.append(os.path.join(
            os.path.dirname(base_dir), 'images', var))

    return possible_paths


def find_project_root(start_dir):
    """Find the root directory of the project by looking for .git folder"""
    current_dir = start_dir
    max_depth = 10  # Prevent infinite loop
    depth = 0

    while depth < max_depth:
        if os.path.exists(os.path.join(current_dir, '.git')):
            return current_dir

        parent_dir = os.path.dirname(current_dir)
        if parent_dir == current_dir:  # Reached root directory
            break

        current_dir = parent_dir
        depth += 1

    # If we can't find .git folder, return the original directory
    return start_dir


def find_image_file(img_path, base_dir, project_root, all_images):
    """Try multiple approaches to find the actual image file"""
    possible_paths = []

    # Debug information
    print(f"Looking for image: {img_path}")
    print(f"Base directory: {base_dir}")
    print(f"Project root: {project_root}")

    # Direct path - as specified in markdown
    if os.path.isabs(img_path):
        possible_paths.append(img_path)

    # Extract just the filename without path
    img_filename = os.path.basename(img_path)
    print(f"Image filename: {img_filename}")

    # Relative to markdown file
    possible_paths.append(os.path.join(base_dir, img_path))

    # Try direct path to the images folder at project root
    possible_paths.append(os.path.join(project_root, 'images', img_filename))

    # Look one level up for images folder (common pattern)
    possible_paths.append(os.path.join(
        os.path.dirname(base_dir), 'images', img_filename))

    # For ../images/ pattern
    if img_path.startswith('../'):
        # Remove '../' and join with parent directory
        relative_path = img_path.replace('../', '')
        possible_paths.append(os.path.normpath(
            os.path.join(os.path.dirname(base_dir), relative_path)))

    # Try without 'images/' prefix if it's there
    if 'images/' in img_path:
        clean_path = img_filename
        possible_paths.append(os.path.join(project_root, 'images', clean_path))
        possible_paths.append(os.path.join(
            os.path.dirname(base_dir), 'images', clean_path))

    # Try with common variations of image filenames
    # Sometimes image names might have spaces, underscores, or different casing
    variations = [
        img_filename,
        img_filename.replace('-', '_'),
        img_filename.replace('_', '-'),
        img_filename.replace(' ', '_'),
        img_filename.replace(' ', '-'),
        img_filename.lower(),
    ]

    for var in variations:
        possible_paths.append(os.path.join(project_root, 'images', var))
        possible_paths.append(os.path.join(
            os.path.dirname(base_dir), 'images', var))

    # Check if filename is in any of the known image files (fuzzy match)
    matching_images = []
    for img in all_images:
        img_base = os.path.basename(img).lower()
        # Try exact match
        if os.path.basename(img).lower() == img_filename.lower():
            matching_images.append(img)
        # Try partial match (for when filenames have extra prefixes/suffixes)
        elif img_filename.lower() in img_base or any(var.lower() in img_base for var in variations):
            matching_images.append(img)

    possible_paths.extend(matching_images)

    # Deduplicate paths
    possible_paths = list(set(possible_paths))

    # Check which path exists and print results
    print(f"Checking {len(possible_paths)} possible paths:")
    for path in possible_paths:
        exists = os.path.exists(path)
        print(f"  - {path} {'✓' if exists else '✗'}")
        if exists:
            return path

    # If nothing found, look for any image with a similar name
    print("Trying fuzzy matching for images...")
    for img in all_images:
        img_base = os.path.basename(img).lower()
        img_name_part = os.path.splitext(img_filename)[0].lower()
        if img_name_part in img_base:
            print(f"Fuzzy match found: {img}")
            return img

    # Not found in any of the expected locations
    return None


# Usage
if __name__ == "__main__":
    input_file = "description/Dodona_Learning_Path_Overview.md"
    output_file = "Dodona_Learning_Path_Overview.docx"

    # Get the current directory
    current_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct full paths
    input_path = os.path.join(current_dir, input_file)
    output_path = os.path.join(current_dir, output_file)

    if not os.path.exists(input_path):
        print(f"Error: Input file not found: {input_path}")
        sys.exit(1)

    print(f"Converting {input_path} to {output_path}...")
    result = simple_markdown_to_word(input_path, output_path)
    print(result)
