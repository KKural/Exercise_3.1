# Simple script to test the conversion
import os
import sys
import time
import traceback

print("Starting test script...")

try:
    print("Checking for output directory...")
    output_dir = r"C:\Users\kukumar\OneDrive - UGent\Job"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created output directory: {output_dir}")
    else:
        print(f"Output directory exists: {output_dir}")

    print("Listing files in output directory:")
    for file in os.listdir(output_dir):
        file_path = os.path.join(output_dir, file)
        file_size = os.path.getsize(file_path) / 1024  # KB
        print(f" - {file} ({file_size:.2f} KB)")

    print("Writing test file...")
    with open(os.path.join(output_dir, "test_file.txt"), "w") as test_file:
        test_file.write("This is a test file created at " +
                        time.strftime("%Y-%m-%d %H:%M:%S"))

    print("Running conversion script...")
    script_path = os.path.join(os.path.dirname(
        os.path.abspath(__file__)), "simple_convert.py")
    print(f"Script path: {script_path}")
    print(f"Current directory: {os.getcwd()}")
    exec(open(script_path).read())

    print("Test complete.")
except Exception as e:
    print(f"ERROR: {str(e)}")
    traceback.print_exc()

# Write results to a file so we can check them later
with open("test_results.txt", "w") as results:
    results.write("Test completed at " +
                  time.strftime("%Y-%m-%d %H:%M:%S") + "\n")
    results.write("Current working directory: " + os.getcwd() + "\n")
    if os.path.exists(output_dir):
        results.write("Output directory exists\n")
        for file in os.listdir(output_dir):
            file_path = os.path.join(output_dir, file)
            file_size = os.path.getsize(file_path) / 1024  # KB
            results.write(f" - {file} ({file_size:.2f} KB)\n")
    else:
        results.write("Output directory does not exist\n")
