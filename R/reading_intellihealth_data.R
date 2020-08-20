#' Reading IntelliHealth Data
#'
#' This function takes the path to our IntelliHealth data and reads it into R.
#'
#' @param intellihealth_data_path a character representing the pathway to our IntelliHealth data
#'
#' @return a tbl_df of raw IntelliHealth data
#' @export
#'
#' @examples
#' reading_intellihealth_data(here::here("data", "raw", "ed_visits.xlsx"))
reading_intellihealth_data <- function(intellihealth_data_path) {
  raw_intellihealth_data <- readxl::read_xlsx(path = intellihealth_data_path)

  return(raw_intellihealth_data)
}
