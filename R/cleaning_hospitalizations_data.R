#' Cleaning hospitalizations data
#'
#' This function takes the raw hospitalizations data from IntelliHealth and
#' cleans it by removing records with codes that are not meaningful to our
#' analysis, creating a field for age groups, and creating a field for sex.
#'
#' @param raw_hospitalizations_data A tbl_df of raw hospitalizations
#' IntelliHealth data.
#'
#' @return A tbl_df of clean hospitalizations IntelliHealth data.
#' @export
#'
#' @examples
#' `cleaning_hospitalizations_data(raw_hospitalizations_data)`
cleaning_hospitalizations_data <-
  function(raw_hospitalizations_data) {
    # removing observations with codes we do not want to include in our analysis
    raw_hospitalizations_data %>%
      filter(str_starts(string = code, pattern = "([RZ]{1}[0-9]{2}-[RZ]{1}[0-9]{2})", negate = TRUE)) %>%
      # creating age group and sex fields
      mutate(
        age_group = creating_age_group(age),
        sex = creating_sex(sex)
      )
  }
