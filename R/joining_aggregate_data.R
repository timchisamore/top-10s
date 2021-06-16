#' Joining aggregate data
#'
#' This function joins the aggregated deaths, ED visits, or hospitalizations
#' data from IntelliHealth with the aggregated population estimates data from
#' IntelliHealth on year, sex, and age group. It also calculates
#' a rate using the count field from the aggregated deaths, ED visits, or
#' hospitalizations IntelliHealth data and the population from the aggregated
#' population IntelliHealth data.
#'
#' @param aggregate_non_population_estimates_data A tbl_df of aggregate deaths,
#' ED visits, or hospitalizations IntelliHealth data.
#' @param aggregate_population_estimates_data A tbl_df of aggregate population
#' estimates IntelliHealth data.
#'
#' @return A tbl_df of aggregated deaths, ED visits, or hospitalizations
#' IntelliHealth data joined to aggregated population estimates IntelliHealth
#' data.
#' @export
#'
#' @examples
#' joining_aggregate_data(aggregate_non_population_estimates_data, aggregate_population_estimates_data)
joining_aggregate_data <-
  function(aggregate_non_population_estimates_data,
           aggregate_population_estimates_data) {
    aggregate_non_population_estimates_data %>%
      inner_join(aggregate_population_estimates_data,
        by = c("year", "sex", "age_group"),
        suffix = c("_num", "_denom")
      ) %>%
      mutate(rate = (count_num / count_denom))
  }
