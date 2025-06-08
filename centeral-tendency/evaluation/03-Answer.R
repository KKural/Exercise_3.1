# evaluation/02‐measures‐central‐tendency.R

context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # the correct choice: median (85) > mean (~83.91)
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Incorrect. Actually, the mean (~83.9) is *less* than the median (85).",
            "2" = "✅ Correct! The median (85) exceeds the mean (~83.9).",
            "3" = "❌ Nope. The mode (85) equals the median, so it’s not strictly greater than the mean.",
            "4" = "❌ Not quite. The mean, median, and mode aren’t all equal—the mean is a bit lower."
          )
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Please enter a number between 1 and 4."
          
          # Push the custom message into Dodona’s feedback panel
          get_reporter()$add_message(msg, type = "markdown")
          
          # Return TRUE only if they picked the expected answer
          generated == expected
        }
      )
    }
  )
})
