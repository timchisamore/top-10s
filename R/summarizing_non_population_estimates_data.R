#' Summarizing Non-population Estimates Data
#'
#' This function takes the clean deaths, ED visits, and hospitalizations data from
#' IntelliHealth and summarizes them by taking the total number of cases and
#' measures by year, code, sex, and age group.
#'
#' @param clean_non_population_estimates_data a tbl_df of clean deaths, ED visits,
#' or hospitalizations IntelliHealth data
#'
#' @return a tbl_df of summarized deaths, ED visits, or hospitalizations
#' IntelliHealth data
#' @export
#'
#' @examples
#' summarizing_non_population_estimates_data(clean_deaths_data)
summarizing_non_population_estimates_data <- function(clean_non_population_estimates_data) {
  summarized_non_population_estimates_data <- clean_non_population_estimates_data %>%
    group_by(
      year,
      code,
      sex,
      age_group
    ) %>%
    summarise(
      count = sum(count),
      measure = sum(measure),
      .groups = "drop"
    )

  return(summarized_non_population_estimates_data)
}
