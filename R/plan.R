plan <- drake_plan(
  raw_intellihealth_data = target(
    reading_intellihealth_data(intellihealth_data_path = paths),
    transform = map(
      paths = c(
        file_in(!!here::here("data", "raw", "deaths_data.xlsx")),
        file_in(!!here::here("data", "raw", "ed_visits_data.xlsx")),
        file_in(!!here::here("data", "raw", "hospitalizations_data.xlsx")),
        file_in(!!here::here("data", "raw", "population_estimates_data.xlsx"))
      ),
      .names = c(
        "raw_deaths_data",
        "raw_ed_visits_data",
        "raw_hospitalizations_data",
        "raw_population_estimates_data"
      )
    )
  ),
  clean_intellihealth_data = target(
    cleaning_intellihealth_data(raw_intellihealth_data),
    transform = map(
      raw_intellihealth_data,
      cleaning_intellihealth_data = !!rlang::syms(
        c(
          "cleaning_deaths_data",
          "cleaning_ed_visits_data",
          "cleaning_hospitalizations_data",
          "cleaning_population_estimates_data"
        )
      ),
      .names = c(
        "clean_deaths_data",
        "clean_ed_visits_data",
        "clean_hospitalizations_data",
        "clean_population_estimates_data"
      )
    )
  ),
  summarized_non_population_estimates_data = target(
    summarizing_non_population_estimates_data(clean_non_population_estimates_data),
    transform = map(
      clean_non_population_estimates_data = !!rlang::syms(
        c(
          "clean_deaths_data",
          "clean_ed_visits_data",
          "clean_hospitalizations_data"
        )
      ),
      .names = c(
        "summarized_deaths_data",
        "summarized_ed_visits_data",
        "summarized_hospitalizations_data"
      )
    )
  ),
  summarized_population_estimates_data = summarizing_population_estimates_data(clean_population_estimates_data),
  joined_intellihealth_data = target(
    joining_non_population_estimates_and_population_estimates_data(summarized_non_population_estimates_data, summarized_population_estimates_data),
    transform = map(
      summarized_non_population_estimates_data,
      summarized_population_estimates_data,
      .names = c(
        "joined_deaths_data",
        "joined_ed_visits_data",
        "joined_hospitalizations_data"
      )
    )
  ),
  top_10_intellihealth_data = target(
    getting_top_10_intellihealth_data(joined_intellihealth_data),
    transform = map(
      joined_intellihealth_data,
      .names = c(
        "top_10_deaths_data",
        "top_10_ed_visits_data",
        "top_10_hospitalizations_data"
      )
    )
  ),
  top_10_intellihealth_heatmap = target(
    getting_top_10_intellihealth_heatmap(top_10_intellihealth_data, name = names),
    transform = map(
      top_10_intellihealth_data,
      names = c("Deaths", "ED Visits", "Hospitalizations"),
      .names = c(
        "top_10_deaths_heatmap",
        "top_10_ed_visits_heatmap",
        "top_10_hospitalizations_heatmap"
      )
    )
  ),
  top_10_intellihealth_code_table = target(
    getting_top_10_intellihealth_code_table(top_10_intellihealth_data, name = names),
    transform = map(
      top_10_intellihealth_data,
      names = c("Deaths", "ED Visits", "Hospitalizations"),
      .names = c(
        "top_10_deaths_code_table",
        "top_10_ed_visits_code_table",
        "top_10_hospitalizations_code_table"
      )
    )
  ),
  report = rmarkdown::render(
    input = knitr_in(!!here::here("documents", "top_10_causes_of_deaths_ed_visits_and_hospitalizations.Rmd")),
    output_file = file_out(!!here::here("documents", "top_10_causes_of_deaths_ed_visits_and_hospitalizations.html"))
  )
)
