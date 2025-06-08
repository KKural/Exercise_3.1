context({
  testcase("Which description is correct?", {
    # Simple equality test with feedback in the callback function
    testEqual(
      "Answer", 
      function(env) {
        # Get student answer
        answer <- env$evaluationResult
        
        # Provide feedback based on the answer
        if (answer == 1) {
          feedback <- "Incorrect. This describes inferential statistics, which predict future outcomes based on sample data."
          cat(feedback)
        } else if (answer == 2) {
          feedback <- "Correct! Descriptive statistics summarize and describe the main features of collected data."
          cat(feedback)
        } else if (answer == 3) {
          feedback <- "Incorrect. Establishing causal relationships is typically done through inferential statistics."
          cat(feedback)
        } else if (answer == 4) {
          feedback <- "Incorrect. Testing hypotheses about population parameters is the main purpose of inferential statistics."
          cat(feedback)
        } else {
          feedback <- "Please enter a number between 1 and 4."
          cat(feedback)
        }
        
        # Return the student's answer for evaluation
        return(answer)
      }, 
      2  # The correct answer is 2
    )
  })
})