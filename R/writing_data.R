#' Writing data
#'
#' This function takes data and writes it to the ./data/clean folder.
#'
#' @param data A tbl_df to write to file.
#' @param file_name A character representing the name of the file.
#'
#' @return A character representing the path to write the data to.
#' @export
#'
#' @examples
#' `writing_data(ranked_data)`
writing_data <- function(data, file_name) {
  # Asserting that data is a tibble
  checkmate::assert_tibble(x = data)
  # Asserting that file_name is a character with a .csv extension
  checkmate::assert_character(x = file_name, pattern = "*.csv")

  write_csv(
    x = data,
    file = here::here("data", "clean",  file_name)
  )

  here::here("data", "clean", file_name)
}
