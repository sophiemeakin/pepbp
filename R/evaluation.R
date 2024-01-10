#' Summarise results from parameter sweep
#' @author Joel Hellewell, Sophie Meakin
#' 
#' @description Summarise results from parameter_sweep by scenario and iteration.
#'
#' @param sweep_df A data.frame, output from pepbp::parameter_sweep().
#'
#' @return A data.frame with columns:
#' * scenario: scenario id
#' * iter: iteration id
#' * outbreak_size: total cases
#' * n_pep: total number of HRCs that received PEP
#' * r0: average number of secondary cases
#' 
#' @export
#'
summarise_results <- function(sweep_df) {
  
  big_results <- dplyr::bind_rows(sweep_df$sims, .id = "scenario") %>%
    dplyr::mutate(scenario = as.integer(scenario))
  
  out <- big_results %>% 
    dplyr::group_by(scenario, iter) %>%
    dplyr::summarise(
      outbreak_size = dplyr::n(),
      max_gen = max(generation),
      n_pep = sum(n_pep, na.rm = TRUE),
      r0 = mean(new_cases, na.rm = TRUE),
      .groups = "drop"
      )
  
  return(out)
}