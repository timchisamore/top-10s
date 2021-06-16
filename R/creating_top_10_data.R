#' Creating top 10 data
#'
#' This function takes the aggregate deaths, ED visits, and hospitalizations
#' data from IntelliHealth and the aggregate population estimates data from
#' IntelliHealth and joins them by year, sex, and age group. Further,
#' observations with count_num less than 5 are filtered before finding the top
#' 10 causes by year, sex, and age group. It then scales the rate by year for
#' comparability.
#'
#' @param aggregate_non_population_estimates_data A tbl_df of aggregate deaths,
#' ED visits, or hospitalizations IntelliHealth data.
#' @param aggregate_population_estimates_data A tbl_df of aggregate population
#' estimates IntelliHealth data.
#'
#' @return A tbl_df of top 10 deaths, ED visits, or hospitalizations by year,
#' sex, and age group.
#' @export
#'
#' @examples
#' creating_top_10_data(aggregate_non_population_estimates_data, aggregate_population_estimates_data)
creating_top_10_data <-
  function(aggregate_non_population_estimates_data,
           aggregate_population_estimates_data) {
    joining_aggregate_data(
      aggregate_non_population_estimates_data = aggregate_non_population_estimates_data,
      aggregate_population_estimates_data = aggregate_population_estimates_data
    ) %>%
      filter(count_num >= 5) %>%
      group_by(
        year,
        sex,
        age_group
      ) %>%
      mutate(rank = row_number(desc(rate))) %>%
      ungroup() %>%
      filter(between(x = rank, left = 1, right = 10)) %>%
      group_by(year) %>%
      mutate(scaled_rate = ((rate - min(rate)) / (max(rate) - min(rate)))) %>%
      ungroup()
  }
