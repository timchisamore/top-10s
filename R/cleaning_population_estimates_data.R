#' Cleaning population estimates data
#'
#' This function takes the raw population estimates data from IntelliHealth and
#' cleans it by creating a field for age groups and a field for sex.
#'
#' @param raw_population_estimates_data A tbl_df of raw population IntelliHealth
#' data.
#'
#' @return A tbl_df of clean population estimates IntelliHealth data.
#' @export
#'
#' @examples
#' `cleaning_population_estimates_data(raw_population_estimates_data)`
cleaning_population_estimates_data <- function(raw_population_estimates_data) {
  raw_population_estimates_data %>%
    mutate(
      age_group = creating_age_group(age),
      sex = creating_sex(sex)
    )
}
