context("Check correct answer for multiple choice")

test_that("Answer must be option 2", {
  expect_equal(eval(parse(text = readLines("main.R"))), 2,
               info = "Incorrect: The main purpose of descriptive statistics is to summarize and describe data.")
})
