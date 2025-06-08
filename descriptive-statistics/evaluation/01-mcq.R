# evaluation/01-descriptive-statistics.R

context({
  testcase(
    "What is the main purpose of descriptive statistics?", 
    {
      testEqual(
        "Answer", 
        function(env) as.numeric(env$evaluationResult),
        2,
        comparator = function(generated, expected, ...) {
          # Map each choice to its feedback
          feedbacks <- list(
            "1" = "❌ Incorrect. That describes *inferential* statistics—predicting future outcomes from a sample.",
            "2" = "✅ Correct! Descriptive statistics *summarize and describe* the main features of collected data.",
            "3" = "❌ Incorrect. Establishing causal relationships requires *inferential* methods like experiments or regression.",
            "4" = "❌ Incorrect. Hypothesis testing about population parameters is part of *inferential* statistics."
          )
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Please enter a number between 1 and 4."
          
          # Push the message into Dodona’s feedback panel
          get_reporter()$add_message(msg, type = "markdown")
          
          # Return TRUE only if they picked the expected answer
          return(generated == expected)
        }
      )
    }
  )
})
