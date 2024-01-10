#' Visualise change in R0
#' @author Sophie Meakin
#' 
#' @description Visualise relative of risk of becoming a case versus average number of secondary cases.
#' 
#' @param sweep_summary Output from summarise_results().
#' 
#' @return A ggplot object.
#' @export
#' 
plot_r0 <- function(sweep_summary) {
  
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
    dplyr::filter(prop_pep > 0) %>%
    dplyr::group_by(scenario, n_initialcases, prop_pep, rel_risk) %>%
    dplyr::summarise(
      r0_mean = mean(r0),
      r0_median = median(r0),
      r0_q025 = quantile(r0, 0.025),
      r0_q25 = quantile(r0, 0.25),
      r0_q75 = quantile(r0, 0.75),
      r0_q975 = quantile(r0, 0.975)
    ) %>%
    ggplot(aes(x = rel_risk, col = as.factor(prop_pep))) +
    geom_hline(yintercept = 1, lty = 2, col = "lightgrey") +
    geom_line(aes(y = r0_mean)) +
    geom_point(aes(y = r0_mean), size = 3) +
    # geom_errorbar(aes(y = r0_mean, ymin = r0_q25, ymax = r0_q75), width = 0, lwd = 1.5) +
    scale_x_continuous(breaks = seq(0, 1, 0.2)) +
    scale_y_continuous(breaks = seq(0, 5, 0.2)) +
    scale_color_brewer(palette = "Reds") +
    labs(
      x = "Relative risk of HRCs becoming a case (PEP vs. no PEP)", y = "Average number of secondary cases (R0)",
      col = "Probability of receiving PEP"
      ) +
    theme_bw() +
    theme(text = element_text(size = 14), legend.position = "top")
  
  return(out)
  
}
