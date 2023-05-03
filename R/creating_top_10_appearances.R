#' Creating top 10 appearances
#' 
#' This function takes the ranked data and calculates the number of top 10
#' appearances by type, sex, age group, and code scheme/code/name. It then
#' joins the number of years for each of these combinations and calculates the
#' proportion of years the combination appeared in the top 10.
#'
#' @param ranked_data A tbl_df of ranked data.
#'
#' @return A tbl_df of top 10 appearances data.
#' @export
#'
#' @examples
creating_top_10_appearances <- function(ranked_data) {
  # Asserting that ranked_data is a tibble
  checkmate::assert_tibble(x = ranked_data)
  
  sum_data <- ranked_data |>
    filter(between(x = rank, left = 1, right = 10)) |>
    group_by(type,
             sex,
             age_group,
             code_scheme,
             code,
             name) |>
    summarize(number_of_top_10_appearances = n(),
              number_of_events = sum(count_num),
              .groups = "drop")
  
  year_data <- ranked_data |>
    group_by(type) |>
    summarize(number_of_years = n_distinct(year), .groups = "drop")
  
  sum_data |>
    left_join(year_data,
              by = "type") |>
    mutate(proportion_of_top_10_appearances = number_of_top_10_appearances / number_of_years) |>
    relocate(c(number_of_years, proportion_of_top_10_appearances), .after = number_of_top_10_appearances)
}
