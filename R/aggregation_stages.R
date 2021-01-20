#' Pipeline Stages
#'
#' These functions translate R code to json readably by Mongodb.
#'
#' @param x Object of class `mongopipe`
#' @param ... list object
#'
#' @return Object of type mongopipe.
#'
#' @export
match <- function(x, ...) {
  UseMethod("match")
}

#' @rdname match
#' @export
match.mongopipe <- function(x, ...) {
  add_stage(x, "$match", list(...))
}

#' @rdname match
#' @export
field <-function(x, ...) {
  UseMethod("field")
}

#' @rdname match
#' @export
field.mongopipe <- function(x, ...) {
  add_stage(x, "$addFields", list(...))
}

#' @rdname match
#'
#' @param from Collection to join
#' @param local_field Field from the input documents
#' @param foreign_field Field from the documents of the "from" collection
#' @param as Name of output array field (Default: `from`)
#'
#' @export
lookup <-function(x, ...) {
  UseMethod("lookup")
}
#' @rdname match
#' @export
lookup.mongopipe <- function(x,
                             from,
                             local_field=from,
                             foreign_field="_id",
                             as=from,
                             ...) {

  add_stage(x,
            "$lookup",
            list(from=from,
                 localField=local_field,
                 foreignField=foreign_field,
                 as=as))
}

#' @rdname match
#' @export
unwind <-function(x, ...) {
  UseMethod("unwind")
}

#' @rdname match
#'
#' @param field Field to unwind.
#'
#' @export
unwind.mongopipe <- function(x, field, ...) {
  if(!grepl("^\\$.*", field, perl = T)) {
    field <- paste0("$", field)
  }
  add_stage(x, "$unwind", field)
}

#' @rdname match
#' @export
limit <-function(x, ...) {
  UseMethod("limit")
}

#' @rdname match
#'
#' @param limit Integer to limit the number of documents.
#'
#' @export
limit.mongopipe <- function(x, limit, ...) {
  add_stage(x, "$limit", limit)
}

#' @rdname match
#' @export
project <-function(x, ...) {
  UseMethod("project")
}

#' @rdname match
#' @export
project.mongopipe <- function(x, ...) {
  add_stage(x, "$project", list(...))
}

