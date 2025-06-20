import subprocess
import sys

def install_packages():
    required_packages = ['python-docx', 'markdown', 'beautifulsoup4']
    
    print("Installing required packages...")
    
    for package in required_packages:
        print(f"Installing {package}...")
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', package])
        
    print("All required packages installed successfully!")

if __name__ == "__main__":
    install_packages()
