#' Aggregating deaths data
#'
#' This function takes the clean deaths data from IntelliHealth and aggregates
#' them by taking the total number of cases and measures by year, code, sex, and
#' age group.
#'
#' @param clean_deaths_data A tbl_df of clean deaths IntelliHealth data.
#'
#' @return A tbl_df of summarized deaths IntelliHealth data.
#' @export
#'
#' @examples
#' `aggregating_deaths_data(clean_deaths_data)`
aggregating_deaths_data <-
  function(clean_deaths_data) {
    clean_deaths_data %>%
      group_by(
        year,
        code,
        sex,
        age_group
      ) %>%
      summarise(
        count = sum(count),
        measure = sum(measure),
        .groups = "drop"
      ) %>%
      complete(
        year = full_seq(x = year, period = 1),
        code,
        sex,
        age_group,
        fill = list(count = 0, measure = 0)
      ) %>%
      # breaking the code field into a block code and block name
      extract(
        col = code,
        into = c("block_code", "block_name"),
        regex = "\\(([0-9]{2})\\)([[:print:]]+)",
        remove = TRUE
      )
  }
