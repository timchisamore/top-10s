#' Creating Age Group
#'
#' This function takes the age field from raw IntelliHealth data and
#' returns age groups of 0-14, 15-44, 45-64, 65-74, 75-84, and 85+.
#'
#' @param age a numeric age variable from raw IntelliHealth data
#'
#' @return a character age group
#' @export
#'
#' @examples
#' creating_age_group(age)
creating_age_group <- function(age) {
  age_group <- santoku::chop(
    x = age,
    breaks = c(15, 45, 65, 75, 85, Inf),
    labels = c("0-14", "15-44", "45-64", "65-74", "75-84", "85+")
  )

  return(age_group)
}
