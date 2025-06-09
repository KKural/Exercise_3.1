# evaluation/01-level-of-measurement.R

context({
  testcase(
    "",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,
        comparator = function(generated, expected, ...) {
          # Map each choice to its feedback
          feedbacks <- list(
            "1" = "✅ Correct! “Type of crime” is a *nominal* variable—categories without any order.",
            "2" = "❌ Incorrect. Ordinal implies a natural order/ranking, which “Type of crime” lacks.",
            "3" = "❌ Incorrect. Interval scales have equal distances between values; “Type of crime” isn’t numeric.",
            "4" = "❌ Incorrect. Ratio scales have a meaningful zero point; “Type of crime” doesn’t."
          )
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Please enter a number between 1 and 4."

          # Emit the feedback in Dodona
          get_reporter()$add_message(msg, type = "markdown")

          # Return TRUE only if they picked the expected answer
          return(generated == expected)
        }
      )
    }
  )
})
