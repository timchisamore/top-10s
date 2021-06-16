#' Writing data
#'
#' This function takes data and writes it to the ./data/clean folder.
#'
#' @param data A tbl_df to write to file.
#'
#' @return A character representing the path to write the data to.
#' @export
#'
#' @examples
#' `writing_data(top_10_deaths_data)`
writing_data <- function(data) {
  data_name <- rlang::as_label(enquo(data))

  write_csv(
    x = data,
    file = here::here("data", "clean", paste0(data_name, ".csv"))
  )

  here::here("data", "clean", paste0(data_name, ".csv"))
}
