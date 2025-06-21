observed <- matrix(c(
  25, 15,  # Laag opgeleid: geweld, diefstal
  18, 22,  # Midden opgeleid: geweld, diefstal
  12, 28   # Hoog opgeleid: geweld, diefstal
), nrow = 3, byrow = TRUE)

# Show observed values
cat("Observed values:\n")
print(observed)

# Calculate expected values
row_sums <- rowSums(observed)
col_sums <- colSums(observed)
total <- sum(observed)

expected_values <- matrix(NA, nrow=3, ncol=2)
chi_square_components <- matrix(NA, nrow=3, ncol=2)

for(i in 1:3) {
  for(j in 1:2) {
    expected_values[i,j] <- row_sums[i] * col_sums[j] / total
    chi_square_components[i,j] <- ((observed[i,j] - expected_values[i,j])^2) / expected_values[i,j]
  }
}

# Show expected values
cat("\nExpected values:\n")
print(round(expected_values, 2))

# Show chi-square components
cat("\nChi-square components:\n")
print(round(chi_square_components, 2))

# Calculate chi-square value
chi_square_value <- sum(chi_square_components)
cat("\nChi-square value:", round(chi_square_value, 2), "\n")

# Use built-in R function to verify
result <- chisq.test(observed)
cat("\nBuilt-in chisq.test result:\n")
cat("Chi-square value:", round(result$statistic, 2), "\n")
cat("Degrees of freedom:", result$parameter, "\n")
cat("p-value:", round(result$p.value, 5), "\n")
