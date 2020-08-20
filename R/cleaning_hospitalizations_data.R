#' Cleaning Hospitalizations Data
#'
#' This function takes the raw hospitalizations data from IntelliHealth and
#' cleans it by removing records with codes that are not meaningful to our
#' analysis and creating a field for age groups.
#'
#' @param raw_hospitalizations_data a tbl_df of raw hospitalizations IntelliHealth data
#'
#' @return a tbl_df of clean hospitalizations IntelliHealth data
#' @export
#'
#' @examples
#' cleaning_hospitalizations_data(raw_hospitalizations_data)
cleaning_hospitalizations_data <-
  function(raw_hospitalizations_data) {
    clean_hospitalizations_data <- raw_hospitalizations_data %>%
      filter(!str_detect(code, "(R[0-9]{2}-R[0-9]{2})|(Z[0-9]{2}-Z[0-9]{2})")) %>%
      mutate(age_group = creating_age_group(age))

    return(clean_hospitalizations_data)
  }
