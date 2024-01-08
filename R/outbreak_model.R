#' Run a single instance of the branching process model.
#' @author Joel Hellewell, Sophie Meakin
#' 
#' @param prop_pep Proportion of high-risk contacts that receive PEP
#' @param perc_risk Percentage reduction in risk of becoming a case after receiving PEP
#' @param hrc_mu Average number of high-risk contacts
#' @param hrc_disp Dispersion parameter for number of high-risk contacts
#' @param lrc_mu Average number of low-risk contacts
#' @param lrc_disp Dispersion parameter for number of low-risk contacts
#' @param p_hrc_case Probability that a high-risk contact becomes a case
#' @param p_lrc_case Probability that a low-risk contact becomes a case
#' @param n_initialcases Integer number of initial cases
#' @param cap_max_gen Stop the simulation when this many generations is reached
#' @param cap_max_cases Stop the simulation when this many cases is reached
#' 
#' @return A data.frame of cases by generation, with columns:
#' * generation
#' * case_id
#' * case_type: one of "PEP", "HRC" (no PEP), "LRC".
#' * infector: case_id of infector
#' * new_cases: total new cases
#' * new_cases_hrc: new cases that were high-risk contacts
#' * new_cases_pep: new cases that were high-risk contacts that received PEP
#' * new_cases_lrc: new cases that were low-risk contacts
#' * n_hrc_pep: number of high-risk contacts that received PEP
#' @export
#' 
outbreak_model <- function(
    prop_pep,
    perc_risk,
    hrc_mu, hrc_disp,
    lrc_mu, lrc_disp,
    p_hrc_case, p_lrc_case,
    n_initialcases,
    cap_max_gen, cap_max_cases
) {
  
  # function body; ref https://github.com/epiforecasts/ringbp/blob/main/R/outbreak_model.R
  
  case_data <- outbreak_setup(n_initialcases = n_initialcases)
  gen <- 0
  total_cases <- n_initialcases
  
  while(gen < cap_max_gen & total_cases < cap_max_cases & max(case_data$generation) == gen) {
    
    case_data <- outbreak_step(
      case_data = case_data, g = gen,
      hrc_mu = hrc_mu,
      hrc_disp = hrc_disp,
      lrc_mu = lrc_mu,
      lrc_disp = lrc_disp,
      prop_pep = prop_pep,
      p_hrc_case = p_hrc_case,
      p_lrc_case = p_lrc_case,
      perc_risk = perc_risk
    )
    gen <- gen + 1
    total_cases <- nrow(case_data)
    
  }
  
  return(case_data)
  
}