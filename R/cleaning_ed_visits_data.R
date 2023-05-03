#' Cleaning ED visits data
#'
#' This function takes the raw ED visits data from IntelliHealth and cleans it
#' by creating a field for age groups, creating a field for sex, and splitting
#' code into code and name using regex.
#'
#' @param raw_ed_visits_data A tbl_df of raw ED visits data from IntelliHealth.
#'
#' @return A tbl_df of clean ED visits data.
#' @export
#'
#' @examples
#' `cleaning_ed_visits_data(raw_ed_visits_data)`
cleaning_ed_visits_data <- function(raw_ed_visits_data) {
  # Asserting that raw_ed_visits_data is a tibble
  checkmate::assert_tibble(x = raw_ed_visits_data)
  # Asserting that the expected variables exist
  checkmate::assert_set_equal(x = names(raw_ed_visits_data), y = c("year", "sex", "age", "code", "count", "measure"))

  raw_ed_visits_data |>
    mutate(
      age_group = creating_age_group(age),
      sex = creating_sex(sex),
      code = str_trim(code),
      code = str_squish(code)
    ) |>
    extract(
      col = code,
      into = c("code", "name"),
      regex = "\\(([A-Z]{1}[0-9]{2}-[A-Z]{1}[0-9]{2}|U)\\)\\s([[:print:]]+|Unknown)",
      remove = TRUE
    ) |>
    relocate(year, sex, age, age_group, code, name, count, measure)
}
