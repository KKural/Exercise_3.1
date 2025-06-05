context("Multiple choice")

test_that("Correct choice is 2", {
  expect_equal(evalSource(), 2)
})
