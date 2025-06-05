context("Check correct answer for multiple choice")

test_that("Answer must be option 2", {
  result <- as.integer(evalSource())
  expect_equal(result, 2,
               info = "Incorrect: The main purpose of descriptive statistics is to summarize and describe data.")
})
