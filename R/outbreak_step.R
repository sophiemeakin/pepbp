#' Move branching process forward by one generation
#' @author Joel Hellewell, Sophie Meakin
#' 
#' @param outbreak_data A data.frame of cases
#'
#' @return A data.frame updated with one new generation of cases.
#' @export
#' 
outbreak_step <- function(
    outbreak_data,
    hrc_mu, hrc_disp,
    lrc_mu, lrc_disp,
    p_hrc_case, p_lrc_case
  ) {
  
  # function body; ref https://github.com/epiforecasts/ringbp/blob/main/R/outbreak_step.R
  
}