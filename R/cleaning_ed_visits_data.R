#' Cleaning ED visits data
#'
#' This function takes the raw ED visits data from IntelliHealth and cleans it
#' by removing records with codes that are not meaningful to our analysis,
#' creating a field for age groups, and creating a field for sex.
#'
#' @param raw_ed_visits_data A tbl_df of raw ED visits IntelliHealth data.
#'
#' @return A tbl_df of clean ED visits IntelliHealth data.
#' @export
#'
#' @examples
#' `cleaning_ed_visits_data(raw_ed_visits_data)`
cleaning_ed_visits_data <- function(raw_ed_visits_data) {
  raw_ed_visits_data %>%
    # removing observations with codes we do not want to include in our analysis
    filter(str_starts(string = code, pattern = "([RZ]{1}[0-9]{2}-[RZ]{1}[0-9]{2})", negate = TRUE)) %>%
    # creating age group and sex fields
    mutate(
      age_group = creating_age_group(age),
      sex = creating_sex(sex)
    )
}
