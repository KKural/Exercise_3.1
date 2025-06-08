context({
  # load any packages or data you need
  library(dslabs)
  data(murders)
}, preExec = {
  # (optional) code to run before student script
})

context({
  testcase("Which description is correct?", {
    # `evaluationResult` holds the value of the last expression in the student script
    testEqual(
      "Answer",                                # shown to the student
      function(env) env$evaluationResult,       # extract result
      3                                          # expected numeric value
    )
  })
})
