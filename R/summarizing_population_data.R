#' Summarizing Population Data
#'
#' This functions takes the clean population data from IntelliHealth
#' and summarizes it by taking the total population by year, sex, and
#' age group.
#'
#' @param clean_population_data a tbl_df of clean population IntelliHealth data
#'
#' @return a tbl_df of summarized population IntelliHealth data
#' @export
#'
#' @examples
#' summarizing_population_data(clean_population_data)
summarizing_population_data <- function(clean_population_data) {
  summarized_population_data <- clean_population_data %>%
    group_by(
      year,
      sex,
      age_group
    ) %>%
    summarise(population = sum(population)) %>%
    ungroup()

  return(summarized_population_data)
}
