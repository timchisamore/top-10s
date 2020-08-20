#' Joining Non-population and Population Data
#'
#' This function joins the summarized deaths, ED visits, or hospitalizations
#' data from IntelliHealth with the summarized population data from
#' IntelliHealth on year, sex, and age group. It also calculates
#' a rate using the count field from the summarized deaths, ED visits, or
#' hospitalizations IntelliHealth data and the population from the summarized
#' population IntelliHealth data.
#'
#' @param summarized_non_population_data a tbl_df of summarized deaths, ED visits,
#' or hospitalizations IntelliHealth data
#' @param summarized_population_data a tbl_df of summarized population IntelliHealth data
#'
#' @return a tbl_df of summarized deaths, ED visits, or hospitalizations IntelliHealth
#' data joined to summarized population IntelliHealth data
#' @export
#'
#' @examples
#' joining_non_population_and_population_data(summarized_deaths_data, summarized_population_data)
joining_non_population_and_population_data <-
  function(summarized_non_population_data,
           summarized_population_data) {
    joined_intellihealth_data <- summarized_non_population_data %>%
      left_join(summarized_population_data,
        by = c(
          year = "year",
          sex = "sex",
          age_group = "age_group"
        )
      ) %>%
      mutate(rate = count / population)

    return(joined_intellihealth_data)
  }
