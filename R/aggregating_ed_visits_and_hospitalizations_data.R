#' Aggregating ED visits and hospitalizations data
#'
#' This function takes the clean ED visits and hospitalizations data from
#' IntelliHealth and aggregates them by taking the total number of cases and
#' measures by year, code, sex, and age group.
#'
#' @param clean_ed_visits_and_hospitalizations_data A tbl_df of clean ED visits
#' or hospitalizations IntelliHealth data.
#'
#' @return A tbl_df of summarized ED visits or hospitalizations IntelliHealth
#' data.
#' @export
#'
#' @examples
#' `aggregating_ed_visits_and_hospitalizations_data(clean_ed_visits_data)`
aggregating_ed_visits_and_hospitalizations_data <-
  function(clean_ed_visits_and_hospitalizations_data) {
    clean_ed_visits_and_hospitalizations_data %>%
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
        regex = "\\(([A-Z]{1}[0-9]{2}-[A-Z]{1}[0-9]{2})\\)\\s([[:print:]]+)",
        remove = TRUE
      )
  }
