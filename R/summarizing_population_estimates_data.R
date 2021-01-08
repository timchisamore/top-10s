#' Summarizing Population Estimates Data
#'
#' This functions takes the clean population estimates data from IntelliHealth
#' and summarizes it by taking the total population by year, sex, and
#' age group.
#'
#' @param clean_population_estimates_data a tbl_df of clean population IntelliHealth data
#'
#' @return a tbl_df of summarized population estimates IntelliHealth data
#' @export
#'
#' @examples
#' summarizing_population_estimates_data(clean_population_estimates_data)
summarizing_population_estimates_data <- function(clean_population_estimates_data) {
  summarized_population_estimates_data <- clean_population_estimates_data %>%
    group_by(
      year,
      sex,
      age_group
    ) %>%
    summarise(count = sum(count),
              .groups = "drop")

  return(summarized_population_estimates_data)
}
