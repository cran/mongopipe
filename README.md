
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mongopipe

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/mongopipe)](https://CRAN.R-project.org/package=mongopipe)
<!-- badges: end -->

The goal of mongopipe is to have a simple translator for R code into
json based queries for Mongodb.

## Installation

You can install the released version of mongopipe from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("mongopipe")
```

or install the development version of mongopipe on
[gitlab](https://gitlab.com/rpkgs/mongopipe) with:

``` r
remotes::install_gitlab("illoRocks/mongopipe")
```

## Example

``` r
library(mongopipe)
library(mongolite)
library(nycflights13)

m_flights <- mongo("test_flights", verbose = FALSE)
m_airports <- mongo("test_airports", verbose = FALSE)

if(!m_flights$count())
  m_flights$insert(flights)

if(!m_airports$count())
  m_airports$insert(airports)

result <- mongopipe() %>%
  match(faa="ABQ") %>%
  lookup(from = "test_flights", local_field = "faa", foreign_field = "dest") %>%
  unwind(field = "test_flights") %>%
  project(air_time="$test_flights.air_time", dep_delay="$test_flights.dep_delay", origin="$test_flights.origin") %>%
  m_airports$aggregate()

head(result)
#>                        _id air_time dep_delay origin
#> 1 5fe23ddb5a72ab3dc0076731      230        -6    JFK
#> 2 5fe23ddb5a72ab3dc0076731      238         9    JFK
#> 3 5fe23ddb5a72ab3dc0076731      251        -6    JFK
#> 4 5fe23ddb5a72ab3dc0076731      257        16    JFK
#> 5 5fe23ddb5a72ab3dc0076731      242         0    JFK
#> 6 5fe23ddb5a72ab3dc0076731      240        -2    JFK
```

``` r
pipe <- mongopipe() %>%
  match(faa="ABQ") %>%
  lookup(from = "test_flights", local_field = "faa", foreign_field = "dest") %>%
  unwind(field = "test_flights") %>%
  project(air_time="$test_flights.air_time", dep_delay="$test_flights.dep_delay", origin="$test_flights.origin")

print(pipe, pretty = 4)
#> [
#>     {
#>         "$match": {
#>             "faa": "ABQ"
#>         }
#>     },
#>     {
#>         "$lookup": {
#>             "from": "test_flights",
#>             "localField": "faa",
#>             "foreignField": "dest",
#>             "as": "test_flights"
#>         }
#>     },
#>     {
#>         "$unwind": "$test_flights"
#>     },
#>     {
#>         "$project": {
#>             "air_time": "$test_flights.air_time",
#>             "dep_delay": "$test_flights.dep_delay",
#>             "origin": "$test_flights.origin"
#>         }
#>     }
#> ]
```
