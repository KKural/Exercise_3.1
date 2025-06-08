context({
  testcase("Which statement about the histogram is correct?", {
    # Test the student's answer (assuming correct answer is 3 - left-skewed)
    testEqual(
      "Answer", 
      function(env) env$evaluationResult,
      3                          # The correct numeric choice (left-skewed)
    )
  })
})

context({
  testcase("Feedback on your answer", {
    testRun({
      answer <- get("evaluationResult", envir = .GlobalEnv)
      
      if (answer == 1) {
        cat("Incorrect. In a right-skewed distribution, the tail extends to the right with most values clustered on the left side. This histogram shows the opposite pattern.")
      } else if (answer == 2) {
        cat("Incorrect. A symmetric distribution would have approximately equal distributions on both sides of the center. This histogram clearly has a longer tail on one side.")
      } else if (answer == 3) {
        cat("Correct! This histogram is left-skewed (or negatively skewed). The longer tail extends to the left, with most values clustered on the right side of the distribution.")
      } else if (answer == 4) {
        cat("Incorrect. A bimodal distribution would show two distinct peaks. This histogram has only one primary peak.")
      } else {
        cat("Please enter a number between 1 and 4.")
      }
    })
  })
})