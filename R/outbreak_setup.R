#' Set up initial cases for branching process
#' @author Sophie Meakin, Joel Hellewell
#' 
#' @inheritParams outbreak_model
#' 
#' @return A data.frame of initial cases in outbreak; to pass to pepbp::outbreak_step().

#' @export
#' 
outbreak_setup <- function(
    n_initialcases
) {
  
  case_data <- data.frame(
    generation = 0,
    case_id = 1:n_initialcases,
    case_type = NA,
    infector = NA,
    new_cases = NA,
    new_cases_hrc = NA,
    new_cases_pep = NA,
    new_cases_lrc = NA,
    n_hrc = NA,
    n_pep = NA,
    n_lrc = NA
    )
  
  return(case_data)
  
}