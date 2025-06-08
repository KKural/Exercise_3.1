context({
  testcase("Which description is correct?", {
    # Get the student's answer in a separate variable for clarity
    testcase("Get student answer", {
      student_answer <- testRun({
        get("evaluationResult", envir = .GlobalEnv)
      })
    })
    
    # Test if answer is correct
    testEqual("Answer", function() student_answer, 2)
    
    # Provide feedback based on the answer
    testcase("Providing feedback", {
      testRun({
        if (student_answer == 1) {
          cat("Incorrect. This describes inferential statistics, which predict future outcomes based on sample data.")
        } else if (student_answer == 2) {
          cat("Correct! Descriptive statistics summarize and describe the main features of collected data.")
        } else if (student_answer == 3) {
          cat("Incorrect. Establishing causal relationships is typically done through inferential statistics.")
        } else if (student_answer == 4) {
          cat("Incorrect. Testing hypotheses about population parameters is the main purpose of inferential statistics.")
        } else {
          cat("Please enter a number between 1 and 4.")
        }
      })
    })
  })
})