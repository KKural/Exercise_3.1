observed <- matrix(c(
  25, 15,  # Laag opgeleid: geweld, diefstal
  18, 22,  # Midden opgeleid: geweld, diefstal
  12, 28   # Hoog opgeleid: geweld, diefstal
), nrow = 3, byrow = TRUE)

# Calculate expected values manually
row_sums <- rowSums(observed)
col_sums <- colSums(observed)
total <- sum(observed)

expected <- matrix(NA, nrow=3, ncol=2)
for(i in 1:3) {
  for(j in 1:2) {
    expected[i,j] <- row_sums[i] * col_sums[j] / total
  }
}

# Calculate chi-square manually
chi_square <- 0
for(i in 1:3) {
  for(j in 1:2) {
    chi_square <- chi_square + ((observed[i,j] - expected[i,j])^2 / expected[i,j])
  }
}

# Print results
cat("Observed matrix:\n")
print(observed)
cat("\nExpected matrix:\n")
print(round(expected, 2))
cat("\nChi-square value:", round(chi_square, 2), "\n")

# Verify with built-in function
cat("\nVerify with chisq.test():\n")
result <- chisq.test(observed)
cat("Chi-square value:", round(result$statistic, 2), "\n")
cat("p-value:", format.pval(result$p.value), "\n")
cat("degrees of freedom:", result$parameter, "\n")
