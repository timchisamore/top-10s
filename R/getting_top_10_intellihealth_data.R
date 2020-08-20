#' Getting Top 10 IntelliHealth Data
#'
#' This function takes the joined deaths, ED visits, and hospitalizations data
#' from IntelliHealth and filters observations with counts less than 5 before
#' finding the top 10 causes by year, sex, and age group. It then scales
#' the rate by year for comparability.
#'
#' @param joined_intellihealth_data a tbl_df of joined deaths, ED visits, or
#' hospitalizations IntelliHealth data
#'
#' @return a tbl_df of top 10 deaths, ED visits, or hospitalizations
#' IntelliHealth data
#' @export
#'
#' @examples
#' getting_top_10_intellihealth_data(joined_deaths_data)
getting_top_10_intellihealth_data <-
  function(joined_intellihealth_data) {
    top_10_intellihealth_data <- joined_intellihealth_data %>%
      filter(count >= 5) %>%
      group_by(
        year,
        sex,
        age_group
      ) %>%
      mutate(rank = row_number(desc(rate))) %>%
      ungroup() %>%
      filter(between(rank, 1, 10)) %>%
      group_by(year) %>%
      mutate(scaled_rate = ((rate - min(rate)) / (max(rate) - min(rate)))) %>%
      ungroup()

    return(top_10_intellihealth_data)
  }
