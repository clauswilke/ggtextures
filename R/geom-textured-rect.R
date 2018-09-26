#' Textured rectangles
#'
#' `geom_textured_rect()` draws rectangles that are filled with
#' texture images.
#' @inheritParams ggplot2::geom_raster
#' @examples
#' library(ggplot2)
#' library(tibble)
#'
#' data <- tibble(
#'   xmin = c(1, 2.5), ymin = c(1, 1), xmax = c(2, 4), ymax = c(4, 3),
#'   image = list("https://jeroen.github.io/images/Rlogo.png",
#'                "https://jeroen.github.io/images/tiger.svg")
#' )
#'
#' ggplot(data, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, image = image)) +
#'   geom_textured_rect()
#' @export
geom_textured_rect <- function(mapping = NULL, data = NULL,
                               stat = "identity", position = "identity",
                               ...,
                               na.rm = FALSE,
                               show.legend = NA,
                               inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTexturedRect,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_textured_rect
#' @format NULL
#' @usage NULL
#' @export
GeomTexturedRect <- ggproto("GeomTexturedRect",
  Geom,
  default_aes = aes(
    colour = "black", fill = "grey85", size = 0.5, linetype = 1, alpha = NA
  ),

  required_aes = c("xmin", "xmax", "ymin", "ymax", "image"),

  draw_panel = function(self, data, panel_params, coord) {
    if (!coord$is_linear()) {
      warning("geom_textured_rect() does not work with nonlinear coords", call. = FALSE)
    } else {
      coords <- coord$transform(data, panel_params)
      coords$image <- unlist(coords$image)

      grobs <- pmap(
        coords,
        function(xmin, xmax, ymin, ymax, image, colour, alpha, fill, size, linetype, ...) {
          texture_grob(
            magick::image_read(image),
            x = unit(xmin, "native"), y = unit(ymax, "native"),
            width = unit(xmax - xmin, "native"),
            height = unit(ymax - ymin, "native"),
            just = c(0, 1),
            color = colour,
            fill = scales::alpha(fill, alpha),
            lwd = size * .pt,
            lty = linetype
          )
        }
      )
      do.call(gList, grobs)
    }
  },

  draw_key = draw_key_polygon
)
