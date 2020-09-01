#' Getting Top 10 IntelliHealth Code Table
#'
#' This function takes the top 10 deaths, ED visits, or hospitalizations
#' data from IntelliHealth and creates a {DT} table to match the labels
#' from the top 10 deaths, ED visits, or hospitalization heatmaps to their
#' full code. As with the heatmaps, we are displaying the maximum year only.
#'
#' @param top_10_intellihealth_data a tbl_df of top 10 deaths, ED visits, or
#' hospitalizations IntelliHealth data
#' @param name a character indicating which top 10 dataset we are using to
#' facilitate an appropriate title
#'
#' @return a DT table indicating how the labels on th top 10 deaths, ED visits,
#' or hospitalizations heatmap match to their code
#' @export
#'
#' @examples
#' getting_top_10_intellihealth_code_table(top_10_deaths_data, "Deaths")
getting_top_10_intellihealth_code_table <-
  function(top_10_intellihealth_data, name) {
    top_10_intellihealth_code_table <- top_10_intellihealth_data %>%
      filter(year == max(year)) %>%
      mutate(
        name = name,
        label = if_else(
          name %in% c("ED Visits", "Hospitalizations"),
          str_extract(code, "([A-Z]{1}[0-9]{2}-[A-Z]{1}[0-9]{2})"),
          str_extract(code, "([0-9]{2})")
        ),
        code = if_else(
          name %in% c("ED Visits", "Hospitalizations"),
          str_remove(code, "\\([A-Z]{1}[0-9]{2}-[A-Z]{1}[0-9]{2}\\)"),
          str_remove(str_remove(code, "\\([0-9]{2}\\)"), "\\(APHEO\\)")
        ),
        code = str_to_title(code)
      ) %>%
      distinct(label, code) %>%
      relocate(label, code) %>%
      DT::datatable(
        colnames = c("Label", "Code"),
        rownames= FALSE,
        extensions = "FixedHeader",
        options = list(
          pageLength = 5,
          fixedHeader = TRUE,
          columnDefa = list(list(
            className = "dt-center", targets = 0:1
          ))
        )
      )

    return(top_10_intellihealth_code_table)
  }
