#' Aggregating numerator data
#'
#' This function takes the clean ED visits, hospitalizations, or deaths data and
#' aggregates it by taking the total count and measure by yea, sex, age group,
#' and code/name (we include them nested)
#'
#' @param clean_numerator_data A tbl_df of clean ED visits, hospitalizations, or
#' deaths data.
#'
#' @return A tbl_df of summarized ED visits, hospitalizations, or deaths data.
#' @export
#'
#' @examples
#' `aggregating_numerator_data(clean_ed_visits_data)`
aggregating_numerator_data <-
  function(clean_numerator_data) {
    # Asserting that clean_numerator_data is a tibble
    checkmate::assert_tibble(x = clean_numerator_data)
    # Asserting that the expected variables exist
    checkmate::assert_set_equal(x = names(clean_numerator_data), y = c("year", "sex", "age", "age_group", "code", "name", "count", "measure"))

    clean_numerator_data |>
      group_by(
        year,
        sex,
        age_group,
        code,
        name
      ) |>
      summarise(
        count = sum(count),
        measure = sum(measure),
        .groups = "drop"
      ) |>
      complete(
        year = full_seq(x = year, period = 1),
        sex,
        age_group,
        nesting(code, name),
        fill = list(count = 0, measure = 0)
      )
  }
