#' Mongopipe
#'
#' @return Object of type mongopipe.
#' @rdname mongopipe-function
#' @export
mongopipe <- function() {
  structure("{}", class=c("character","mongopipe"), pipe=list())
}


#' Create or append a mongo aggregation stage
#' @param x Object of class mongo or mongo_pipe
#' @param type Name of the stage.
#' @param ... query
#'
#' @return Object of type mongopipe.
#'
#' @export
add_stage <- function(x, ...) {
  UseMethod("add_stage")
}

#' @rdname add_stage
#' @export
add_stage.default <- function(x, ...) {
  add_stage(mongopipe(), type=x, ...)
}

#' @rdname add_stage
#' @export
add_stage.mongopipe <- function(x, type, ...) {
  if (missing(type)) {
    abort("`type` has to be specified")
  }
  if (missing(..1)) {
    abort("further arguments have to be passed to `...`")
  }
  query <- check_query(...)
  new_pipe <- list()
  new_pipe[[type]] <- query
  pipe <- attr(x, "pipe")
  pipe[[length(pipe) + 1]] <-  new_pipe
  structure(toJSON(pipe), class=c("character","mongopipe"), pipe=pipe)
}

#' @importFrom jsonlite unbox
check_query <- function(query) {

  if (!is.list(query)) {
    return(unbox(query))
  }

  if (is.null(query)) {
    return(unbox(query))
  }

  if(!all(names(query) != "") || is.null(names(query))) {
    abort("all elements in query should have names!")
  }

  for (n in names(query)) {
    if (!is.list(query[[n]]) && length(query[[n]]) == 1) {
      query[[n]] <- unbox(query[[n]])
    } else if (is.list(query[[n]])) {
      query[[n]] <- check_query(query[[n]])
    }
  }
  return(query)
}
