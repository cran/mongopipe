#' @importFrom jsonlite toJSON
#' @export
print.mongopipe <- function(x, pretty = 2, ...) {
  y <- toJSON(attr(x, "pipe"), pretty = pretty)
  cat(y)
  invisible(x)
}

