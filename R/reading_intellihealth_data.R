#' Reading IntelliHealth data
#'
#' This function takes the path to our IntelliHealth data and a character of
#' column types and reads the data in.
#'
#' @param intellihealth_path A character representing the pathway to our
#' IntelliHealth data.
#' @param types A character representing the column types.
#'
#' @return A tbl_df of raw IntelliHealth data.
#' @export
#'
#' @examples
#' `reading_intellihealth_data(here::here("data", "raw", "ed-visits_data.xlsx"))`
reading_intellihealth_data <- function(intellihealth_path, types) {
  # asserting that the file exists
  checkmate::assert_file_exists(x = intellihealth_path)
  # asserting that the types argument is a character
  checkmate::assert_character(x = types)

  readxl::read_xlsx(
    path = intellihealth_path,
    col_names = TRUE,
    col_types = types
  )
}
