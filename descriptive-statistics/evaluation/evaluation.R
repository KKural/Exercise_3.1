#' @param solution The student's solution as text
check <- function(solution) {
  # Trim whitespace and get the first non-comment line
  lines <- strsplit(solution, "\n")[[1]]
  lines <- lines[!grepl("^\\s*#", lines)]  # Remove comment lines
  lines <- lines[nzchar(trimws(lines))]    # Remove empty lines
  
  if (length(lines) == 0) {
    return(list(
      accepted = FALSE,
      messages = list("No answer provided. Please type a number (1-4).")
    ))
  }
  
  # Get the first answer
  answer <- trimws(lines[1])
  
  # Check the answer
  if (answer == "2") {
    return(list(
      accepted = TRUE,
      messages = list("Correct! Descriptive statistics summarize and describe the main features of collected data.")
    ))
  } else if (answer == "1") {
    return(list(
      accepted = FALSE,
      messages = list("Incorrect. Predicting future outcomes belongs to inferential statistics, not descriptive.")
    ))
  } else if (answer == "3") {
    return(list(
      accepted = FALSE,
      messages = list("Incorrect. Establishing causal relationships belongs to inferential statistics, not descriptive.")
    ))
  } else if (answer == "4") {
    return(list(
      accepted = FALSE,
      messages = list("Incorrect. Testing hypotheses belongs to inferential statistics, not descriptive.")
    ))
  } else {
    return(list(
      accepted = FALSE,
      messages = list(paste0("\"", answer, "\" is not a valid answer. Please enter a number between 1 and 4."))
    ))
  }
}
