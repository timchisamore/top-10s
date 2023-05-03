#' Cleaning hospitalizations data
#'
#' This function takes the raw hospitalizations data from IntelliHealth and
#' cleans it by by creating a field for age groups, creating a field for sex,
#' and splitting code into code and name using regex.
#'
#' @param raw_hospitalizations_data A tbl_df of raw hospitalizations data from
#' IntelliHealth.
#'
#' @return A tbl_df of clean hospitalizations data.
#' @export
#'
#' @examples
#' `cleaning_hospitalizations_data(raw_hospitalizations_data)`
cleaning_hospitalizations_data <-
  function(raw_hospitalizations_data) {
    # Asserting that raw_hospitalizations_data is a tibble
    checkmate::assert_tibble(x = raw_hospitalizations_data)
    # Asserting that the expected variables exist
    checkmate::assert_set_equal(x = names(raw_hospitalizations_data), y = c("year", "sex", "age", "code", "count", "measure"))

    raw_hospitalizations_data |>
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
