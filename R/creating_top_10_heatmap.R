#' Creating top 10 heatmap
#'
#' This function first filters the top 10 deaths, ED visits, or hospitalizations
#' IntelliHealth data for the maximum year and creates a heatmap for both males
#' and females indicating the top 10 causes of deaths, ED visits, or
#' hospitalizations by age group.
#'
#' @param top_10_data A tbl_df of top 10 deaths, ED visits, or
#' hospitalizations data.
#'
#' @return A ggplot heatmap indicating the top 10 causes of deaths, ED visits,
#' or hospitalizations by age group and sex.
#' @export
#'
#' @examples
#' creating_top_10_heatmap(top_10_deaths_data)
creating_top_10_heatmap <-
  function(top_10_data) {
    data_name <- rlang::as_label(enquo(top_10_data))
    data_label <-
      case_when(
        data_name == "top_10_deaths_data" ~ "Deaths",
        data_name == "top_10_ed_visits_data" ~ "ED Visits",
        data_name == "top_10_hospitalizations_data" ~ "Hospitalizations",
        TRUE ~ "Unknown"
      )

    top_10_data %>%
      filter(year == max(year)) %>%
      ggplot() +
      aes(
        x = age_group,
        y = rank,
        fill = rate,
        label = block_code
      ) +
      geom_raster() +
      geom_text() +
      scale_y_continuous(breaks = 1:10) +
      scale_fill_distiller(
        type = "seq",
        palette = "Reds",
        direction = 1,
        breaks = scales::pretty_breaks(),
        labels = scales::comma_format(scale = 100000)
      ) +
      labs(
        title = paste0("Top 10 Causes of ", data_label, " by Sex and Age Group"),
        subtitle = paste0("Year: ", max(top_10_data$year)),
        x = "\nAge Group",
        y = "Rank\n",
        fill = "Rate per 100,000"
      ) +
      facet_wrap(~sex,
        ncol = 1
      ) +
      ggthemes::theme_tufte(base_size = 13) +
      theme(plot.title.position = "plot")
  }
