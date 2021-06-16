#' Writing figure
#'
#' This function takes a plot and writes it to the ./document/figures folder.
#'
#' @param plot A ggplot to write to file.
#'
#' @return A character representing the path to write the figure to.
#' @export
#'
#' @examples
#' `writing_figure(top_10_deaths_heatmap)`
writing_figure <- function(plot) {
  plot_name <- rlang::as_label(enquo(plot))

  ggsave(
    filename = paste0(plot_name, ".png"),
    plot = plot,
    path = here::here("documents", "figures"),
    device = "png",
    units = "in",
    width = 13,
    height = 8
  )

  here::here("documents", "figures", paste0(plot_name, ".png"))
}
