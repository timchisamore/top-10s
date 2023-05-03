#' Joining aggregate data
#'
#' This function joins the aggregate ED visits, hospitalizations, or deaths
#' data with the aggregate population estimates data by year, sex, and
#' age group.
#'
#' @param aggregate_numerator_data A tbl_df of aggregate ED visits,
#' hospitalizations, or deaths data.
#' @param aggregate_denominator_data A tbl_df of aggregate population estimates
#' data.
#'
#' @return A tbl_df of aggregate ED visits, hospitalizations, or deaths data
#' joined to aggregate population estimates data.
#' @export
#'
#' @examples
#' `joining_aggregate_data(aggregate_numerator_data, aggregate_denominator_data)`
joining_aggregate_data <-
  function(aggregate_numerator_data,
           aggregate_denominator_data) {
    # Asserting that aggregate_numerator_data is a tibble
    checkmate::assert_tibble(x = aggregate_numerator_data)
    # Asserting that aggregate_denominator_data is a tibble
    checkmate::assert_tibble(x = aggregate_denominator_data)

    inner_join(
      x = aggregate_numerator_data,
      y = aggregate_denominator_data,
      by = c("year", "sex", "age_group"),
      suffix = c("_num", "_denom")
    )
  }
