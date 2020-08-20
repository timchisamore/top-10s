#' Cleaning Population Data
#'
#' This function takes the raw population data from IntelliHealth and
#' cleans it by creating a field for age groups.
#'
#' @param raw_population_data a tbl_df of raw population IntelliHealth data
#'
#' @return a tbl_df of clean population IntelliHealth data
#' @export
#'
#' @examples
#' cleaning_population_data(raw_population_data)
cleaning_population_data <- function(raw_population_data) {
  clean_population_data <- raw_population_data %>%
    mutate(age_group = creating_age_group(age))

  return(clean_population_data)
}
