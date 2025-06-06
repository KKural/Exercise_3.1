context("Answer check")

test_that("correct answer", {
  # Get student response 
  student_code <- readLines("../solution/solution.R")
  student_answer <- as.character(eval(parse(text = student_code)))
  
  # Check answer
  expect_equal(student_answer, "2", 
               info = "Incorrect. The main purpose of descriptive statistics is to summarize and describe the main features of collected data.")
  
  # Additional feedback for wrong answers (optional)
  if (student_answer == "1") {
    fail("Predicting future outcomes belongs to inferential statistics, not descriptive.")
  } else if (student_answer == "3") {
    fail("Establishing causal relationships belongs to inferential statistics, not descriptive.")
  } else if (student_answer == "4") {
    fail("Testing hypotheses belongs to inferential statistics, not descriptive.")
  }
})
