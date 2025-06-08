# evaluation/03-histogram-skewness.R

context({
  testcase(
    paste0(
      "."
    ),
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Not quite. The long tail extends toward the younger ages on the left side, so it’s left-skewed, not right-skewed.",
            "2" = "❌ Incorrect. The histogram is asymmetric—one tail is longer—so it’s not symmetric.",
            "3" = "✅ Correct! The histogram shows a longer tail to the left, indicating a strong left-skew.",
            "4" = "❌ Nope. There’s only one peak, so the distribution is not bimodal."
          )
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Please enter a number between 1 and 4."
          get_reporter()$add_message(msg, type = "markdown")
          return(generated == expected)
        }
      )
    }
  )
})
