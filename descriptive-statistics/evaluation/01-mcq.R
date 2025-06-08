# evaluation/01-variables.R
context({
  testcase("Which description is correct?", {
    # grab the bare number they wrote
    answer <- as.numeric(evaluationResult)

    if (answer == 2) {
      # correct: let the test pass, but show two lines of praise
      message("✅ Correct! Descriptive statistics summarize and describe the main features of collected data.")
      message("Concept: think mean, median, mode and simple plots.")
    } else if (answer %in% 1:4) {
      # wrong: throw an error, which Dodona shows as the failure reason
      stop(
        switch(
          as.character(answer),
          "1" = "❌ Incorrect. That describes inferential statistics.",
          "3" = "❌ Nope. Causal relationships need inferential methods.",
          "4" = "❌ Not quite. Hypothesis testing is inferential."
        ),
        "\n\nThe correct answer is 2."
      )
    } else {
      stop("Please enter a number between 1 and 4.")
    }
  })
})
