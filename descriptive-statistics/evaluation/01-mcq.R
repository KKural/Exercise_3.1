context({
  testcase("Which description is correct?", {
    # Simple equality test
    testEqual("Answer", function(env) env$evaluationResult, 2)
    
    # Add separate test for feedback based on the answer
    testFeedback({
      answer <- get("evaluationResult", envir = .GlobalEnv)
      
      if (answer == 1) {
        commentator <- function() {
          cat("Incorrect. This describes inferential statistics, which predict future outcomes based on sample data.")
        }
      } else if (answer == 2) {
        commentator <- function() {
          cat("Correct! Descriptive statistics summarize and describe the main features of collected data.")
        }
      } else if (answer == 3) {
        commentator <- function() {
          cat("Incorrect. Establishing causal relationships is typically done through inferential statistics.")
        }
      } else if (answer == 4) {
        commentator <- function() {
          cat("Incorrect. Testing hypotheses about population parameters is the main purpose of inferential statistics.")
        }
      } else {
        commentator <- function() {
          cat("Please enter a number between 1 and 4.")
        }
      }
      
      commentator()
    })
  })
})