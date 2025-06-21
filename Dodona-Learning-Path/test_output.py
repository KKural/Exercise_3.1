import os

# Write a test file to verify file writing works
with open("test_status.txt", "w") as f:
    f.write("Test successful\n")
    f.write("This file was created to verify file writing capabilities\n")

# Check if the job directory exists
job_dir = r"C:\Users\kukumar\OneDrive - UGent\Job"
if os.path.exists(job_dir):
    with open("test_status.txt", "a") as f:
        f.write(f"Job directory exists: {job_dir}\n")
        f.write("Files in job directory:\n")
        for file in os.listdir(job_dir):
            file_path = os.path.join(job_dir, file)
            file_size = os.path.getsize(file_path) / 1024  # KB
            f.write(f" - {file} ({file_size:.2f} KB)\n")
else:
    with open("test_status.txt", "a") as f:
        f.write(f"Job directory does not exist: {job_dir}\n")

# Print to stdout
print("Test script completed - check test_status.txt for results")
