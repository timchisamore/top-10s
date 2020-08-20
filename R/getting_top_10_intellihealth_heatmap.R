#' Getting Top 10 IntelliHealth Heatmap
#'
#' This function first filters the top 10 deaths, ED visits, or hospitalizations
#' IntelliHealth data for the maximum year and then adds a label based on the
#' code field, which does differ between deaths and ED visits or Hospitalizations.
#' A heatmap is then created for both females and males indicating the top
#' 10 causes of deaths, ED visits, or hospitalizations by age group.
#'
#' @param top_10_intellihealth_data a tbl_df of top 10 deaths, ED visits, or
#' hospitalizations IntelliHealth data
#' @param name a character indicating which top 10 dataset we are using to
#' facilitate an appropriate title
#'
#' @return a heatmap indicating the top 10 causes of deaths, ED visits,
#' or hospitalizations by age group and sex
#' @export
#'
#' @examples
#' getting_top_10_intellihealth_heatmap(top_10_deaths_data, "Deaths")
getting_top_10_intellihealth_heatmap <-
  function(top_10_intellihealth_data, name) {
    top_10_intellihealth_heatmap <- top_10_intellihealth_data %>%
      filter(year == max(year)) %>%
      mutate(
        name = name,
        label = if_else(
          name %in% c("ED Visits", "Hospitalizations"),
          str_extract(code, "([A-Z]{1}[0-9]{2}-[A-Z]{1}[0-9]{2})"),
          str_extract(code, "([0-9]{2})")
        )
      ) %>%
      ggplot(aes(
        x = age_group,
        y = rank,
        fill = rate,
        label = label
      )) +
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
        title = paste0("Top 10 Causes of ", name, " by Sex and Age Group"),
        subtitle = paste0("Year: ", max(top_10_intellihealth_data$year)),
        x = "Age Group",
        y = "Rank",
        fill = "Rate per 100,000"
      ) +
      facet_wrap(~sex,
        ncol = 1,
        labeller = as_labeller(c(
          "FEMALE" = "Female",
          "MALE" = "Male"
        ))
      ) +
      ggthemes::theme_tufte(base_size = 13)

    return(top_10_intellihealth_heatmap)
  }
