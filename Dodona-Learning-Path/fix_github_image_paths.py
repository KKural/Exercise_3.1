import os
import re
import sys

def fix_github_image_paths(md_file):
    """Fix image paths in markdown file for GitHub compatibility"""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Get the directory structure information
    current_dir = os.path.dirname(os.path.abspath(md_file))
    md_filename = os.path.basename(md_file)
    md_dir = os.path.basename(current_dir)
    
    # For GitHub, we need to fix several image path patterns
    
    # Pattern 1: ../images/ -> images/
    # Since GitHub expects images to be relative to the repository structure
    fixed_content = re.sub(
        r'!\[(.*?)\]\(\.\./images/(.*?)\)', 
        r'![\\1](images/\\2)', 
        content
    )
    
    # Create a new file with _github suffix
    new_file = os.path.splitext(md_file)[0] + '_github.md'
    with open(new_file, 'w', encoding='utf-8') as f:
        f.write(fixed_content)
    
    print(f"Created GitHub-compatible markdown file: {new_file}")
    
    # Let's also update the original file so it works with simple_convert.py
    # For local conversion, we need to use paths that work with the local filesystem
    with open(md_file, 'r', encoding='utf-8') as f:
        original_content = f.read()
    
    # Replace all image paths to use a direct path that will work locally
    local_fixed_content = re.sub(
        r'!\[(.*?)\]\(\.\./images/(.*?)\)', 
        r'![\\1](../images/\\2)', 
        original_content
    )
    
    with open(md_file, 'w', encoding='utf-8') as f:
        f.write(local_fixed_content)
    
    print(f"Updated original markdown file with proper local paths: {md_file}")
    
    return new_file

if __name__ == "__main__":
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
    
    fix_github_image_paths(md_path)
