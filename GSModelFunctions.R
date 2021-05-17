# Basic Model Functions ---------------------------------
GS_MF_KN <- function(s, Y, delta, K){s * Y + (1-delta)*K}
GS_MF_LN <- function(n, L){(1+n) * L}
GS_MF_AN <- function(g, A){(1+g) * A}
GS_MF_RR <- function(A, K, L, alpha){alpha * (K/(A*L))^(alpha - 1)}
GS_MF_WR <- function(A, K, L, alpha){A* (1-alpha) * (K/(A*L))^alpha }
GS_MF_Y <- function(A, K, L, alpha){K^alpha * (A*L)^(1-alpha)}