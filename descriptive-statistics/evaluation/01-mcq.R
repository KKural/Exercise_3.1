context({
  testcase("Which description is correct?", {
    # Get the student's answer
    answer <- function(env) env$evaluationResult
    
    # Test if the answer is correct (2)
    testEqual(
      "Answer",                       # label shown to student
       function(env) env$evaluationResult,
      2                               # the correct numeric choice
    )
    
    # Provide specific feedback based on the answer
    testFeedback(
      function(env) {
        student_answer <- answer(env)
        if (student_answer == 1) {
          return("Incorrect. This describes inferential statistics, which predict future outcomes based on sample data.")
        } else if (student_answer == 2) {
          return("Correct! Descriptive statistics summarize and describe the main features of collected data.")
        } else if (student_answer == 3) {
          return("Incorrect. Establishing causal relationships is typically done through inferential statistics.")
        } else if (student_answer == 4) {
          return("Incorrect. Testing hypotheses about population parameters is the main purpose of inferential statistics.")
        } else {
          return("Please enter a number between 1 and 4.")
        }
      }
    )
    
    # Add more detailed explanation for educational purposes
    testFeedback(
      function(env) {
        student_answer <- answer(env)
        if (student_answer == 1) {
          return("Inferential statistics involves making predictions or inferences about a population based on observations of a sample.")
        } else if (student_answer == 2) {
          return("Descriptive statistics help us understand what the data shows us through measures like mean, median, mode, and visualizations.")
        } else if (student_answer == 3) {
          return("While descriptive statistics can show correlations, establishing causation requires inferential methods and experimental design.")
        } else if (student_answer == 4) {
          return("Hypothesis testing uses sample data to make inferences about populations, which is inferential statistics.")
        } else {
          return("")
        }
      }
    )
  })
})