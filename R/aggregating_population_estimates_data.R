#' Aggregating population estimates data
#'
#' This functions takes the clean population estimates data from IntelliHealth
#' and aggregates it by taking the total population by year, sex, and age group.
#'
#' @param clean_population_estimates_data A tbl_df of clean population
#' IntelliHealth data.
#'
#' @return A tbl_df of aggregated population estimates IntelliHealth data.
#' @export
#'
#' @examples
#' aggregating_population_estimates_data(clean_population_estimates_data)
aggregating_population_estimates_data <- function(clean_population_estimates_data) {
  clean_population_estimates_data %>%
    group_by(
      year,
      sex,
      age_group
    ) %>%
    summarise(
      count = sum(count),
      .groups = "drop"
    ) %>%
    complete(
      year = full_seq(x = year, period = 1),
      sex,
      age_group,
      fill = list(count = 0)
    )
}
