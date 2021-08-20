# Extended Solow Model with Scarce Resource Land 
ESSRL_MF_Y <- function(A, K, L, X, alpha, beta){K^alpha * (A * L)^(beta) * X^(1-alpha - beta)}

ESSRL_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
ESSRL_MF_LN <- function(n, L){(1+n) * L}
ESSRL_MF_AN <- function(g, A){(1+g) * A}

ESSRL_MF_WR <- function(A, K, L, X, alpha, beta, kappa){beta * (K/(A*L))^alpha * (X/(A*L))^kappa * A}
ESSRL_MF_RR <- function(A, K, L, X, alpha, kappa){alpha * (K/(A*L))^(alpha - 1) * (X/(A*L))^kappa}
ESSRL_MF_LR <- function(A, K, L, X, alpha, kappa){kappa * (K/(A*L))^(alpha) * (X/(A*L))^(kappa - 1)}

# from book (but also on slides)
# Capital to Output Ratio
ESSRL_SS_YpW <- function(KpW, YpW, A, X, L, alpha, beta){
    kappa <- 1- alpha - beta
    (KpW/YpW)^(alpha/(beta + kappa)) * A^(beta/(beta + kappa)) * (X/L)^(kappa/(beta + kappa))}
ESSRL_SS_CtO <- function(s, n, g, delta, beta){
    kappa <- 1- alpha - beta
    s/(((1 + n) * (1 + g))^(beta/(beta + kappa)) - (1- delta))}
