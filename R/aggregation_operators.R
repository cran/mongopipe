#' Conditional expression ($cond)
#'
#' Evaluates a boolean expression to return one
#'  of the two specified return expressions.
#'
#' @param test Expression which returns a boolean value.
#' @param yes Return this if the test returns true.
#' @param no Return this if the test returns false.
#'
#' @examples
#' \dontrun{
#' cond <- condition(test = list("$isArray"="$chart"),
#'                   yes = list("$size"="$chart"),
#'                   no = 0)
#' jsonlite::toJSON(cond)
#' }
#'
#' @return Return a list for using in mongopipe.
#'
#' @export
condition <- function(test, yes, no) {
  query <- check_query(list("if"=test, "then"=yes, "else"=no))
  list("$cond" = query)
}
