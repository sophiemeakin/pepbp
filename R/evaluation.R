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
  
  big_results <- rbindlist(sweep_df$sims, idcol = "scenario")
  
  big_results <- big_results %>% 
    group_by(scenario, iter) %>%
    summarise(r0 = mean(new_cases, na.rm = TRUE),
              n_pep = sum(n_hrc_pep, na.rm = TRUE),
              outbreak_size = n())
  
  big_results
}