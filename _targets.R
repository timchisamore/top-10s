# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)

# Set target options:
tar_option_set(
  packages = c("conflicted", "dplyr", "readr", "stringr", "tibble", "tidyr")
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()


# Replace the target list below with your own:
list(
  tar_file(name = ed_visits_path, command = here::here("data", "raw", "intellihealth_ed-visits_data.xlsx")),
  tar_file(name = hospitalizations_path, command = here::here("data", "raw", "intellihealth_hospitalizations_data.xlsx")),
  tar_file(name = deaths_path, command = here::here("data", "raw", "intellihealth_deaths_data.xlsx")),
  tar_file(name = population_estimates_path, command = here::here("data", "raw", "intellihealth_population-estimates_data.xlsx")),
  tar_target(name = raw_ed_visits_data, command = reading_intellihealth_data(intellihealth_path = ed_visits_path, types = c("numeric", "text", "numeric", "text", "numeric", "numeric"))),
  tar_target(name = raw_hospitalizations_data, command = reading_intellihealth_data(intellihealth_path = hospitalizations_path, types = c("numeric", "text", "numeric", "text", "numeric", "numeric"))),
  tar_target(name = raw_deaths_data, command = reading_intellihealth_data(intellihealth_path = deaths_path, types = c("numeric", "text", "numeric", "text", "numeric", "numeric"))),
  tar_target(name = raw_population_estimates_data, command = reading_intellihealth_data(intellihealth_path = population_estimates_path, types = c("numeric", "text", "numeric", "numeric"))),
  tar_target(name = clean_ed_visits_data, command = cleaning_ed_visits_data(raw_ed_visits_data = raw_ed_visits_data)),
  tar_target(name = clean_hospitalizations_data, command = cleaning_hospitalizations_data(raw_hospitalizations_data = raw_hospitalizations_data)),
  tar_target(name = clean_deaths_data, command = cleaning_deaths_data(raw_deaths_data = raw_deaths_data)),
  tar_target(name = clean_population_estimates_data, command = cleaning_population_estimates_data(raw_population_estimates_data = raw_population_estimates_data)),
  tar_target(name = aggregate_ed_visits_data, command = aggregating_numerator_data(clean_numerator_data = clean_ed_visits_data)),
  tar_target(name = aggregate_hospitalizations_data, command = aggregating_numerator_data(clean_numerator_data = clean_hospitalizations_data)),
  tar_target(name = aggregate_deaths_data, command = aggregating_numerator_data(clean_numerator_data = clean_deaths_data)),
  tar_target(name = aggregate_population_estimates_data, command = aggregating_denominator_data(clean_denominator_data = clean_population_estimates_data)),
  tar_target(name = joined_ed_visits_data, command = joining_aggregate_data(aggregate_numerator_data = aggregate_ed_visits_data, aggregate_denominator_data = aggregate_population_estimates_data)),
  tar_target(name = joined_hospitalizations_data, command = joining_aggregate_data(aggregate_numerator_data = aggregate_hospitalizations_data, aggregate_denominator_data = aggregate_population_estimates_data)),
  tar_target(name = joined_deaths_data, command = joining_aggregate_data(aggregate_numerator_data = aggregate_deaths_data, aggregate_denominator_data = aggregate_population_estimates_data)),
  tar_target(name = combined_data, command = combining_joined_data(joined_ed_visits_data = joined_ed_visits_data, joined_hospitalizations_data = joined_hospitalizations_data, joined_deaths_data = joined_deaths_data)),
  tar_target(name = ranked_data, command = ranking_data(combined_data = combined_data)),
  tar_target(name = crude_rates_by_sex, command = creating_crude_rates_by_sex(combined_data = combined_data)),
  tar_target(name = top_10_appearaces, command = creating_top_10_appearances(ranked_data = ranked_data)),
  tar_target(name = write_ranked_data, command = writing_data(data = ranked_data, file_name = "ranked_data.csv")),
  tar_target(name = write_crude_rates_by_sex, command = writing_data(data = crude_rates_by_sex, file_name = "crude_rates_by_sex.csv")),
  tar_target(name = write_top_10_appearances, command = writing_data(data = top_10_appearaces, file_name = "top_10_appearances.csv"))
)
