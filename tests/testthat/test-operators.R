test_that("condition", {
  cond <- condition(list("$gte"='[ "$qty", 250 ]'), 30, 20)
  expect_equal(as.character(toJSON(cond)),
               '{"$cond":{"if":{"$gte":"[ \\\"$qty\\\", 250 ]"},"then":30,"else":20}}')
})
