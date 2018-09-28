#' Image scales
#'
#' @inheritParams ggplot2::scale_discrete_identity
#' @inheritParams ggplot2::scale_discrete_manual
#' @export
scale_image_identity <- function(..., guide = "none", aesthetics = "image")
  scale_discrete_identity(aesthetics, ..., guide = guide)


#' @rdname scale_image_identity
#' @format NULL
#' @usage NULL
#' @export
scale_image_discrete <- scale_image_identity

#' @rdname scale_image_identity
#' @export
scale_image_manual <- function(..., values, aesthetics = "image")
  scale_discrete_manual(aesthetics, ..., values = values)
