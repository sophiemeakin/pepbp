#' Visualise change in R0
#' @author Sophie Meakin
#' 
#' @description Visualise relative of risk of becoming a case versus average number of secondary cases for a % of HRCs that receive PEP (`p`).
#' 
#' @param sweep_summary Output from summarise_results().
#' @param p Proportion of HRCs that receive PEP.
#' 
#' @return A ggplot object.
#' @export
#' 
plot_r0 <- function(sweep_summary, p) {
  
  baseline_r0 <- sweep_summary %>%
    dplyr::filter(prop_pep == 0) %>%
    dplyr::group_by(prop_pep) %>%
    dplyr::summarise(
      r0_mean = mean(r0),
      r0_median = quantile(r0, 0.5),
      r0_q025 = quantile(r0, 0.025),
      r0_q975 = quantile(r0, 0.975)
    )
  
  out <- sweep_summary %>%
    dplyr::filter(prop_pep %in% c(0, p)) %>%
    dplyr::mutate(scenario_pep = ifelse(prop_pep == 0, "Baseline", "PEP")) %>%
    dplyr::group_by(scenario, scenario_pep, n_initialcases, prop_pep, perc_risk) %>%
    dplyr::summarise(
      r0_mean = mean(r0),
      r0_median = median(r0),
      r0_q025 = quantile(r0, 0.025),
      r0_q25 = quantile(r0, 0.25),
      r0_q75 = quantile(r0, 0.75),
      r0_q975 = quantile(r0, 0.975)
    ) %>%
    ggplot(aes(x = perc_risk, col = scenario_pep)) +
    geom_hline(yintercept = baseline_r0$r0_mean, lty = 3, col = "tomato") +
    geom_hline(yintercept = 1, lty = 2, col = "lightgrey") +
    geom_point(aes(y = r0_mean), size = 3) +
    geom_errorbar(aes(y = r0_mean, ymin = r0_q025, ymax = r0_q975), width = 0, lwd = 0.5) +
    geom_errorbar(aes(y = r0_mean, ymin = r0_q25, ymax = r0_q75), width = 0, lwd = 1.5) +
    facet_grid(~scenario_pep, scales = "free_x", space = "free_x") +
    scale_x_continuous(breaks = seq(0, 1, 0.1)) +
    scale_y_continuous(breaks = seq(0, 5, 0.2)) +
    scale_color_manual(
      values = c(
        "Baseline" = "tomato",
        "PEP" = "grey0"
      )
    ) +
    labs(x = "Relative risk of becoming a case", y = "R0") +
    theme_bw() +
    theme(legend.position = "none") 
  
  return(out)
  
}
