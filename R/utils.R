# test whether a unit object has unit "null"
is_null_unit <- function(u) {
  if (is.unit(u)) {
    identical(attr(u, "unit"), "null")
  } else {
    FALSE
  }
}


# test whether a unit object has unit "native"
is_native_unit <- function(u) {
  if (is.unit(u)) {
    identical(attr(u, "unit"), "native")
  } else {
    FALSE
  }
}


