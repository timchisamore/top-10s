#' Cleaning deaths sata
#'
#' This function takes the raw deaths data from IntelliHealth and cleans it by
#' removing records with codes that are not meaningful to our analysis, creating
#' a field for age groups, and creating a field for sex
#'
#' @param raw_deaths_data A tbl_df of raw deaths IntelliHealth data.
#'
#' @return A tbl_df of clean deaths IntelliHealth data.
#' @export
#'
#' @examples
#' `cleaning_deaths_data(raw_deaths_data)`
cleaning_deaths_data <- function(raw_deaths_data) {
  raw_deaths_data %>%
    # removing deaths with codes we do not want to include in our analysis
    filter(str_starts(string = code, pattern = "(88)|(99)", negate = TRUE)) %>%
    # creating age group and sex fields
    mutate(
      age_group = creating_age_group(age),
      sex = creating_sex(sex)
    )
}
