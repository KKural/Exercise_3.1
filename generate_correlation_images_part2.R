# Generate Remaining Images for Dodona Correlation Exercises (Part 2)

library(ggplot2)
library(dplyr)
library(gridExtra)

# ============================================================================
# IMAGE 3.14: Monotoon vs Lineair (Q14)
# ============================================================================
set.seed(456)
n <- 50

# Genereer monotoon toenemend maar gebogen patroon (logaritmisch)
stress <- runif(n, 1, 10)
agressie <- 3 * log(stress) + rnorm(n, 0, 0.5)

# Bereken beide correlaties
pearson_r <- round(cor(stress, agressie, method = "pearson"), 3)
spearman_rho <- round(cor(stress, agressie, method = "spearman"), 3)

data_plot <- data.frame(stress = stress, agressie = agressie)

p3.14 <- ggplot(data_plot, aes(x = stress, y = agressie)) +
  geom_point(color = "darkred", size = 2.5, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "blue", linetype = "dashed", 
              aes(color = "Lineaire lijn (Pearson)")) +
  geom_smooth(method = "loess", se = FALSE, color = "red", linewidth = 1,
              aes(color = "Werkelijke curve")) +
  scale_color_manual(values = c("Lineaire lijn (Pearson)" = "blue", 
                               "Werkelijke curve" = "red")) +
  labs(
    title = "Stress vs Agressief Gedrag: Monotoon maar Niet-Lineair Patroon",
    subtitle = paste0("Pearson r = ", pearson_r, " vs Spearman ρ = ", spearman_rho),
    x = "Stressniveau",
    y = "Agressief Gedrag Score",
    color = "Methode"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("dodona_images/question_3.14.png", p3.14, width = 10, height = 6, dpi = 300)

# ============================================================================
# IMAGE 3.15: Correlatie Sterkte (Q15)
# ============================================================================
set.seed(123)
n <- 50

# Genereer data met verschillende correlatiesterktes
x_basis <- rnorm(n, 50, 10)

# Zeer sterke correlatie (r ≈ 0.9)
y_zeer_sterk <- 0.9 * scale(x_basis)[,1] * 8 + rnorm(n, 60, 3)

# Sterke correlatie (r ≈ 0.7)
y_sterk <- 0.7 * scale(x_basis)[,1] * 8 + rnorm(n, 60, 5)

# Matige correlatie (r ≈ 0.5)
y_matig <- 0.5 * scale(x_basis)[,1] * 8 + rnorm(n, 60, 7)

# Zwakke correlatie (r ≈ 0.3)
y_zwak <- 0.3 * scale(x_basis)[,1] * 8 + rnorm(n, 60, 9)

data_sterkte <- data.frame(
  x = rep(x_basis, 4),
  y = c(y_zeer_sterk, y_sterk, y_matig, y_zwak),
  type = rep(c(
    paste0("Zeer Sterk (r = ", round(cor(x_basis, y_zeer_sterk), 2), ")"),
    paste0("Sterk (r = ", round(cor(x_basis, y_sterk), 2), ")"),
    paste0("Matig (r = ", round(cor(x_basis, y_matig), 2), ")"),
    paste0("Zwak (r = ", round(cor(x_basis, y_zwak), 2), ")")
  ), each = n)
)

p3.15 <- ggplot(data_sterkte, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  facet_wrap(~ type, scales = "free_y", ncol = 2) +
  labs(
    title = "Verschillende Correlatiesterktes",
    x = "Variabele X",
    y = "Variabele Y"
  ) +
  theme_minimal()

ggsave("dodona_images/question_3.15.png", p3.15, width = 10, height = 8, dpi = 300)

# ============================================================================
# IMAGE 3.18: Wanneer Spearman (Q18)
# ============================================================================
set.seed(789)
n <- 30

# 1. Lineaire relatie
stress_niveau_1 <- rnorm(n, 50, 10)
agressie_score_1 <- 0.8 * stress_niveau_1 + rnorm(n, 0, 8)
pearson_1 <- round(cor(stress_niveau_1, agressie_score_1, method = "pearson"), 3)
spearman_1 <- round(cor(stress_niveau_1, agressie_score_1, method = "spearman"), 3)

# 2. Niet-lineaire maar monotone relatie
stress_niveau_2 <- runif(n, 1, 10)
agressie_score_2 <- 2 * log(stress_niveau_2 + 1) + rnorm(n, 0, 0.3)
pearson_2 <- round(cor(stress_niveau_2, agressie_score_2, method = "pearson"), 3)
spearman_2 <- round(cor(stress_niveau_2, agressie_score_2, method = "spearman"), 3)

# 3. Data met extreme uitschieters
stress_niveau_3 <- c(rnorm(n-2, 50, 8), 90, 10)
agressie_score_3 <- c(0.6 * rnorm(n-2, 50, 8) + rnorm(n-2, 0, 5), 10, 90)
pearson_3 <- round(cor(stress_niveau_3, agressie_score_3, method = "pearson"), 3)
spearman_3 <- round(cor(stress_niveau_3, agressie_score_3, method = "spearman"), 3)

# 4. Ordinale data (Likert schalen)
stress_niveau_4 <- sample(1:7, n, replace = TRUE, prob = c(0.1, 0.15, 0.2, 0.3, 0.15, 0.08, 0.02))
agressie_score_4 <- pmax(1, pmin(7, stress_niveau_4 + sample(-2:2, n, replace = TRUE)))
pearson_4 <- round(cor(stress_niveau_4, agressie_score_4, method = "pearson"), 3)
spearman_4 <- round(cor(stress_niveau_4, agressie_score_4, method = "spearman"), 3)

data1 <- data.frame(x = stress_niveau_1, y = agressie_score_1, 
                    type = paste0("A. Lineaire Relatie\nPearson r = ", pearson_1, ", Spearman ρ = ", spearman_1))
data2 <- data.frame(x = stress_niveau_2, y = agressie_score_2, 
                    type = paste0("B. Niet-lineaire (Monotone) Relatie\nPearson r = ", pearson_2, ", Spearman ρ = ", spearman_2))
data3 <- data.frame(x = stress_niveau_3, y = agressie_score_3, 
                    type = paste0("C. Data met Extreme Uitschieters\nPearson r = ", pearson_3, ", Spearman ρ = ", spearman_3))
data4 <- data.frame(x = stress_niveau_4, y = agressie_score_4, 
                    type = paste0("D. Ordinale Data (Likert schalen)\nPearson r = ", pearson_4, ", Spearman ρ = ", spearman_4))

all_data <- rbind(data1, data2, data3, data4)

p3.18 <- ggplot(all_data, aes(x = x, y = y)) +
  geom_point(size = 3, color = "steelblue", alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed", formula = y ~ x) +
  facet_wrap(~ type, scales = "free", ncol = 2) +
  labs(
    title = "Wanneer is Spearman's ρ Beter dan Pearson's r?",
    subtitle = "Rode lijn toont lineaire trend (Pearson); Spearman gebruikt rangnummers",
    x = "Stressniveau",
    y = "Agressiescore"
  ) +
  theme_minimal() +
  theme(strip.text = element_text(size = 9, face = "bold"))

ggsave("dodona_images/question_3.18.png", p3.18, width = 12, height = 8, dpi = 300)

print("Second batch of images generated:")
print("- question_3.14.png (Monotoon vs lineair)")
print("- question_3.15.png (Correlatie sterkte)")  
print("- question_3.18.png (Wanneer Spearman)")