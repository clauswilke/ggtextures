unit_type <- NULL
.onLoad <- function(...) {
  if (as.numeric(version$major) >= 4) {
    unit_type <- getFromNamespace("unitType", "grid")
  } else {
    unit_type <- function(x) {
      if (is.unit(x)) {
        unit <- attr(x, "unit", exact = TRUE)
        if (is.null(unit)) {
          # Probably unit arithmetic, return *something* to check against
          return(class(unit))
        } else {
          return(unit)
        }
      } else {
        # This is R4.0 grid::unitType behavior
        stop("Not a unit object")
      }
    }
  }
  utils::assignInMyNamespace("unit_type", unit_type)
}
