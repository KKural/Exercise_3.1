context({
  library(dslabs)
  data(murders)
})

# context block 2: the actual MCQ
context({
  testcase("Which description is correct?", {
    # `evaluationResult` is the value of the last top-level expression
    # in the student script (so if they write `3`, evaluationResult == 3).
    testEqual(
      "Answer",                       # label shown to student
      function(env) env$evaluationResult,
      2                               # the correct numeric choice
    )
  })
})