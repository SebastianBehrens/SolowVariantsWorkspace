# Extended Solow Model with Scarce Resource Land 
ESSRL_MF_Y <- function(A, K, L, X, alpha, beta){K^alpha * (A * L)^(beta) * X^(1-alpha - beta)}

ESSRL_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
ESSRL_MF_LN <- function(n, L){(1+n) * L}
ESSRL_MF_AN <- function(g, A){(1+g) * A}
