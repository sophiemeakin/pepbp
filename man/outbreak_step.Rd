% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/outbreak_step.R
\name{outbreak_step}
\alias{outbreak_step}
\title{Move branching process forward by one generation}
\usage{
outbreak_step(
  case_data,
  g,
  hrc_mu,
  hrc_disp,
  lrc_mu,
  lrc_disp,
  prop_pep,
  rel_risk,
  p_hrc_case,
  p_lrc_case
)
}
\arguments{
\item{hrc_mu}{Average number of high-risk contacts}

\item{hrc_disp}{Dispersion parameter for number of high-risk contacts}

\item{lrc_mu}{Average number of low-risk contacts}

\item{lrc_disp}{Dispersion parameter for number of low-risk contacts}

\item{prop_pep}{Proportion of high-risk contacts that receive PEP}

\item{rel_risk}{Relative risk of a high-risk contact becoming a case after receiving PEP}

\item{p_hrc_case}{Probability that a high-risk contact becomes a case}

\item{p_lrc_case}{Probability that a low-risk contact becomes a case}

\item{outbreak_data}{A data.frame of cases up to generation \code{g+1}.}
}
\value{
A data.frame updated with one new generation of cases.
}
\description{
Move branching process model forward from generation \code{g} to generation \code{g+1}.
}
\author{
Sophie Meakin, Joel Hellewell
}
