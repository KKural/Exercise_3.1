context({
  testcase("Which description is correct?", {
    # Get the student's answer
    student_answer <- function(env) env$evaluationResult
    
    # Test if the answer is correct (2)
    testEqual(
      "Answer",                       # label shown to student
      student_answer,
      2,                              # the correct numeric choice
      # Add feedback message in the same function
      function(message, correct) {
        if (correct) {
          return("Correct! Descriptive statistics summarize and describe the main features of collected data.")
        } else {
          # Get the value from the student's answer
          if (message$generated == "1") {
            return("Incorrect. This describes inferential statistics, which predict future outcomes based on sample data.")
          } else if (message$generated == "3") {
            return("Incorrect. Establishing causal relationships is typically done through inferential statistics.")
          } else if (message$generated == "4") {
            return("Incorrect. Testing hypotheses about population parameters is the main purpose of inferential statistics.")
          } else {
            return("Please enter a number between 1 and 4.")
          }
        }
      }
    )
  })
})