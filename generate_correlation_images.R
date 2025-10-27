# Generate Images for Dodona Correlation Exercises
# This script extracts R chunks from the correlation exercise and generates PNG images

library(ggplot2)
library(dplyr)
library(gridExtra)
library(flextable)

# Create images directory
if (!dir.exists("dodona_images")) {
  dir.create("dodona_images")
}

# Set global options for consistent image output
options(dpi = 300)

# ============================================================================
# IMAGE 3.3: Correlatie Key Statistics (Q3)
# ============================================================================
set.seed(42)
n <- 45  # Nederlandse gemeenten

# Genereer gecorreleerde criminaliteitsdata
politie <- round(rnorm(n, mean=4.2, sd=1.1), 1)
drugs <- round(25 + rnorm(n, sd=6) - 2.5*scale(politie)[,1]*3, 1)

# Create statistical output for display
png("dodona_images/question_3.3.png", width = 800, height = 600, res = 150)
par(mfrow=c(1,1), mar=c(1,1,1,1))
plot.new()
text(0.5, 0.9, "DESCRIPTIVE STATISTICS", cex=1.5, font=2, adj=0.5)
text(0.1, 0.8, "Politieaanwezigheid (agenten per 1000 inwoners):", cex=1.2, adj=0)
text(0.1, 0.75, paste("  Mean (M):", round(mean(politie), 2)), cex=1.1, adj=0)
text(0.1, 0.7, paste("  Standard Deviation (SD):", round(sd(politie), 2)), cex=1.1, adj=0)
text(0.1, 0.65, paste("  Variance:", round(var(politie), 2)), cex=1.1, adj=0)

text(0.1, 0.55, "Drugsdelicten (per 1000 inwoners):", cex=1.2, adj=0)
text(0.1, 0.5, paste("  Mean (M):", round(mean(drugs), 2)), cex=1.1, adj=0)
text(0.1, 0.45, paste("  Standard Deviation (SD):", round(sd(drugs), 2)), cex=1.1, adj=0)
text(0.1, 0.4, paste("  Variance:", round(var(drugs), 2)), cex=1.1, adj=0)

text(0.5, 0.3, "CORRELATION ANALYSIS", cex=1.5, font=2, adj=0.5)
r_value <- round(cor(politie, drugs), 3)
text(0.1, 0.25, paste("Correlation coefficient (r):", r_value), cex=1.1, adj=0)
text(0.1, 0.2, paste("Coefficient of determination (R²):", round(r_value^2, 3)), cex=1.1, adj=0)
text(0.1, 0.15, paste("Sample size (n):", n), cex=1.1, adj=0)
dev.off()

# ============================================================================
# IMAGE 3.8: Positive Correlation (Q8)
# ============================================================================
set.seed(123)
n <- 80
x <- rnorm(n, 50, 10)
y <- 0.75 * scale(x)[,1] * 10 + rnorm(n, 60, 6)

pos_cor_data <- data.frame(
  Variable_X = x,
  Variable_Y = y
)

r_value <- round(cor(x, y), 2)

p3.8 <- ggplot(pos_cor_data, aes(x = Variable_X, y = Variable_Y)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "darkred") +
  labs(
    title = paste0("Sociale Cohesie vs Misdaadpreventie Effectiviteit (r = ", r_value, ")"),
    x = "Sociale Cohesie Score",
    y = "Misdaadpreventie Effectiviteit",
    caption = "75 Belgische gemeenten"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold"))

ggsave("dodona_images/question_3.8.png", p3.8, width = 10, height = 6, dpi = 300)

# ============================================================================
# IMAGE 3.9: Identieke Statistieken (Q9)
# ============================================================================
set.seed(789)
n <- 40

# Dataset 1: Strong positive correlation
x1 <- rnorm(n, 50, 10)
y1 <- 0.8 * x1 + rnorm(n, 10, 8)

# Dataset 2: Moderate positive correlation  
x2 <- rnorm(n, 50, 10)
y2 <- 0.5 * x2 + rnorm(n, 25, 12)

# Dataset 3: Weak positive correlation
x3 <- rnorm(n, 50, 10)
y3 <- 0.2 * x3 + rnorm(n, 40, 15)

data1 <- data.frame(x = x1, y = y1, type = paste0("Sterke Correlatie (r = ", round(cor(x1,y1), 2), ")"))
data2 <- data.frame(x = x2, y = y2, type = paste0("Matige Correlatie (r = ", round(cor(x2,y2), 2), ")"))
data3 <- data.frame(x = x3, y = y3, type = paste0("Zwakke Correlatie (r = ", round(cor(x3,y3), 2), ")"))

all_data <- rbind(data1, data2, data3)

p3.9 <- ggplot(all_data, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  facet_wrap(~ type, ncol = 3) +
  labs(
    title = "Verschillende Correlatiesterktes",
    x = "Variabele X",
    y = "Variabele Y"
  ) +
  theme_minimal()

ggsave("dodona_images/question_3.9.png", p3.9, width = 12, height = 4, dpi = 300)

# ============================================================================
# IMAGE 3.12: Covariantie vs Correlatie (Q12)
# ============================================================================
set.seed(456)
n <- 30

# Kleine schaal data
x_klein <- rnorm(n, 5, 1)
y_klein <- 0.7 * x_klein + rnorm(n, 0, 0.5)

# Grote schaal data (zelfde patroon, andere schaal)
x_groot <- x_klein * 1000  # Convert to large scale
y_groot <- y_klein * 1000

kleine_schaal <- data.frame(x = x_klein, y = y_klein)
grote_schaal <- data.frame(x = x_groot, y = y_groot)

cov1 <- round(cov(x_klein, y_klein), 2)
cor1 <- round(cor(x_klein, y_klein), 2)
cov2 <- round(cov(x_groot, y_groot), 0)
cor2 <- round(cor(x_groot, y_groot), 2)

p1 <- ggplot(kleine_schaal, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2.5) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred", formula = y ~ x) +
  labs(
    title = paste0("Kleine Schaal: Covariantie = ", cov1, ", Correlatie = ", cor1),
    x = "Variabele X (kleine eenheden)",
    y = "Variabele Y (kleine eenheden)"
  ) +
  theme_minimal()

p2 <- ggplot(grote_schaal, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2.5) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred", formula = y ~ x) +
  labs(
    title = paste0("Grote Schaal: Covariantie = ", cov2, ", Correlatie = ", cor2),
    x = "Variabele X (grote eenheden)",
    y = "Variabele Y (grote eenheden)"
  ) +
  theme_minimal()

p3.12 <- grid.arrange(p1, p2, nrow = 2, 
                      top = grid::textGrob("Covariantie vs. Correlatie: Effect van Schaal", 
                                           gp = grid::gpar(fontsize = 14, fontface = "bold")))

ggsave("dodona_images/question_3.12.png", p3.12, width = 10, height = 8, dpi = 300)

print("Image generation complete! Check the 'dodona_images' directory.")
print("Generated images:")
print("- question_3.3.png (Statistical output)")
print("- question_3.8.png (Positive correlation)")
print("- question_3.9.png (Different correlation strengths)")  
print("- question_3.12.png (Covariance vs correlation)")
print("Continuing with remaining images...")