# evaluation/01-variables.R

context({
  # (OPTIONAL) any setup you _do_ still need:
  # library(dslabs)
  # data(murders)

  testcase("Which description is correct?", {
    answer <- as.character(evaluationResult)

    fb <- list(
      "1" = list(correct=FALSE,
                 msg="❌ Incorrect. That’s inferential statistics: predicting outcomes from a sample.",
                 concept="Descriptive stats instead *describe* and *summarize* existing data."),
      "2" = list(correct=TRUE,
                 msg="✅ Correct! Descriptive statistics summarize and describe the data’s main features.",
                 concept="Think of mean, median, mode, frequency tables and basic plots."),
      "3" = list(correct=FALSE,
                 msg="❌ Nope. Causal relationships are established by inferential methods (experiments, regression, etc.).",
                 concept="Descriptive methods can show correlation, but not causation."),
      "4" = list(correct=FALSE,
                 msg="❌ No. Hypothesis testing about population parameters belongs to inferential statistics.",
                 concept="E.g. t-tests, confidence intervals, ANOVA all live in the inferential camp.")
    )

    if (!answer %in% names(fb)) {
      stop("Please enter a number between 1 and 4.")
    }
    this <- fb[[answer]]

    if (!this$correct) {
      stop(this$msg, "\n\n", this$concept,
           "\n\n👉 The correct answer is: 2")
    }

    # on correct
    message(this$msg)
    message(this$concept)
  })
})
