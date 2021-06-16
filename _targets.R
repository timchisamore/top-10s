library(targets)
library(tarchetypes)
purrr::walk(.x = fs::dir_ls(path = here::here("R")), .f = source)
tar_option_set(packages = c("tidyverse", "conflicted"))
list(
  tar_file(name = deaths_path, command = here::here("data", "raw", "intellihealth_deaths_data.xlsx")),
  tar_file(name = ed_visits_path, command = here::here("data", "raw", "intellihealth_ed-visits_data.xlsx")),
  tar_file(name = hospitalizations_path, command = here::here("data", "raw", "intellihealth_hospitalizations_data.xlsx")),
  tar_file(name = population_estimates_path, command = here::here("data", "raw", "intellihealth_population-estimates_data.xlsx")),
  tar_target(name = raw_deaths_data, command = reading_intellihealth_data(deaths_path, c("numeric", "text", "numeric", "text", "numeric", "numeric"))),
  tar_target(name = raw_ed_visits_data, command = reading_intellihealth_data(ed_visits_path, c("numeric", "text", "numeric", "text", "numeric", "numeric"))),
  tar_target(name = raw_hospitalizations_data, command = reading_intellihealth_data(hospitalizations_path, c("numeric", "text", "numeric", "text", "numeric", "numeric"))),
  tar_target(name = raw_population_estimates_data, command = reading_intellihealth_data(population_estimates_path, c("numeric", "text", "numeric", "numeric"))),
  tar_target(name = clean_deaths_data, command = cleaning_deaths_data(raw_deaths_data)),
  tar_target(name = clean_ed_visits_data, command = cleaning_ed_visits_data(raw_ed_visits_data)),
  tar_target(name = clean_hospitalizations_data, command = cleaning_hospitalizations_data(raw_hospitalizations_data)),
  tar_target(name = clean_population_estimates_data, command = cleaning_population_estimates_data(raw_population_estimates_data)),
  tar_target(name = aggregate_deaths_data, command = aggregating_deaths_data(clean_deaths_data)),
  tar_target(name = aggregate_ed_visits_data, command = aggregating_ed_visits_and_hospitalizations_data(clean_ed_visits_data)),
  tar_target(name = aggregate_hospitalizations_data, command = aggregating_ed_visits_and_hospitalizations_data(clean_hospitalizations_data)),
  tar_target(name = aggregate_population_estimates_data, command = aggregating_population_estimates_data(clean_population_estimates_data)),
  tar_target(name = top_10_deaths_data, command = creating_top_10_data(aggregate_deaths_data, aggregate_population_estimates_data)),
  tar_target(name = top_10_ed_visits_data, command = creating_top_10_data(aggregate_ed_visits_data, aggregate_population_estimates_data)),
  tar_target(name = top_10_hospitalizations_data, command = creating_top_10_data(aggregate_hospitalizations_data, aggregate_population_estimates_data)),
  tar_target(name = top_10_deaths_heatmap, command = creating_top_10_heatmap(top_10_deaths_data)),
  tar_target(name = top_10_ed_visits_heatmap, command = creating_top_10_heatmap(top_10_ed_visits_data)),
  tar_target(name = top_10_hospitalizations_heatmap, command = creating_top_10_heatmap(top_10_hospitalizations_data)),
  tar_target(name = top_10_deaths_code_table, command = creating_top_10_code_table(top_10_deaths_data)),
  tar_target(name = top_10_ed_visits_code_table, command = creating_top_10_code_table(top_10_ed_visits_data)),
  tar_target(name = top_10_hospitalizations_code_table, command = creating_top_10_code_table(top_10_hospitalizations_data)),
  tar_file(name = writing_top_10_deaths_data, command = writing_data(top_10_deaths_data)),
  tar_file(name = writing_top_10_ed_visits_data, command = writing_data(top_10_ed_visits_data)),
  tar_file(name = writing_top_10_hospitalizations_data, command = writing_data(top_10_hospitalizations_data)),
  tar_file(name = writing_top_10_deaths_heatmap, command = writing_figure(top_10_deaths_heatmap)),
  tar_file(name = writing_top_10_ed_visits_heatmap, command = writing_figure(top_10_ed_visits_heatmap)),
  tar_file(name = writing_top_10_hospitalizations_heatmap, command = writing_figure(top_10_hospitalizations_heatmap)),
  tar_render(name = top_10s_report, path = here::here("documents", "top-10s.Rmd"))
)
