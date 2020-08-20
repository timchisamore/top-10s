#' Cleaning Deaths Data
#'
#' This function takes the raw deaths data from IntelliHealth and cleans
#' it by parsing the character field of year as a number, recoding sex
#' to align with our other data, creating a field for age groups, and
#' removing records with codes that are not meaningful to our analysis.
#'
#' @param raw_deaths_data a tbl_df of raw deaths IntelliHealth data
#'
#' @return a tbl_df of clean deaths IntelliHealth data
#' @export
#'
#' @examples
#' cleaning_deaths_data(raw_deaths_data)
cleaning_deaths_data <- function(raw_deaths_data) {
  clean_deaths_data <- raw_deaths_data %>%
    filter(!str_detect(code, "(88)|(99)")) %>%
    mutate(
      year = parse_number(year),
      sex = fct_recode(sex, FEMALE = "F", MALE = "M"),
      age_group = creating_age_group(age)
    )

  return(clean_deaths_data)
}
