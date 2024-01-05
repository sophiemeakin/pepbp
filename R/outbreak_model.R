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
#' @return A data.frame of high- and low-risk contacts and cases by generation.
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
  
}