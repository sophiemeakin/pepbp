#' Calculate R0 from single scenario simulation
#' @author Sophie Meakin
#' 
#' @param df A data.frame of a single simulation
#' 
#' @return Numeric distribution of number of secondary cases in simulation.
#' @export
#' 
calculate_r0 <- function(
    df
) {
  
}


#' Calculate outbreak duration from a single scenario simulation
#' @author Sophie Meakin
#'
#' @inheritParams calculate_r0
#' 
#' @return The integer number of generations until the outbreak went extinct.
#' @export
#' 
calculate_duration <- function(
    df
) {
  
}


#' Count number of individuals who received PEP
#' @author Sophie Meakin
#' 
#' @inheritParams calculate_r0
#' 
#' @return The integer number of individuals who received PEP.
#' @export
#' 
calculate_pep <- function(
    df
) {
  
}