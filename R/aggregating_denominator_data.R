#' Aggregating denominator data
#'
#' This functions takes the clean population estimates data from data and
#' aggregates it by taking the total population by year, sex, and age group.
#'
#' @param clean_denominator_data A tbl_df of clean population estimates data.
#'
#' @return A tbl_df of aggregated population estimates data.
#' @export
#'
#' @examples
#' `aggregating_denominator_data(clean_population_estimates_data)`
aggregating_denominator_data <- function(clean_denominator_data) {
  # Asserting that clean_denominator_data is a tibble
  checkmate::assert_tibble(x = clean_denominator_data)
  # Asserting that the expected variables exist
  checkmate::assert_set_equal(x = names(clean_denominator_data), y = c("year", "sex", "age", "age_group", "count"))


  clean_denominator_data |>
    group_by(
      year,
      sex,
      age_group
    ) |>
    summarise(
      count = sum(count),
      .groups = "drop"
    ) |>
    complete(
      year = full_seq(x = year, period = 1),
      sex,
      age_group,
      fill = list(count = 0)
    )
}
