#' Isotype bars
#'
#' `geom_isotype_bar()` and `geom_isotype_col()` are equivalent to
#' [`geom_bar()`] and [`geom_col()`] but draw columns with unit images.
#' These two geoms are essentially identical to `geom_textured_bar()` and
#' `geom_textured_col()`, they just have slightly different default settings.
#' @inheritParams ggplot2::geom_bar
#' @inheritParams geom_textured_rect
#' @param img_height Height of the isotype image, in grid units. Should
#'   be provided in `"native"` units, which are converted to data units.
#'   If `NULL`, the image height is taken from the image width and the image
#'   aspect ratio.
#' @param img_width Width of the isotype image, in grid units. Should
#'   be provided in `"native"` units, which are converted to data units.
#'   If `NULL`, the image width is taken from the image height and the image
#'   aspect ratio.
#' @param ncol Number of image columns. If `NA`, is calculated based on the
#'   data extent.
#' @param nrow Number of image rows. If `NA`, is calculated based on the
#'   data extent.
#' @examples
#' library(ggplot2)
#' library(tibble)
#' library(magick)
#'
#' data <- tibble(
#'   count = c(5, 3, 6),
#'   animal = c("giraffe", "elephant", "horse"),
#'   image = list(
#'     image_read_svg("http://steveharoz.com/research/isotype/icons/giraffe.svg"),
#'     image_read_svg("http://steveharoz.com/research/isotype/icons/elephant.svg"),
#'     image_read_svg("http://steveharoz.com/research/isotype/icons/horse.svg")
#'   )
#' )
#'
#' ggplot(data, aes(animal, count, image = image)) +
#'   geom_isotype_col() +
#'   theme_minimal()
#'
#' ggplot(data, aes(animal, count, image = image)) +
#'   geom_isotype_col(
#'     img_width = grid::unit(1, "native"), img_height = NULL,
#'     ncol = NA, nrow = 1, hjust = 0, vjust = 0.5, fill = "#80808040"
#'   ) +
#'   coord_flip() +
#'   theme_minimal()
#' @export
geom_isotype_bar <- function(mapping = NULL, data = NULL,
                             stat = "count", position = "stack",
                             ...,
                             img_height = grid::unit(1, "native"),
                             img_width = NULL,
                             ncol = 1, nrow = NA,
                             legend_key_params = NULL,
                             width = NULL,
                             na.rm = FALSE,
                             show.legend = NA,
                             inherit.aes = TRUE) {

  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomIsotypeBar,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      width = width,
      na.rm = na.rm,
      img_height = img_height,
      img_width = img_width,
      ncol = ncol,
      nrow = nrow,
      legend_key_params = legend_key_params,
      ...
    )
  )
}

#' @rdname geom_isotype_bar
#' @export
geom_isotype_col <- function(mapping = NULL, data = NULL,
                             stat = "identity", position = "stack",
                             ...,
                             img_height = grid::unit(1, "native"),
                             img_width = NULL,
                             ncol = 1, nrow = NA,
                             legend_key_params = NULL,
                             width = NULL,
                             na.rm = FALSE,
                             show.legend = NA,
                             inherit.aes = TRUE) {

  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomIsotypeCol,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      width = width,
      na.rm = na.rm,
      img_height = img_height,
      img_width = img_width,
      ncol = ncol,
      nrow = nrow,
      legend_key_params = legend_key_params,
      ...
    )
  )
}


#' @rdname geom_isotype_bar
#' @format NULL
#' @usage NULL
#' @export
#' @include geom-textured-bar.R
GeomIsotypeBar <- ggproto("GeomIsotypeBar", GeomTexturedBar,
  default_aes = aes(
    colour = NA, fill = NA, size = 0.5, linetype = 1, alpha = NA,
    hjust = 0.5, vjust = 0
  )
)

#' @rdname geom_isotype_bar
#' @format NULL
#' @usage NULL
#' @export
#' @include geom-textured-bar.R
GeomIsotypeCol <- ggproto("GeomIsotypeCol", GeomTexturedCol,
  default_aes = aes(
    colour = NA, fill = NA, size = 0.5, linetype = 1, alpha = NA,
    hjust = 0.5, vjust = 0
  )
)
