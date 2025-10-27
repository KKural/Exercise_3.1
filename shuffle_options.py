#!/usr/bin/env python3
"""
Script to shuffle multiple choice options in Rmd files while preserving correct answer markers.

This script:
1. Reads the Rmd file
2. Identifies questions with multiple choice options (1), 2), 3), 4))
3. Shuffles the option order randomly
4. Updates the correct answer markers (✅ Juist!) accordingly
5. Saves the shuffled version
"""

import re
import random
import sys
from pathlib import Path


def parse_question_block(content, start_pos):
    """
    Parse a single question block starting from a given position.
    Returns the question block and its end position.
    """
    # Find the next question start or end of content
    next_question_pattern = r'\n### Vraag Q\d+'
    next_match = re.search(next_question_pattern, content[start_pos + 1:])

    if next_match:
        end_pos = start_pos + 1 + next_match.start()
    else:
        end_pos = len(content)

    question_block = content[start_pos:end_pos]
    return question_block, end_pos


def extract_options_from_block(question_block):
    """
    Extract options from a question block.
    Returns a list of tuples: (option_number, option_text, is_correct)
    """
    options = []

    # Pattern to match options: number) text followed by feedback
    option_pattern = r'(\d+)\)\s*([^"]*?)\n"(\d+)"\s*=\s*"([^"]*)"'

    matches = re.finditer(option_pattern, question_block, re.DOTALL)

    for match in matches:
        option_num = int(match.group(1))
        option_text = match.group(2).strip()
        feedback_num = int(match.group(3))
        feedback_text = match.group(4)

        # Check if this is the correct answer
        is_correct = "✅ Juist!" in feedback_text

        options.append({
            'original_num': option_num,
            'text': option_text,
            'feedback_num': feedback_num,
            'feedback': feedback_text,
            'is_correct': is_correct
        })

    return options


def shuffle_options(options):
    """
    Shuffle the options and update their numbers.
    Returns the shuffled options with new numbering.
    """
    if len(options) < 2:
        return options

    # Create a copy and shuffle
    shuffled = options.copy()
    random.shuffle(shuffled)

    # Assign new numbers
    for i, option in enumerate(shuffled, 1):
        option['new_num'] = i

    return shuffled


def rebuild_question_block(question_block, shuffled_options):
    """
    Rebuild the question block with shuffled options.
    """
    if not shuffled_options:
        return question_block

    # Split the block into parts: before options, options section, after options
    first_option_pattern = r'(\d+)\)\s*([^"]*?)\n"(\d+)"\s*=\s*"([^"]*)"'
    first_match = re.search(first_option_pattern, question_block, re.DOTALL)

    if not first_match:
        return question_block

    # Find where options start
    options_start = first_match.start()

    # Find where options end (look for the end of the last option feedback)
    all_matches = list(re.finditer(
        first_option_pattern, question_block, re.DOTALL))
    if all_matches:
        options_end = all_matches[-1].end()
    else:
        return question_block

    # Extract parts
    before_options = question_block[:options_start]
    after_options = question_block[options_end:]

    # Rebuild options section
    new_options_section = ""
    for option in shuffled_options:
        new_options_section += f"{option['new_num']}) {option['text']}\n"
        new_options_section += f'"{option["new_num"]}" = "{option["feedback"]}"\n\n'

    # Combine all parts
    return before_options + new_options_section + after_options


def shuffle_rmd_file(input_path, output_path, seed=None):
    """
    Main function to shuffle options in an Rmd file.
    """
    if seed is not None:
        random.seed(seed)

    # Read the file
    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find all questions
    question_pattern = r'### Vraag Q\d+'
    question_matches = list(re.finditer(question_pattern, content))

    # Process questions in reverse order to avoid position shifts
    new_content = content
    offset = 0

    for match in reversed(question_matches):
        question_start = match.start()

        # Parse this question block
        question_block, question_end = parse_question_block(
            content, question_start)

        # Extract options
        options = extract_options_from_block(question_block)

        if len(options) >= 2:  # Only shuffle if there are multiple options
            # Shuffle options
            shuffled_options = shuffle_options(options)

            # Rebuild question block
            new_question_block = rebuild_question_block(
                question_block, shuffled_options)

            # Calculate positions in the modified content
            adjusted_start = question_start - offset
            adjusted_end = question_end - offset

            # Replace in new_content
            new_content = (new_content[:adjusted_start] +
                           new_question_block +
                           new_content[adjusted_end:])

            # Update offset
            offset += (question_end - question_start) - len(new_question_block)

            print(
                f"Shuffled options for question at position {question_start}")
            print(
                f"  Original correct answer: option {[o['original_num'] for o in options if o['is_correct']]}")
            print(
                f"  New correct answer: option {[o['new_num'] for o in shuffled_options if o['is_correct']]}")

    # Write the result
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(new_content)

    print(f"\nShuffled options saved to: {output_path}")


if __name__ == "__main__":
    input_file = r"c:\Users\kukumar\OneDrive - UGent\My Projects\Dodona\B001628A-Statistiek-in-de-criminologie-1\All quesion\dutch_test II correlation_only_corrected2.Rmd"
    output_file = r"c:\Users\kukumar\OneDrive - UGent\My Projects\Dodona\B001628A-Statistiek-in-de-criminologie-1\All quesion\dutch_test II correlation_only_corrected2_shuffled.Rmd"

    # Set a random seed for reproducibility (optional)
    random_seed = 42

    print(f"Shuffling options in: {input_file}")
    print(f"Using random seed: {random_seed}")

    shuffle_rmd_file(input_file, output_file, seed=random_seed)
