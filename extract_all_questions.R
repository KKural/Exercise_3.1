# Extract all 25 questions from R Markdown and create Dodona exercises
# This script reads the correlation questions and creates all necessary files

library(stringr)

# Read the R Markdown file
rmd_content <- readLines("All quesion/20251022_correlation_exercise.Rmd")

# Helper function to extract question content between two patterns
extract_question <- function(content, start_pattern, end_pattern) {
  start_idx <- grep(start_pattern, content)
  if (length(start_idx) == 0) return(NULL)
  
  end_idx <- grep(end_pattern, content)
  end_idx <- end_idx[end_idx > start_idx[1]][1]
  
  if (is.na(end_idx)) end_idx <- length(content)
  
  return(content[(start_idx[1]):(end_idx-1)])
}

# Question directories and titles
question_dirs <- list(
  "1" = list(dir = "3.1 Correlatie - Wat is correlatie", title = "3.1 Correlatie - Wat is correlatie?"),
  "2" = list(dir = "3.2 Correlatie - Wat is een z-score", title = "3.2 Correlatie - Wat is een z-score?"),
  "3" = list(dir = "3.3 Correlatie - Belangrijkste maatregelen", title = "3.3 Correlatie - Belangrijkste maatregelen?"),
  "4" = list(dir = "3.4 Correlatie - Centrum in z-Scores", title = "3.4 Correlatie - Centrum in z-Scores?"),
  "5" = list(dir = "3.5 Correlatie - Eenheden veranderen niet r", title = "3.5 Correlatie - Eenheden veranderen niet r?"),
  "6" = list(dir = "3.6 Correlatie - Variabeletypen", title = "3.6 Correlatie - Variabeletypen?"),
  "7" = list(dir = "3.7 Correlatie - Correlatie vs causaliteit", title = "3.7 Correlatie - Correlatie vs causaliteit?"),
  "8" = list(dir = "3.8 Correlatie - Interpreteer correlatie", title = "3.8 Correlatie - Interpreteer correlatie?"),
  "9" = list(dir = "3.9 Correlatie - Wat correlatie vertelt", title = "3.9 Correlatie - Wat correlatie vertelt?"),
  "10" = list(dir = "3.10 Correlatie - Covariantie versus correlatie", title = "3.10 Correlatie - Covariantie versus correlatie?"),
  "11" = list(dir = "3.11 Correlatie - Visualisatie belang", title = "3.11 Correlatie - Visualisatie belang?"),
  "12" = list(dir = "3.12 Correlatie - Covariantie verschillen", title = "3.12 Correlatie - Covariantie verschillen?"),
  "13" = list(dir = "3.13 Correlatie - Misleidende correlatie", title = "3.13 Correlatie - Misleidende correlatie?"),
  "14" = list(dir = "3.14 Correlatie - Pearson vs Spearman", title = "3.14 Correlatie - Pearson vs Spearman?"),
  "15" = list(dir = "3.15 Correlatie - Richting en kracht", title = "3.15 Correlatie - Richting en kracht?"),
  "16" = list(dir = "3.16 Correlatie - Zwak positief", title = "3.16 Correlatie - Zwak positief?"),
  "17" = list(dir = "3.17 Correlatie - Correlatie types", title = "3.17 Correlatie - Correlatie types?"),
  "18" = list(dir = "3.18 Correlatie - Wanneer welke correlatie", title = "3.18 Correlatie - Wanneer welke correlatie?"),
  "19" = list(dir = "3.19 Correlatie - Impact uitschieters", title = "3.19 Correlatie - Impact uitschieters?"),
  "20" = list(dir = "3.20 Correlatie - Standardisatie nodig", title = "3.20 Correlatie - Standardisatie nodig?"),
  "21" = list(dir = "3.21 Correlatie - Correlatie interpretatie", title = "3.21 Correlatie - Correlatie interpretatie?"),
  "22" = list(dir = "3.22 Correlatie - Statistische claims", title = "3.22 Correlatie - Statistische claims?"),
  "23" = list(dir = "3.23 Correlatie - Correlatie aannames", title = "3.23 Correlatie - Correlatie aannames?"),
  "24" = list(dir = "3.24 Correlatie - Onderzoek ontwerpen", title = "3.24 Correlatie - Onderzoek ontwerpen?"),
  "25" = list(dir = "3.25 Correlatie - Hypothese opstellen", title = "3.25 Correlatie - Hypothese opstellen?")
)

# Questions with images
questions_with_images <- c(3, 8, 9, 12, 14, 15, 18, 19, 21, 23)

# Function to create description file
create_description <- function(question_text, question_num) {
  # Extract just the question title and options
  # Remove the R chunk and complex formatting
  lines <- question_text
  
  # Find question title
  title_line <- grep("\\*\\*.*\\*\\*", lines)[1]
  if (!is.na(title_line)) {
    title <- gsub("\\*\\*|###.*", "", lines[title_line])
    title <- str_trim(title)
  } else {
    title <- paste("Question", question_num)
  }
  
  # Find hint
  hint_line <- grep("> \\*\\*Hint", lines)
  hint <- ""
  if (length(hint_line) > 0) {
    hint <- lines[hint_line[1]]
    hint <- gsub("> \\*\\*Hint:\\*\\*|> \\*\\*Hint:", "> **Hint:**", hint)
  }
  
  # Extract options (numbered 1-4)
  option_lines <- grep("^[1-4]\\)", lines)
  options <- c()
  if (length(option_lines) >= 4) {
    for (i in 1:4) {
      option_text <- lines[option_lines[i]]
      option_text <- gsub("^[1-4]\\) ", paste0(i, ". "), option_text)
      options <- c(options, option_text)
    }
  }
  
  # Combine everything
  description <- c(
    title,
    "",
    hint,
    "",
    options,
    "",
    "Typ je antwoord als één enkel getal (1-4) om je keuze aan te geven."
  )
  
  # Add image reference for questions with images
  if (question_num %in% questions_with_images) {
    description <- c(
      description[1:2],
      paste0("![Visualisatie](images/question_3.", question_num, ".png)"),
      "",
      description[3:length(description)]
    )
  }
  
  return(description)
}

print("Starting extraction of all 25 questions...")
print("This will create description files for all exercises.")

# For now, let's just create a sample of the first few to test the approach
cat("Question extraction script ready. Will create systematic extraction next.\n")