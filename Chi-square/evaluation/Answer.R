context({
  testcase(
    " ",
    {
      testEqual(
        " ",
        function(env) {
          # Try to safely convert the student's answer to numeric
          tryCatch({
            answer <- as.numeric(env$evaluationResult)
            # Return TRUE if the answer is within acceptable range
            abs(answer - 11.89) < 0.1  # Allow slight rounding differences
          }, error = function(e) {
            # Handle conversion errors
            FALSE
          })
        },
        TRUE
      )
    }
  )
})