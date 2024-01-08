#' Move branching process forward by one generation
#' @author Joel Hellewell, Sophie Meakin
#' 
#' @param outbreak_data A data.frame of cases
#'
#' @return A data.frame updated with one new generation of cases.
#' @export
#' 
outbreak_step <- function(
    case_data, g,
    hrc_mu, hrc_disp,
    lrc_mu, lrc_disp,
    prop_pep, perc_risk,
    p_hrc_case, p_lrc_case
  ) {
  
  # function body; ref https://github.com/epiforecasts/ringbp/blob/main/R/outbreak_step.R
  
  case_data_g <- case_data %>%
    dplyr::filter(generation == g)
  
  case_data_g <- case_data_g %>%
    dplyr::mutate(
      n_hrc = rnbinom(nrow(case_data_g), mu = hrc_mu, size = hrc_disp),
      n_lrc = rnbinom(nrow(case_data_g), mu = lrc_mu, size = lrc_disp),
      n_hrc_pep = floor(n_hrc * prop_pep),
      n_hrc = n_hrc - n_hrc_pep,
      new_cases_hrc = rbinom(n = nrow(case_data_g), size = n_hrc, prob = p_hrc_case),
      new_cases_pep = rbinom(n = nrow(case_data_g), size = n_hrc_pep, prob = p_hrc_case*perc_risk),
      new_cases_lrc = rbinom(n = nrow(case_data_g), size = n_lrc, prob = p_lrc_case),
      new_cases = new_cases_hrc + new_cases_pep + new_cases_lrc
    )
  
  case_data_g1 <- data.frame(
    generation = g + 1,
    case_id = (max(case_data_g$case_id) + 1):(max(case_data_g$case_id) + sum(case_data_g$new_cases)),
    case_type = c(
      rep("HRC", sum(case_data_g$new_cases_hrc)),
      rep("PEP", sum(case_data_g$new_cases_pep)),
      rep("LRC", sum(case_data_g$new_cases_lrc))
      ),
    infector = NA
  )
  
  # yuck
  if(g == 0) {
    
    out <- dplyr::bind_rows(
      case_data_g,
      case_data_g1
    ) 
    
  } else {
    
    out <- dplyr::bind_rows(
      case_data %>% dplyr::filter(generation < g),
      case_data_g,
      case_data_g1
    ) 
    
  }
  
  return(out)
  
}