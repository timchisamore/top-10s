#' Cleaning deaths data
#'
#' This function takes the raw deaths data from IntelliHealth and cleans it by
#' creating a field for age groups, creating a field for sex, and splitting code
#' into code and name using regex.
#'
#' @param raw_deaths_data A tbl_df of raw deaths data from IntelliHealth.
#'
#' @return A tbl_df of clean deaths data.
#' @export
#'
#' @examples
#' `cleaning_deaths_data(raw_deaths_data)`
cleaning_deaths_data <- function(raw_deaths_data) {
  # Asserting that raw_deaths_data is a tibble
  checkmate::assert_tibble(x = raw_deaths_data)
  # Asserting that the expected variables exist
  checkmate::assert_set_equal(x = names(raw_deaths_data), y = c("year", "sex", "age", "code", "count", "measure"))

  raw_deaths_data |>
    mutate(
      age_group = creating_age_group(age),
      sex = creating_sex(sex),
      code = str_trim(code),
      code = str_squish(code)
    ) |>
    extract(
      col = code,
      into = c("code", "name"),
      regex = "\\(([0-9]{2}[AB]?+)\\)([[:print:]]+)",
      remove = TRUE
    ) |>
    relocate(year, sex, age, age_group, code, name, count, measure)
}
