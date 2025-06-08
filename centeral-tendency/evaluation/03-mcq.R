# context block 2: the actual MCQ
context({
  testcase(" ", {
    # `evaluationResult` is the value of the last top-level expression
    # in the student script (so if they write `2`, evaluationResult == 2).
    testEqual(
      " ",                       # label shown to student
      function(env) env$evaluationResult,
      1                               # the correct numeric choice
    )
  })
})
