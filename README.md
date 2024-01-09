# *pepbp*: Modelling the effect of post-exposure prophylaxis for high-risk contacts on outbreak transmission and control

## Branching process model

### Input

The model has five inputs:

-   The initial number of cases, `n`.
-   The distribution of the number of high- and low-risk contacts per case.
-   The probability that high- and low-risk contacts become cases, `q_HR` and `q_LR`, respectively.
-   The probability that each high-risk contact receives PEP, `p`.
-   The effectiveness of PEP, defined as the relative risk that a high-risk contact becomes a case after receiving PEP, `theta`.

### Model

The outbreak is initialised with `n` cases. Then, for each case:

1.  *Generate contacts:* Sample the number of high- and low-risk contacts from the respective negative binomial distributions.
2.  *Assign PEP to high-risk contacts:* Each high-risk contact receives PEP with probability `p`.
3.  *Determine secondary cases:*
    -   High-risk contacts who did not receive PEP become cases with probability `q_HR`.
    -   High-risk contacts who did receive PEP become cases with probability `theta*q_HR`.
    -   Low-risk contacts become cases with probability `q_LR`.
4.  Repeat 1 - 3 for new generation of cases.

### Output

In the output each row represents a case, for which we report the following:

-   The number of high- and low-risk contacts
-   The number of high-risk contacts who do and do not receive PEP
-   The number secondary cases (high-risk contacts who received PEP; high-risk contacts who did not receive PEP; low-risk contacts)

------------------------------------------------------------------------

## Acknowledgements

The structure of {pepbp} is based on the [{ringbp}](https://epiforecasts.io/ringbp/index.html) package, originally developed by Joel Hellewell, Sam Abbott, Amy Gimma, Tim Lucas and Sebastian Funk.
