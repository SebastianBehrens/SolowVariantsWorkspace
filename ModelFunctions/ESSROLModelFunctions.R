# Extended Solow Model with Scarce Resource Oil and Land  ---------------------------------
ESSROL_MF_Y <- function(A, K, L, E, X, alpha, beta, kappa){K^alpha * (A*L)^(beta) * X^kappa * E^(1-alpha-beta-kappa)}
ESSROL_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
ESSROL_MF_LN <- function(n, L){(1+n) * L}
ESSROL_MF_RN <- function(E, R){R - E}
ESSROL_MF_E <- function(sE, R){sE * R}
ESSROL_MF_AN <- function(g, A){(1+g) * A}
# ESSRO_MF_RR <- function(){}
# ESSRO_MF_WR <- function(){}
# 
# GS_SS_KpW <- function(s, n, g, delta, alpha, A){A * (s/(n + g + delta + n*g))^(1/(1-alpha))}
# GS_SS_YpW <- function(s, n, g, delta, alpha, A){A * (s/(n + g + delta + n*g))^(alpha/(1-alpha))}
# 
# GS_SS_KpEW <- function(s, n, g, delta, alpha){(s/(n + g + delta + n*g))^(1/(1-alpha))}
# GS_SS_YpEW <- function(s, n, g, delta, alpha, A){(s/(n + g + delta + n*g))^(alpha/(1-alpha))}
# GS_SS_CpW <- function(YpW, s){(1-s)*YpW}
# GS_SS_RR <- function(alpha, s, n, g, delta){alpha * (s/(n + g + delta + n * g))^(-1)}
# GS_SS_WR <- function(alpha, s, n, g, delta, A){A * (1- alpha) * (s/(n + g + delta + n * g))^(alpha/(1-alpha))}


# Remark regarding dynamics of E and R
# R_0 => E_1 = s_ER_0 => R_1=R_0 - E_1 => E_2=sER_1 => ...