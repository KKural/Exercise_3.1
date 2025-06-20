import os
import re
import sys
import glob


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


def find_image_files(project_root):
    """Find all image files in the project"""
    image_files = []
    for root, _, files in os.walk(project_root):
        for file in files:
            if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif')):
                image_files.append(os.path.join(root, file))
    return image_files


def extract_image_references(md_file):
    """Extract all image references from a markdown file"""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()

    image_pattern = r'!\[(.*?)\]\((.*?)\)'
    return re.findall(image_pattern, content)


def create_fixed_markdown(md_file, image_files):
    """Create a new markdown file with fixed image paths"""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()

    image_pattern = r'!\[(.*?)\]\((.*?)\)'
    matches = re.findall(image_pattern, content)

    fixed_content = content

    for alt_text, img_path in matches:
        img_filename = os.path.basename(img_path)
        matching_images = [
            img for img in image_files if os.path.basename(img) == img_filename]

        if matching_images:
            # Get the first matching image
            actual_image = matching_images[0]
            # Convert to relative path
            relative_path = os.path.relpath(
                actual_image, os.path.dirname(md_file))
            # Replace with correct path
            fixed_content = fixed_content.replace(
                f'![{alt_text}]({img_path})',
                f'![{alt_text}]({relative_path})'
            )
            print(f"Fixed: {img_path} -> {relative_path}")

    # Create a new file with _fixed suffix
    new_file = os.path.splitext(md_file)[0] + '_fixed.md'
    with open(new_file, 'w', encoding='utf-8') as f:
        f.write(fixed_content)

    return new_file


def main():
    # Default markdown file
    markdown_file = "Dodona_Learning_Path_Overview.md"

    # Use command line argument if provided
    if len(sys.argv) > 1:
        markdown_file = sys.argv[1]

    # Get the current directory
    current_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct full path
    md_path = os.path.join(current_dir, markdown_file)

    if not os.path.exists(md_path):
        print(f"Error: Markdown file not found: {md_path}")
        sys.exit(1)

    # Find project root
    project_root = find_project_root(current_dir)
    print(f"Project root: {project_root}")

    # Find all image files
    image_files = find_image_files(project_root)
    print(f"Found {len(image_files)} images in project")

    # Extract image references
    image_refs = extract_image_references(md_path)
    print(f"Found {len(image_refs)} image references in {markdown_file}")

    # Show image filenames from markdown
    print("\nImage filenames in Markdown:")
    for _, img_path in image_refs:
        print(f" - {os.path.basename(img_path)}")

    # Show actual image filenames from filesystem
    print("\nActual image filenames found:")
    for img_path in image_files:
        print(f" - {os.path.basename(img_path)}")

    # Create fixed markdown
    fixed_md = create_fixed_markdown(md_path, image_files)
    print(f"\nCreated fixed markdown file: {fixed_md}")

    print("\nNow try running simple_convert.py with the fixed markdown file:")
    print(f"python simple_convert.py {os.path.basename(fixed_md)}")


if __name__ == "__main__":
    main()
