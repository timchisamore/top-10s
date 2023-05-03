#' Combining joined data
#'
#' This function adds variables to indicate the type and code scheme to the
#' joined ED visits, hospitalizations, and deaths data and returns a combined
#' file.
#'
#' @param joined_ed_visits_data A tbl_df of aggregate ED visits data joined to
#' aggregate population estimates data.
#' @param joined_hospitalizations_data A tbl_df of aggregate hospitalizations
#' data joined to aggregate population estimates data.
#' @param joined_deaths_data A tbl_df of aggregate deaths data joined to
#' aggregate population estimates data.
#'
#' @return A tbl_df of combined joined ED visits, hospitalizations, and deaths
#' data.
#' @export
#'
#' @examples
#' `combining_joined_data(joined_ed_visits_data, joined_hospitalizations_data, joined_deaths_data)`
combining_joined_data <- function(joined_ed_visits_data, joined_hospitalizations_data, joined_deaths_data) {
  # Asserting that joined_ed_visits_data is a tibble
  checkmate::assert_tibble(x = joined_ed_visits_data)
  # Asserting that joined_hospitalizations_data is a tibble
  checkmate::assert_tibble(x = joined_hospitalizations_data)
  # Asserting that joined_deaths_data is a tibble
  checkmate::assert_tibble(x = joined_deaths_data)

  bind_rows(
    joined_ed_visits_data |>
      add_column(type = "ED Visits", .before = 1) |>
      add_column(code_scheme = "ICD-10 Block", .before = "code"),
    joined_hospitalizations_data |>
      add_column(type = "Hospitalizations", .before = 1) |>
      add_column(code_scheme = "ICD-10 Block", .before = "code"),
    joined_deaths_data |>
      add_column(type = "Deaths", .before = 1) |>
      add_column(code_scheme = "Becker", .before = "code")
  )
}
