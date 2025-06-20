import os
import re
import sys


def extract_image_paths(markdown_file):
    """Extract all image paths from a markdown file"""
    with open(markdown_file, 'r', encoding='utf-8') as f:
        content = f.read()

    # Use regex to find all image references in markdown
    img_regex = r'!\[(.*?)\]\((.*?)\)'
    matches = re.findall(img_regex, content)

    # Return a list of tuples (alt_text, path)
    return matches


def check_image_paths(markdown_file):
    """Check if all images referenced in a markdown file exist"""
    base_dir = os.path.dirname(os.path.abspath(markdown_file))
    images = extract_image_paths(markdown_file)

    print(f"Checking {len(images)} image references in {markdown_file}")
    print(f"Base directory: {base_dir}")

    missing_images = []
    found_images = []

    for alt_text, img_path in images:
        # Resolve relative path
        if img_path.startswith('../'):
            # Remove '../' and join with parent directory
            relative_path = img_path.replace('../', '')
            img_full_path = os.path.normpath(os.path.join(
                os.path.dirname(base_dir), relative_path))
        else:
            img_full_path = os.path.normpath(os.path.join(base_dir, img_path))

        if os.path.exists(img_full_path):
            found_images.append((alt_text, img_path, img_full_path))
        else:
            missing_images.append((alt_text, img_path, img_full_path))

    # Print results
    print(f"\nFound {len(found_images)} images:")
    for i, (alt_text, img_path, img_full_path) in enumerate(found_images, 1):
        print(f"{i}. {alt_text} -> {img_full_path}")

    print(f"\nMissing {len(missing_images)} images:")
    for i, (alt_text, img_path, img_full_path) in enumerate(missing_images, 1):
        print(f"{i}. {alt_text} -> {img_full_path}")

    # Suggest image directory structure
    if missing_images:
        print("\nSuggested directory structure for images:")
        for _, img_path, img_full_path in missing_images:
            dir_path = os.path.dirname(img_full_path)
            print(f"mkdir -p \"{dir_path}\"")


if __name__ == "__main__":
    # Default markdown file
    markdown_file = "Dodona_Learning_Path_Overview.md"

    # Use command line argument if provided
    if len(sys.argv) > 1:
        markdown_file = sys.argv[1]

    # Get the current directory
    current_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct full path
    input_path = os.path.join(current_dir, markdown_file)

    if not os.path.exists(input_path):
        print(f"Error: Markdown file not found: {input_path}")
        sys.exit(1)

    check_image_paths(input_path)
