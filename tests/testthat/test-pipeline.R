test_that("add_stage", {
  expect_error(add_stage(mongopipe()), "type")
  expect_error(add_stage(mongopipe(), "$match"), "...")
})

test_that("check_query", {
  expect_s3_class(check_query(1), c("scalar", "numeric"))
})


