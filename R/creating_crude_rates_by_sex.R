#' Creating crude rates by sex
#' 
#' This function takes the combined data and produces data for crude rates by
#' sex, including totals.
#'
#' @param combined_data A tibble of combined joined ED visits, hospitalizations,
#' and deaths data.
#'
#' @return A tibble of data for crude rates by sex.
#' @export
#'
#' @examples
creating_crude_rates_by_sex <- function(combined_data) {
  # Asserting that combined_data is a tibble
  checkmate::assert_tibble(x = combined_data)
  
  counts_by_sex <- combined_data |>
    group_by(type, year, sex, code_scheme, code, name) |>
    summarize(
      count_num = sum(count_num),
      measure = sum(measure),
      count_denom = sum(count_denom),
      .groups = "drop"
    )
  
  total_counts <- counts_by_sex |>
    group_by(type, year, code_scheme, code, name) |>
    summarize(
      count_num = sum(count_num),
      measure = sum(measure),
      count_denom = sum(count_denom),
      .groups = "drop"
    ) |>
    add_column(sex = "Total", .after = "year")
  
  bind_rows(counts_by_sex, total_counts) |>
    filter(count_num >= 5) |>
    #QUESTION Do we want to include age-adjusted rate, as well?
    mutate(
      crude_rate = count_num / count_denom,
      standardized_crude_rate = (crude_rate - min(crude_rate)) / (max(crude_rate) - min(crude_rate))
    )
}
