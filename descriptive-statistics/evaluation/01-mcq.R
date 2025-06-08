context({
  testcase("Which description is correct?", {
    testEqual(
      "Answer", 
      function(env) env$evaluationResult,
      3,
      comparator = function(generated, expected, ...) {
        # if they’re wrong, add a tailored hint
        if (!identical(generated, expected)) {
          wrong_msg <- switch(
            as.character(generated),
            "1" = "❌ No—option 1 describes inferential statistics (predicting future outcomes).",
            "2" = "❌ Nope—option 2 is also inferential: hypothesis testing.",
            "4" = "❌ Not quite—option 4 is about inferential hypothesis tests.",
            "❌ That’s not one of the choices; pick 1–4."
          )
          get_reporter()$add_message(wrong_msg, type = "markdown")
        } else {
          # if they’re right, add a friendly confirmation
          get_reporter()$add_message(
            "✅ Correct! Descriptive statistics summarize and describe the main features of collected data.",
            type = "markdown"
          )
        }
        # return TRUE only if matches, otherwise FALSE
        generated == expected
      }
    )
  })
})
