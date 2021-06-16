#' Creating top 10 code table
#'
#' This function takes the top 10 deaths, ED visits, or hospitalizations data
#' from IntelliHealth and creates a DT table to match the labels from the top 10
#' deaths, ED visits, or hospitalizations heatmaps to their ICD-10 name. As with
#' the heatmaps, we are displaying the maximum year only.
#'
#' @param top_10_data A tbl_df of top 10 deaths, ED visits, or hospitalizations
#' IntelliHealth data.
#'
#' @return A DT table indicating how the labels on the top 10 deaths, ED visits,
#' or hospitalizations heatmap relate to the ICD-10 names.
#' @export
#'
#' @examples
#' `creating_top_10_code_table(top_10_deaths_data)`
creating_top_10_code_table <-
  function(top_10_data) {
    top_10_data %>%
      filter(year == max(year)) %>%
      distinct(block_code, block_name) %>%
      DT::datatable(
        colnames = c("Label", "Block Name"),
        rownames = FALSE,
        extensions = "FixedHeader",
        options = list(
          pageLength = 5,
          fixedHeader = TRUE,
          columnDefa = list(list(
            className = "dt-center", targets = 0:1
          ))
        )
      )
  }
