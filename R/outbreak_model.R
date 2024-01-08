#' Run PEP branching process model
#' @author Sophie Meakin, Joel Hellewell
#' 
#' @description Run a single instance of the branching process model for post-exposure prophylaxis for high-risk contacts. See Details for a full description of branching process model.
#' @details Each case has some number of high- and low-risk contacts, each defined by a negative binomial distribution.
#' A fixed proportion `prop_pep` of high-risk contacts receive PEP.
#' High-risk contacts who do not receive PEP become cases with probability `p_hrc_case`; high-risk contacts who receive PEP become cases with lower probability `p_hrc_case*perc_risk`.
#' Low-risk contacts do not receive PEP, and become cases with probability `p_lrc_case`.
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
#' * infector: case_id of infector (currently not used)
#' * new_cases: total new cases
#' * new_cases_hrc: new cases that were high-risk contacts
#' * new_cases_pep: new cases that were high-risk contacts that received PEP
#' * new_cases_lrc: new cases that were low-risk contacts
#' * n_hrc: number of high-risk contacts that did not receive PEP
#' * n_pep: number of high-risk contacts that received PEP
#' * n_lrc: number of low-risk contacts
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
  
  # initialise outbreak
  case_data <- outbreak_setup(n_initialcases = n_initialcases)
  gen <- 0
  total_cases <- n_initialcases
  
  # update outbreak until max generations/cases exceeded, or outbreak extinct
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