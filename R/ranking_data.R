#' Ranking data
#'
#' This function takes the combined data, removes observations with a count of
#' less than five and derives crude rates. It then uses these crude rates to
#' compute ranks per type, year, sex, and age group combination breaking ties
#' randomly.
#'
#' @param combined_data A tbl_df of combined joined ED visits, hospitalizations,
#' and deaths data.
#'
#' @return A tbl_df of ranked data.
#' @export
#'
#' @examples
#' `ranking_data(combined_data)`
ranking_data <- function(combined_data) {
  # Asserting that combined_data is a tibble
  checkmate::assert_tibble(x = combined_data)

  combined_data |>
    # removing any observations with a count of less than 5
    filter(count_num >= 5) |>
    mutate(
      crude_rate = (count_num / count_denom),
      standardized_crude_rate = (crude_rate - min(crude_rate)) / (max(crude_rate) - min(crude_rate))
    ) |>
    group_by(
      type,
      year,
      sex,
      age_group
    ) |>
    mutate(rank = rank(x = -crude_rate, ties.method = "random")) |>
    ungroup()
}
