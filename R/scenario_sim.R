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
    
}