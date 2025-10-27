#!/usr/bin/env python3
"""
SAFER Option Shuffler - Manual verification approach

This script will:
1. Extract questions and show you exactly what it found
2. Let you verify before making any changes
3. Create a backup before modifying anything
4. Make changes step by step with verification
"""

import re
import random
import shutil
from pathlib import Path


def extract_questions_for_verification(file_path):
    """
    Extract questions and show structure for manual verification
    """
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find all questions
    question_pattern = r'### (Vraag Q\d+.*?)\n\*\*(.*?)\*\*'
    questions = re.findall(question_pattern, content)

    print("FOUND QUESTIONS:")
    print("=" * 50)
    for i, (title, question_text) in enumerate(questions, 1):
        print(f"{i}. {title}")
        print(f"   Question: {question_text[:100]}...")
        print()

    return len(questions)


def extract_single_question_options(content, question_number):
    """
    Extract options from a specific question for verification
    """
    # Find the question
    pattern = f'### Vraag Q{question_number}.*?(?=### Vraag Q\\d+|$)'
    match = re.search(pattern, content, re.DOTALL)

    if not match:
        return None

    question_block = match.group(0)

    # Extract options
    option_pattern = r'(\d+)\)\s*(.*?)\n"(\d+)"\s*=\s*"(.*?)"(?=\n\d+\)|$)'
    options = re.findall(option_pattern, question_block, re.DOTALL)

    print(f"\nQUESTION Q{question_number} OPTIONS:")
    print("=" * 40)

    for opt_num, opt_text, feedback_num, feedback in options:
        print(f"Option {opt_num}: {opt_text[:50]}...")
        correct = "✅ Juist!" in feedback
        print(f"  Correct: {'YES' if correct else 'NO'}")
        print(f"  Feedback: {feedback[:100]}...")
        print()

    return options


def verify_before_shuffle():
    """
    Let user verify the structure before making changes
    """
    file_path = r"c:\Users\kukumar\OneDrive - UGent\My Projects\Dodona\B001628A-Statistiek-in-de-criminologie-1\All quesion\dutch_test II correlation_only_corrected2.Rmd"

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    print("VERIFICATION MODE")
    print("================")

    # Show overall structure
    num_questions = extract_questions_for_verification(file_path)
    print(f"Total questions found: {num_questions}")

    # Show specific question options
    while True:
        try:
            q_num = input(
                f"\nEnter question number to examine (1-{num_questions}, or 'q' to quit): ")
            if q_num.lower() == 'q':
                break

            q_num = int(q_num)
            options = extract_single_question_options(content, q_num)

            if options:
                print(f"Found {len(options)} options for Q{q_num}")
            else:
                print(f"No options found for Q{q_num}")

        except ValueError:
            print("Please enter a valid number or 'q'")
        except KeyboardInterrupt:
            break


if __name__ == "__main__":
    print("SAFE OPTION SHUFFLER - VERIFICATION MODE")
    print("This will show you the structure without making changes")
    print()

    verify_before_shuffle()
