# Create Directory Structure for Dodona Correlation Exercises
# This script creates all 25 exercise directories with proper structure

import os
import uuid

# Define the base path
base_path = r"C:\Users\kukumar\OneDrive - UGent\My Projects\Dodona\B001628A-Statistiek-in-de-criminologie-1"

# Define which questions have images
questions_with_images = [3, 8, 9, 12, 14, 15, 18, 19, 21, 23]

# Question titles for directory names
question_titles = {
    1: "3.1 Correlatie - Wat is correlatie",
    2: "3.2 Correlatie - Wat is een z-score", 
    3: "3.3 Correlatie - Belangrijkste maatregelen",
    4: "3.4 Correlatie - Centrum in z-Scores",
    5: "3.5 Correlatie - Eenheden veranderen niet r",
    6: "3.6 Correlatie - Variabeletypen",
    7: "3.7 Correlatie - Correlatie vs causaliteit",
    8: "3.8 Correlatie - Interpreteer correlatie",
    9: "3.9 Correlatie - Wat correlatie vertelt",
    10: "3.10 Correlatie - Covariantie versus correlatie",
    11: "3.11 Correlatie - Visualisatie belang",
    12: "3.12 Correlatie - Covariantie verschillen",
    13: "3.13 Correlatie - Misleidende correlatie",
    14: "3.14 Correlatie - Pearson vs Spearman",
    15: "3.15 Correlatie - Richting en kracht",
    16: "3.16 Correlatie - Zwak positief",
    17: "3.17 Correlatie - Correlatie types",
    18: "3.18 Correlatie - Wanneer welke correlatie",
    19: "3.19 Correlatie - Impact uitschieters",
    20: "3.20 Correlatie - Standardisatie nodig",
    21: "3.21 Correlatie - Correlatie interpretatie",
    22: "3.22 Correlatie - Statistische claims",
    23: "3.23 Correlatie - Correlatie aannames",
    24: "3.24 Correlatie - Onderzoek ontwerpen",
    25: "3.25 Correlatie - Hypothese opstellen"
}

# Create directories for all 25 questions
for i in range(1, 26):
    # Create main directory
    dir_name = question_titles[i]
    dir_path = os.path.join(base_path, dir_name)
    
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)
        print(f"Created directory: {dir_name}")
    
    # Create subdirectories
    description_path = os.path.join(dir_path, "description")
    evaluation_path = os.path.join(dir_path, "evaluation")
    
    if not os.path.exists(description_path):
        os.makedirs(description_path)
    
    if not os.path.exists(evaluation_path):
        os.makedirs(evaluation_path)
    
    # Create images subdirectory only for questions that need it
    if i in questions_with_images:
        images_path = os.path.join(dir_path, "images")
        if not os.path.exists(images_path):
            os.makedirs(images_path)
            print(f"  - Created images directory for question {i}")

print(f"\nDirectory structure created for all 25 correlation exercises!")
print(f"Questions with images subdirectories: {questions_with_images}")