test_that("add_stage", {
  pipeline <- add_stage("$match", list(flight=1545))
  expect_s3_class(pipeline, "mongopipe")
  expect_equal(as.character(pipeline), "[{\"$match\":{\"flight\":1545}}]")
})

test_that("match", {
  pipe_match <- match(mongopipe(), dest="ABQ")
  expect_snapshot_output(cat(pipe_match))
})

test_that("pipe", {

  pipe <- mongopipe() %>%
    match(faa="ABQ") %>%
    lookup(from = "test_flights",
           local_field = "faa",
           foreign_field = "dest") %>%
    unwind(field = "test_flights")

  expect_snapshot_output(cat(pipe))

  pipe2 <- mongopipe() %>%
    match(tzone="America/New_York") %>%
    lookup(from = "test_flights",
           local_field = "faa",
           foreign_field = "dest") %>%
    field(min_distance = list("$min"="$test_flights.distance")) %>%
    match(min_distance=list("$ne"=NA)) %>%
    project("min_distance"=1, "faa"=1) %>%
    limit(3)

  expect_snapshot_output(cat(pipe2))

})


