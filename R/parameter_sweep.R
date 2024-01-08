#' Sweep across parameters
#' @author Sam Abbott, Sophie Meakin, Joel Hellewell
#'
#' @description Explore scenarios using gridding with sampling for parameters not in the grid. Parameters that
#' are included in the grid are currently hard coded. Use the `future` package to control parallisation
#' outside of the function.
#'
#' @param scenarios A data.frame containing all gridded scenarios.
#' @param n_sim The number of simulations to make per scenario. Numeric, defaults to 1. 
#' @param sim_fn The vectorised model simulation function.
#' @param show_progress Show the progress of the parameter sweep. Logical, defaults to `TRUE`.
#'
#' @return A nested tibble containing the parameters for each scenario and a nested list of output
#' from `sim_fn`.
#' @export
#' 
#' @importFrom dplyr group_by mutate ungroup sample_frac
#' @importFrom tibble has_name
#' @importFrom tidyr nest unnest
#' @importFrom furrr future_map future_options
#' @importFrom purrr safely
#' 
parameter_sweep <- function(
    scenarios = NULL,
    n_sim = 1,
    sim_fn = NULL,
    show_progress = TRUE
) {
  
  safe_sim_fn <- purrr::safely(sim_fn)
  
  scenario_sims <- scenarios %>%
    dplyr::group_by(scenario) %>%
    tidyr::nest() %>%
    dplyr::ungroup() %>%
    # randomise the order of scenarios - helps share the load across cores
    dplyr::sample_frac(size = 1, replace = FALSE) %>%
    dplyr::mutate(sims = furrr::future_map(
      data,
      ~ safe_sim_fn(
        n_sim = n_sim,
        prop_pep = .$prop_pep,
        perc_risk = .$perc_risk,
        hrc_mu = .$hrc_mu,
        hrc_disp = .$hrc_disp,
        lrc_mu = .$lrc_mu,
        lrc_disp = .$lrc_disp,
        p_hrc_case = .$p_hrc_case,
        p_lrc_case = .$p_lrc_case,
        n_initialcases = .$n_initialcases),
      .progress = show_progress,
      .options = furrr::furrr_options(scheduling = 20, seed = TRUE)
    )) %>%
    tidyr::unnest(cols = "data")
  
  # drop error messages
  scenario_sims$sims <- lapply(scenario_sims$sims, FUN = function(x){x$result})
  
  # name sims with scenario
  names(scenario_sims$sims) <- scenario_sims$scenario
  
  return(scenario_sims)
}