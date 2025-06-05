#!/usr/bin/python3
import sys

# Read from stdin instead of a file
answer = sys.stdin.read().strip()

if answer == "2":
    print("✅ Correct! Descriptive statistics summarize and describe data.")
else:
    print("❌ Incorrect. The correct answer is 2: Summarize and describe data.")
