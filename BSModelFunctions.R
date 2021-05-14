# Basic Model Functions ---------------------------------
BS_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
BS_MF_LN <- function(n, L){(1+n) * L}
BS_MF_RR <- function(B, K, L, alpha){alpha * B * (K/L)^(alpha - 1)}
BS_MF_WR <- function(B, K, L, alpha){(1-alpha) * B * (K/L)^alpha}
BS_MF_Y <- function(B, K, L, alpha){B * K^alpha * L^(1-alpha)}