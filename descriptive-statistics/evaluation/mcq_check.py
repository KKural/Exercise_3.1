#!/usr/bin/env python3
import sys
import os

def main():
    # Read the student's answer
    with open("submission/solution.py", "r") as file:
        answer = file.read().strip()
    
    # Check the answer
    correct_answer = "2"
    if answer == correct_answer:
        print("✅ Correct – descriptive statistics summarize and describe data.")
        sys.exit(0)
    elif answer == "1":
        print("❌ Incorrect. Predicting future outcomes belongs to inferential statistics, not descriptive.")
        sys.exit(-1)
    elif answer == "3":
        print("❌ Incorrect. Establishing causal relationships belongs to inferential statistics, not descriptive.")
        sys.exit(-1)
    elif answer == "4":
        print("❌ Incorrect. Hypothesis testing is a part of inferential statistics, not descriptive.")
        sys.exit(-1)
    else:
        print("❌ Please enter exactly one number: 1, 2, 3, or 4.")
        sys.exit(-1)

if __name__ == "__main__":
    main()
