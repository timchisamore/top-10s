#' Creating sex
#'
#' This function takes sex and converts it to title case before converting
#' everything other than female or male to an other category.
#'
#' @param sex A character indicating sex.
#'
#' @return A factor indicating sex.
#' @export
#'
#' @examples
#' `creating_sex(sex)`
creating_sex <- function(sex) {
  # Asserting sex is a character
  checkmate::assert_character(x = sex)
  # Asserting sex has an expected value
  checkmate::assert_subset(x = sex, choices = c("FEMALE", "F", "MALE", "M", "OTHER (TRANSSEXUAL, HERMAPHRODITE)", "UNDIFFERENTIATED (STILLBIRTHS ONLY)"))

  case_when(
    sex %in% c("FEMALE", "F") ~ "Female",
    sex %in% c("MALE", "M") ~ "Male",
    sex %in% c("OTHER (TRANSSEXUAL, HERMAPHRODITE)", "UNDIFFERENTIATED (STILLBIRTHS ONLY)") ~ "Other"
  )
}
