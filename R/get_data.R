#' Get all data from phillymetal.net
#'
#' @param upcoming_shows_only `boolean` `TRUE`: only shows on current date or in the future; `FALSE`: all shows that were listed, past, present, or future.
#'
#' @return `data.frame` with columns
#' - `added`: date added to website
#' - `url`: URL of show
#' - `show_date` date of show
#' - `description`: band lineup
#' - `venue`: venue
#' - `id`: database key; unique id
#' - `validated`: for user-submitted data; if TRUE, show is listed. if FALSE, waiting approval or rejected
#' @examples
#' all_data <- get_data()
#'
#' @importFrom httr GET add_headers content
#' @importFrom purrr map_df
#' @importFrom dplyr select filter mutate
#' @importFrom rlang .data
#'
#' @export
get_data <- function(upcoming_shows_only = FALSE) {
  apikey <-
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0dmlmYXdzZGdpeW5rbGRjZm52Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU0MDMyNzcsImV4cCI6MTk4MDk3OTI3N30.YvPD_C5yy5ELMJw-jt28uMTfwOoY7WPDeBOUy4JL0_0"
  token <- paste0("Bearer ", apikey)
  data <-
    httr::GET(
      "https://itvifawsdgiynkldcfnv.supabase.co/rest/v1/main",
      httr::add_headers(apikey = apikey,
                        Authorization = token)
    )

  parsed_data <- httr::content(data, as = "parsed") %>%
    purrr::map_df( ~ .x) %>%
    dplyr::select(-"i_went_to_this_show")

  if (upcoming_shows_only) {
    parsed_data <- parsed_data %>%
      mutate(show_date = as.Date(.data$show_date)) %>%
      filter(.data$show_date >= Sys.Date())
  }

  return(parsed_data)

}
