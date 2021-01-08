#' Cleaning Population Estimates Data
#'
#' This function takes the raw population estimates data from IntelliHealth and
#' cleans it by creating a field for age groups.
#'
#' @param raw_population_estimates_data a tbl_df of raw population IntelliHealth data
#'
#' @return a tbl_df of clean population estimates IntelliHealth data
#' @export
#'
#' @examples
#' cleaning_population_estimates_data(raw_population_data)
cleaning_population_estimates_data <- function(raw_population_estimates_data) {
  clean_population_estimates_data <- raw_population_estimates_data %>%
    mutate(age_group = creating_age_group(age))

  return(clean_population_estimates_data)
}
