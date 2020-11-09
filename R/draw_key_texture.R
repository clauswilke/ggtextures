#' Key drawing function for textured rectangles
#'
#' @inheritParams ggplot2::draw_key_polygon
#' @export
draw_key_texture <- function(data, params, size) {
  lwd <- min(data$size, min(size) / 4)

  tg_args <- list(
    img = get_raster_image(data$image),
    x = unit(0.5, "npc"), y = unit(0.5, "npc"),
    width = unit(1, "npc") - unit(lwd, "mm"),
    height = unit(1, "npc") - unit(lwd, "mm"),
    img_width = unit(1, "null"),
    img_height = NULL,
    nrow = 1,
    ncol = 1,
    hjust = data$hjust,
    vjust = data$vjust,
    just = c(0.5, 0.5),
    color = data$colour,
    fill = scales::alpha(data$fill, data$alpha),
    lwd = lwd * .pt,
    lty = data$linetype,
  )

  if (!is.null(params$legend_key_params)) {
    tg_args <- modifyList(tg_args, params$legend_key_params, keep.null = TRUE)
  }

  do.call(texture_grob, tg_args)
}
