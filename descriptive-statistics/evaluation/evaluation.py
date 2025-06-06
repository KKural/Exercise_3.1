#!/usr/bin/env python3

import os
import sys

def main():
    # Read the student's raw answer
    with open('submission/solution.py', 'r') as f:
        answer = f.read().strip()
    
    # Evaluate the answer
    if answer == '2':
        print("✓ Correct! Descriptive statistics summarize and describe data features.")
        sys.exit(0)
    elif answer == '1':
        print("✗ Incorrect. Predicting future outcomes belongs to inferential statistics.")
        sys.exit(1)
    elif answer == '3':
        print("✗ Incorrect. Establishing causal relationships belongs to inferential statistics.")
        sys.exit(1)
    elif answer == '4':
        print("✗ Incorrect. Testing hypotheses belongs to inferential statistics.")
        sys.exit(1)
    else:
        print("✗ Please enter exactly one number: 1, 2, 3, or 4.")
        sys.exit(1)

if __name__ == "__main__":
    main()
