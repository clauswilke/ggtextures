#' Textured bars
#'
#' `geom_textured_bar()` and `geom_textured_col()` are equivalent to
#' [`geom_bar()`] and [`geom_col()`] but draw textured columns just like
#' `geom_textured_rect()` does.
#' @inheritParams ggplot2::geom_bar
#' @examples
#' library(ggplot2)
#' library(tibble)
#'
#' # textured columns
#' df <- tibble(
#'   trt = c("a", "b", "c"),
#'   outcome = c(2.3, 1.9, 3.2),
#'   image = c(
#'     "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/rocks2-256.jpg",
#'     "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/stone2-256.jpg",
#'     "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/siding1-256.jpg"
#'   )
#' )
#'
#' ggplot(df, aes(trt, outcome, image = image)) +
#'   geom_textured_col()
#'
#' # textured bars
#' images = c(
#'   compact = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/rocks2-256.jpg",
#'   midsize = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/stone2-256.jpg",
#'   suv = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/siding1-256.jpg",
#'   `2seater` = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/mulch1-256.jpg",
#'   minivan = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/rocks1-256.jpg",
#'   pickup = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/wood3-256.jpg",
#'   subcompact = "http://www.hypergridbusiness.com/wp-content/uploads/2012/12/concrete1-256.jpg"
#' )
#'
#' ggplot(mpg, aes(class, image = class)) +
#'   geom_textured_bar() +
#'   scale_image_manual(values = images)
#'
#' ggplot(mpg, aes(factor(trans), image = class)) +
#'   geom_textured_bar() +
#'   scale_image_manual(values = images)
#' @export
geom_textured_bar <- function(mapping = NULL, data = NULL,
                              stat = "count", position = "stack",
                              ...,
                              width = NULL,
                              na.rm = FALSE,
                              show.legend = NA,
                              inherit.aes = TRUE) {

  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTexturedBar,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      width = width,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_textured_bar
#' @export
geom_textured_col <- function(mapping = NULL, data = NULL,
                              stat = "identity", position = "stack",
                              ...,
                              width = NULL,
                              na.rm = FALSE,
                              show.legend = NA,
                              inherit.aes = TRUE) {

  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTexturedCol,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      width = width,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_textured_bar
#' @format NULL
#' @usage NULL
#' @export
#' @include geom-textured-rect.R
GeomTexturedBar <- ggproto("GeomTexturedBar", GeomTexturedRect,
  default_aes = aes(
    colour = "black", fill = "grey85", size = 0.5, linetype = 1, alpha = NA,
    hjust = 0.5, vjust = 0
  ),

  required_aes = c("x", "image"),

  # These aes columns are created by setup_data(). They need to be listed here so
  # that GeomTexturedRect$handle_na() properly removes any bars that fall outside the defined
  # limits, not just those for which x and y are outside the limits
  non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

  extra_params = c("na.rm", "width"),

  setup_data = function(data, params) {
    data$width <- data$width %||%
      params$width %||% (resolution(data$x, FALSE) * 0.9)
    transform(data,
              ymin = pmin(y, 0), ymax = pmax(y, 0),
              xmin = x - width / 2, xmax = x + width / 2, width = NULL
    )
  }
)


#' @rdname geom_textured_bar
#' @format NULL
#' @usage NULL
#' @export
#' @include geom-textured-rect.R
GeomTexturedCol <- ggproto("GeomTexturedCol", GeomTexturedRect,
  default_aes = aes(
    colour = "black", fill = "grey85", size = 0.5, linetype = 1, alpha = NA,
    hjust = 0.5, vjust = 0
  ),

  required_aes = c("x", "y", "image"),

  # These aes columns are created by setup_data(). They need to be listed here so
  # that GeomTexturedRect$handle_na() properly removes any bars that fall outside the defined
  # limits, not just those for which x and y are outside the limits
  non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

  extra_params = c("na.rm", "width"),

  setup_data = function(data, params) {
    data$width <- data$width %||%
      params$width %||% (resolution(data$x, FALSE) * 0.9)
    transform(data,
              ymin = pmin(y, 0), ymax = pmax(y, 0),
              xmin = x - width / 2, xmax = x + width / 2, width = NULL
    )
  }
)
