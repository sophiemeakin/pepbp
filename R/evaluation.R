#' Title
#'
#' @param sweep_df 
#'
#' @return
#' @export
#'
#' @examples
#' @export
summarise_results <- function(sweep_df) {
  
  big_results <- dplyr::bind_rows(sweep_df$sims, .id = "scenario") %>%
    dplyr::mutate(scenario = as.integer(scenario))
  
  out <- big_results %>% 
    dplyr::group_by(scenario, iter) %>%
    dplyr::summarise(
      r0 = mean(new_cases, na.rm = TRUE),
      n_pep = sum(n_hrc_pep, na.rm = TRUE),
      outbreak_size = dplyr::n())
  
  return(out)
}