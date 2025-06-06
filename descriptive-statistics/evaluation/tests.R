library(testthat)

# Set up the context
context("MCQ Answer")

# Get student's answer
tryCatch({
  student_code <- readLines("../solution/solution.R")
  
  # Remove comments and whitespace
  student_code <- student_code[!grepl("^\\s*#", student_code)]
  student_code <- student_code[nzchar(trimws(student_code))]
  
  # Extract the answer (just a number)
  if (length(student_code) > 0) {
    student_answer <- trimws(student_code[1])
  } else {
    student_answer <- ""
  }
  
  # Test the answer
  test_that("Answer is correct", {
    expect_equal(student_answer, "2", 
                info = "Incorrect. The main purpose of descriptive statistics is to summarize and describe the main features of collected data.")
  })
  
  # Provide specific feedback for wrong answers
  if (student_answer == "1") {
    test_that("Wrong answer feedback", {
      fail("Incorrect. Predicting future outcomes is a characteristic of inferential statistics, not descriptive.")
    })
  } else if (student_answer == "3") {
    test_that("Wrong answer feedback", {
      fail("Incorrect. Establishing causal relationships is a characteristic of inferential statistics, not descriptive.")
    })
  } else if (student_answer == "4") {
    test_that("Wrong answer feedback", {
      fail("Incorrect. Testing hypotheses about population parameters is a characteristic of inferential statistics, not descriptive.")
    })
  } else if (student_answer != "2") {
    test_that("Invalid answer feedback", {
      fail(paste("Invalid answer:", student_answer, "- Please enter a number between 1 and 4."))
    })
  }
}, error = function(e) {
  test_that("Error handling", {
    fail("Error reading your answer. Please make sure you've entered a number between 1 and 4.")
  })
})
