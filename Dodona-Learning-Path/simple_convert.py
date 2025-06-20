import os
import sys
from docx import Document
from docx.shared import Pt, Inches
from docx.enum.text import WD_ALIGN_PARAGRAPH


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
        style.font.name = 'Calibri'
        style.font.size = Pt(11)

        # Process each line of the markdown
        current_list = []
        in_list = False

        # Get the base directory for image resolution
        base_dir = os.path.dirname(os.path.abspath(md_file))

        for line in md_content.split('\n'):
            # Check for headers
            if line.startswith('# '):
                doc.add_heading(line[2:], 1)
            elif line.startswith('## '):
                doc.add_heading(line[3:], 2)
            elif line.startswith('### '):
                doc.add_heading(line[4:], 3)
            elif line.startswith('#### '):
                doc.add_heading(line[5:], 4)
            # Check for list items
            elif line.strip().startswith('- ') or line.strip().startswith('* '):
                if not in_list:
                    in_list = True
                current_list.append(line.strip()[2:])
            # Check for images
            elif line.strip().startswith('!['):
                try:
                    # Extract image details
                    alt_text = line.split('![')[1].split(']')[0]
                    img_path = line.split('(')[1].split(')')[0]

                    # Handle GitHub-style paths (images/filename.png)
                    if img_path.startswith('images/'):
                        # For local conversion, we need to look in the parent directory
                        potential_paths = [
                            os.path.join(base_dir, img_path),  # Try direct path
                            os.path.join(base_dir, '..', img_path),  # Try one level up
                            os.path.join(os.path.dirname(base_dir), img_path),  # Try from parent dir
                        ]
                    else:
                        # Handle other relative paths
                        potential_paths = [
                            os.path.join(base_dir, img_path),  # Try direct path
                            os.path.join(os.path.dirname(base_dir), img_path.replace('../', ''))  # Try removing ../
                        ]

                    # Try each potential path
                    img_full_path = None
                    for path in potential_paths:
                        if os.path.exists(path):
                            img_full_path = path
                            break

                    if img_full_path:
                        p = doc.add_paragraph()
                        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                        try:
                            doc.add_picture(img_full_path, width=Inches(6))
                            p = doc.add_paragraph(f"{alt_text}")
                            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                            p.italic = True
                            print(f"Successfully added image: {img_full_path}")
                        except Exception as e:
                            doc.add_paragraph(
                                f"[Image: {alt_text} - {img_path}]\nError: {str(e)}").italic = True
                            print(
                                f"Error adding image {img_full_path}: {str(e)}")
                    else:
                        doc.add_paragraph(
                            f"[Image: {alt_text} - {img_path}]\nFile not found. Tried paths: {', '.join(potential_paths)}").italic = True
                        print(f"Image not found: {img_path}")
                        print(f"Tried paths: {potential_paths}")
                except Exception as e:
                    doc.add_paragraph(
                        f"[Error processing image: {str(e)}]").italic = True
                    print(f"Error processing image reference: {str(e)}")
            # Regular paragraph
            elif line.strip() and not line.startswith('---'):
                if in_list:
                    # Add accumulated list items
                    for item in current_list:
                        doc.add_paragraph(item, style='List Bullet')
                    current_list = []
                    in_list = False
                doc.add_paragraph(line)
            # Empty line (end of paragraph)
            elif not line.strip():
                if in_list:
                    # Add accumulated list items
                    for item in current_list:
                        doc.add_paragraph(item, style='List Bullet')
                    current_list = []
                    in_list = False

        # Save the document
        doc.save(output_file)
        return f"Document successfully saved to {output_file}"

    except Exception as e:
        return f"Error: {str(e)}"


# Usage
if __name__ == "__main__":
    input_file = "Dodona_Learning_Path_Overview.md"
    output_file = "Dodona_Learning_Path_Overview.docx"

    # Use command line argument if provided
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
        # If output file not provided, derive from input
        if len(sys.argv) <= 2:
            output_file = os.path.splitext(input_file)[0] + ".docx"
        else:
            output_file = sys.argv[2]

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
    # Relative to markdown file
    possible_paths.append(os.path.join(base_dir, img_path))

    # For ../images/ pattern
    if img_path.startswith('../'):
        # Remove '../' and join with parent directory
        relative_path = img_path.replace('../', '')
        possible_paths.append(os.path.normpath(
            os.path.join(os.path.dirname(base_dir), relative_path)))

    # From project root
    possible_paths.append(os.path.join(project_root, img_path))
    possible_paths.append(os.path.join(
        project_root, 'images', os.path.basename(img_path)))

    # Try common image directories
    for img_dir in ['images', 'img', 'assets']:
        possible_paths.append(os.path.join(
            project_root, img_dir, os.path.basename(img_path)))

    # Check if filename is in any of the known image files
    img_filename = os.path.basename(img_path)
    matching_images = [
        img for img in all_images if os.path.basename(img) == img_filename]
    possible_paths.extend(matching_images)

    # Check which path exists
    for path in possible_paths:
        if os.path.exists(path):
            return path

    # Not found in any of the expected locations
    print(f"Image not found. Tried these paths:")
    for path in possible_paths:
        print(f" - {path}")
    return None


# Usage
if __name__ == "__main__":
    input_file = "Dodona_Learning_Path_Overview.md"
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
