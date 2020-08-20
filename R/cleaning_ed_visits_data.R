#' Cleaning ED Visits Data
#'
#' This function takes the raw ED visits data from IntelliHealth and cleans it
#' by removing records with codes that are not meaningful to our analysis and
#' creating a field for age groups.
#'
#' @param raw_ed_visits_data a tbl_df of raw ED visits IntelliHealth data
#'
#' @return a tbl_df of clean ED visits IntelliHealth data
#' @export
#'
#' @examples
#' cleaning_ed_visits_data(raw_ed_visits_data)
cleaning_ed_visits_data <- function(raw_ed_visits_data) {
  clean_ed_visits_data <- raw_ed_visits_data %>%
    filter(!str_detect(code, "(R[0-9]{2}-R[0-9]{2})|(Z[0-9]{2}-Z[0-9]{2})")) %>%
    mutate(age_group = creating_age_group(age))

  return(clean_ed_visits_data)
}
