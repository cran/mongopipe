test_that("print.mongopipe", {
  expect_output(print(mongopipe()), "\\[\\s*\\]")
})
