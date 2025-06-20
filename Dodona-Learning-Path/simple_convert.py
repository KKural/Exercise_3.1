import os
import sys
from docx import Document
from docx.shared import Pt


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
                # Extract image details
                alt_text = line.split('![')[1].split(']')[0]
                img_path = line.split('(')[1].split(')')[0]
                doc.add_paragraph(
                    f"[Image: {alt_text} - {img_path}]").italic = True
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
