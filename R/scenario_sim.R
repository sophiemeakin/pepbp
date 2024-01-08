#' Run a specified number of simulations with identical parameters.
#' @author Joel Hellewell, Sophie Meakin
#' 
#' @param nsim Number of simulations to run
#' @inheritParams outbreak_model
#' 
#' @return A data.frame containing the results for multiple simulations.
#' @export
#' 
scenario_sim <- function(
    n_sim,
    prop_pep,
    perc_risk,
    hrc_mu, hrc_disp,
    lrc_mu, lrc_disp,
    p_hrc_case, p_lrc_case,
    n_initialcases,
    cap_max_gen, cap_max_cases
) {
  
  # function body; ref https://github.com/epiforecasts/ringbp/blob/main/R/scenario_sim.R
  
  out <- purrr::map_df(
    .x = 1:n_sim,
    .f = ~ {
      
      out_int <- outbreak_model(
        hrc_mu = hrc_mu,
        hrc_disp = hrc_disp,
        lrc_mu = lrc_mu,
        lrc_disp = lrc_disp,
        prop_pep = prop_pep,
        p_hrc_case = p_hrc_case,
        p_lrc_case = p_lrc_case,
        perc_risk = perc_risk,
        n_initialcases = n_initialcases,
        cap_max_gen = cap_max_gen, cap_max_cases = cap_max_cases
      ) %>%
        dplyr::mutate(iter = .x)
      
      return(out_int)
      
    }
  )
  
  return(out)
    
}