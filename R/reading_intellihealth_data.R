#' Reading intellihealth data
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
  stopifnot("This specified data does not exist!" = fs::file_exists(intellihealth_path))
  stopifnot("Types must be a character!" = is.character(types))

  readxl::read_xlsx(
    path = intellihealth_path,
    col_names = TRUE,
    col_types = types
  )
}
