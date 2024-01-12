#' Move branching process forward by one generation
#' @author Sophie Meakin, Joel Hellewell
#' 
#' @description Move branching process model forward from generation `g` to generation `g+1`.
#' 
#' @param outbreak_data A data.frame of cases up to generation `g+1`.
#' @inheritParams outbreak_model
#'
#' @return A data.frame updated with one new generation of cases.
#' @export
#' 
outbreak_step <- function(
    case_data, g,
    hrc_mu, hrc_disp,
    lrc_mu, lrc_disp,
    prop_pep, rel_risk,
    p_hrc_case, p_lrc_case
  ) {
  
  # get current generation
  case_data_g <- case_data %>%
    dplyr::filter(generation == g)
  # calculate HRC/PEP/LRCs and new cases
  case_data_g <- case_data_g %>%
    dplyr::mutate(
      n_hrc = rnbinom(nrow(case_data_g), mu = hrc_mu, size = hrc_disp),
      n_lrc = rnbinom(nrow(case_data_g), mu = lrc_mu, size = lrc_disp),
      n_pep = rbinom(nrow(case_data_g), size = n_hrc, prob = prop_pep),
      n_hrc = n_hrc - n_pep,
      new_cases_hrc = rbinom(n = nrow(case_data_g), size = n_hrc, prob = p_hrc_case),
      new_cases_pep = rbinom(n = nrow(case_data_g), size = n_pep, prob = p_hrc_case*rel_risk),
      new_cases_lrc = rbinom(n = nrow(case_data_g), size = n_lrc, prob = p_lrc_case),
      new_cases = new_cases_hrc + new_cases_pep + new_cases_lrc
    )
  
  # updated case_data up to current generation
  if(g == 0) {
    out <- dplyr::bind_rows(
      case_data_g
    ) 
  } else {
    out <- dplyr::bind_rows(
      case_data %>% dplyr::filter(generation < g),
      case_data_g
    ) 
  }
  
  # if there are any new cases, add new rows to case_data for next generation
  if(sum(case_data_g$new_cases) > 0) {
    
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
    
    out <- dplyr::bind_rows(
      out,
      case_data_g1
    )
    
  }
  
  return(out)
  
}