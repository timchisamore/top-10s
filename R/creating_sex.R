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
  fct_other(fct_collapse(str_to_title(sex), Female = c("F", "Female"), Male = c("M", "Male")), keep = c("Female", "Male"))
}
