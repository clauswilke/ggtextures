# test whether a unit object has unit "null"
is_null_unit <- function(u) {
  if (is.unit(u)) {
    identical(grid::unitType(u), "null")  
  } else {
    FALSE
  }
}

# test whether a unit object has unit "native"
is_native_unit <- function(u) {
  if (is.unit(u)) {
    identical(grid::unitType(u), "native")
  } else {
    FALSE
  }
}