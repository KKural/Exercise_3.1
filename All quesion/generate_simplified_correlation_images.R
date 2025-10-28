# =============================================================================
# SIMPLIFIED DODONA CORRELATION EXERCISES - IMAGE GENERATION SCRIPT
# =============================================================================
# This script generates all visualization images for correlation exercises
# Direct generation without unnecessary function wrappers
# =============================================================================

# Load required libraries
library(ggplot2)
library(dplyr)
library(gridExtra)
library(tidyr)

# Set random seed for reproducibility
set.seed(42)

# Define the path to the appropriate Dodona directory
question_dirs <- c(
  "3" = "3.3 Correlatie - Belangrijkste maatregelen",
  "8" = "3.8 Correlatie - Interpreteer correlatie", 
  "9" = "3.9 Correlatie - Wat correlatie vertelt",
  "11" = "3.11 Correlatie - Visualisatie belang",
  "12" = "3.12 Correlatie - Covariantie verschillen",
  "14" = "3.14 Correlatie - Pearson vs Spearman",
  "15" = "3.15 Correlatie - Richting en kracht",
  "18" = "3.18 Correlatie - Wanneer welke correlatie",
  "19" = "3.19 Correlatie - Impact uitschieters",
  "21" = "3.21 Correlatie - Correlatie interpretatie",
  "23" = "3.23 Correlatie - Correlatie aannames"
)

# Function to save images to appropriate directories
save_dodona_image <- function(plot, question_num, width = 5, height = 3.5) {
  # Create directory if it doesn't exist
  dir_name <- question_dirs[as.character(question_num)]
  if (!is.na(dir_name)) {
    media_path <- file.path(dir_name, "media")
    if (!dir.exists(media_path)) {
      dir.create(media_path, recursive = TRUE)
    }
    
    # Save the image
    filename <- file.path(media_path, paste0("correlation_plot_", question_num, ".png"))
    ggsave(filename, plot, width = width, height = height, dpi = 300, bg = "white")
    cat("Saved:", filename, "- Size:", width, "x", height, "\n")
  }
}

# =============================================================================
# DIRECT IMAGE GENERATION
# =============================================================================

cat("=============================================================================\n")
cat("GENERATING ALL DODONA CORRELATION EXERCISE IMAGES\n")
cat("=============================================================================\n")

# QUESTION 3.3 - Key correlation measures
cat("\n=== Generating Q3.3 Image: Belangrijkste maatregelen ===\n")

# Generate realistic criminological data
n <- 45  # Belgian municipalities
politie <- round(rnorm(n, mean=4.2, sd=1.1), 1)
drugs <- round(25 + rnorm(n, sd=6) - 2.5*scale(politie)[,1]*3, 1)

crime_data <- data.frame(
  "Politieaanwezigheid" = politie,
  "Drugsdelicten" = drugs
)

r_value <- round(cor(crime_data$Politieaanwezigheid, crime_data$Drugsdelicten), 3)
r_squared <- round(r_value^2, 3)

p_q3 <- ggplot(crime_data, aes(x = Politieaanwezigheid, y = Drugsdelicten)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "darkred") +
  labs(
    title = "Correlatie: Politieaanwezigheid vs Drugsdelicten",
    subtitle = paste0("r = ", r_value, ", R² = ", r_squared, ", n = ", n),
    x = "Politieaanwezigheid (agenten per 1000 inwoners)",
    y = "Drugsdelicten (per 1000 inwoners)",
    caption = "Belangrijkste correlatiemaatregelen voor rapportage"
  ) +
  theme_minimal()

save_dodona_image(p_q3, 3)

# QUESTION 3.8 - Interpret correlation
cat("\n=== Generating Q3.8 Image: Interpreteer correlatie ===\n")

# Generate data for positive correlation of 0.75
n <- 80
x <- rnorm(n, 50, 10)
y <- 0.75 * scale(x)[,1] * 10 + rnorm(n, 60, 6)

pos_cor_data <- data.frame(
  Variable_X = x,
  Variable_Y = y
)

r_value <- round(cor(x, y), 2)
r_squared <- round(r_value^2 * 100, 1)

p_q8 <- ggplot(pos_cor_data, aes(x = Variable_X, y = Variable_Y)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "darkred") +
  labs(
    title = "Spreidingsdiagram: Relatie tussen Twee Variabelen",
    subtitle = "Observatiepatroon in criminologische data (N = 75 gemeenten)",
    x = "Sociale Cohesie Score (gestandaardiseerd)",
    y = "Preventie Effectiviteit Index",
    caption = "Data tonen een consistent patroon tussen de gemeten variabelen"
  ) +
  theme_minimal()

save_dodona_image(p_q8, 8, width = 5.0, height = 3.5)

# QUESTION 3.11 - Visualization importance (Anscombe's Quartet style)
cat("\n=== Generating Q3.11 Image: Visualisatie belang ===\n")

# Recreate identical statistics with different patterns
data_x1 <- c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5)
data_y1 <- c(8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26, 10.84, 4.82, 5.68)
data_x2 <- c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5)
data_y2 <- c(9.14, 8.14, 8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74)
data_x3 <- c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5)
data_y3 <- c(7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73)
data_x4 <- c(8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8)
data_y4 <- c(6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89)

# Calculate statistics (they're identical for all datasets)
corr <- round(cor(data_x1, data_y1), 2)
mean_x <- round(mean(data_x1), 2)
mean_y <- round(mean(data_y1), 2)
sd_x <- round(sd(data_x1), 2)
sd_y <- round(sd(data_y1), 2)

# Combine the data
data_df <- data.frame(
  x1 = data_x1, y1 = data_y1,
  x2 = data_x2, y2 = data_y2,
  x3 = data_x3, y3 = data_y3,
  x4 = data_x4, y4 = data_y4
)

# Transform to long format for easier plotting
data_long <- data_df %>%
  mutate(id = row_number()) %>%
  gather(key, value, -id) %>%
  separate(key, c("axis", "dataset"), sep = 1) %>%
  spread(axis, value) %>%
  select(dataset, id, x, y)

# Create descriptive names for the datasets
dataset_names <- c(
  "1" = "Studie A: Lineair patroon",
  "2" = "Studie B: Gebogen relatie",
  "3" = "Studie C: Extreme uitschieter",
  "4" = "Studie D: Kunstmatige associatie"
)

# Plot the data
p_q11 <- ggplot(data_long, aes(x = x, y = y)) +
  geom_point(size = 3, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  facet_wrap(~ dataset, ncol = 2, labeller = labeller(dataset = dataset_names)) +
  labs(
    title = "Vier Studies met Identieke Statistieken maar Verschillende Patronen",
    subtitle = paste0("Alle studies: r = ", corr, ", Gem. x = ", mean_x, 
                      ", Gem. y = ", mean_y, ", SD x = ", sd_x, ", SD y = ", sd_y),
    caption = "Waarom samenvatting statistieken alleen onvoldoende zijn voor dataanalyse",
    x = "Sociaaleconomische Factor",
    y = "Criminaliteitsmaat"
  ) +
  theme_minimal()

save_dodona_image(p_q11, 11, width = 6.0, height = 4.5)

# QUESTION 3.12 - Covariance vs Correlation differences
cat("\n=== Generating Q3.12 Image: Covariantie verschillen ===\n")

# Generate two datasets with same correlation but different scales
n <- 50

# Dataset 1: Small scale variables
x1 <- rnorm(n, 5, 1)
y1 <- 0.7 * scale(x1)[,1] * 1 + rnorm(n, 5, 0.6)
cov1 <- round(cov(x1, y1), 2)
cor1 <- round(cor(x1, y1), 2)

# Dataset 2: Large scale variables (100x)
x2 <- x1 * 100
y2 <- y1 * 100
cov2 <- round(cov(x2, y2), 0)
cor2 <- round(cor(x2, y2), 2)

# Create combined data frame
kleine_schaal <- data.frame(x = x1, y = y1, dataset = "Kleine Schaal Variabelen")
grote_schaal <- data.frame(x = x2, y = y2, dataset = "Grote Schaal Variabelen (x100)")

# Create visualization with two plots
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

# Combine plots
p_q12 <- grid.arrange(p1, p2, nrow = 2,
         top = grid::textGrob("Covariantie vs. Correlatie: Effect van Schaal", 
                              gp = grid::gpar(fontsize = 14, fontface = "bold")))

save_dodona_image(p_q12, 12, width = 5.5, height = 4.0)

# QUESTION 3.14 - Pearson vs Spearman (monotonic vs linear)
cat("\n=== Generating Q3.14 Image: Pearson vs Spearman ===\n")

# Create data for monotonic but non-linear pattern
n <- 50
stress <- runif(n, 1, 10)
agressie <- 3 * log(stress) + rnorm(n, 0, 0.5)

# Calculate both correlations
pearson_r <- round(cor(stress, agressie, method = "pearson"), 3)
spearman_rho <- round(cor(stress, agressie, method = "spearman"), 3)

data_plot <- data.frame(stress = stress, agressie = agressie)

p_q14 <- ggplot(data_plot, aes(x = stress, y = agressie)) +
  geom_point(color = "darkred", size = 2.5, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "blue", linetype = "dashed", 
              aes(color = "Lineaire lijn (Pearson)")) +
  geom_smooth(method = "loess", se = FALSE, color = "red", linewidth = 1,
              aes(color = "Werkelijke curve")) +
  scale_color_manual(values = c("Lineaire lijn (Pearson)" = "blue", 
                               "Werkelijke curve" = "red")) +
  labs(
    title = "Monotone vs. Lineaire Relatie: Stress en Agressie",
    subtitle = paste0("Pearson r = ", pearson_r, ", Spearman ρ = ", spearman_rho),
    x = "Stressniveau",
    y = "Agressief Gedrag",
    color = "Trendlijn Type",
    caption = "Spearman vangt monotone relaties beter op dan Pearson"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom",
        plot.title = element_text(size = 12, face = "bold"))

save_dodona_image(p_q14, 14, width = 5.0, height = 3.5)

# QUESTION 3.15 - Direction and strength patterns
cat("\n=== Generating Q3.15 Image: Richting en kracht ===\n")

# Create four datasets with different correlation patterns
n <- 60

# Function to create data with specific correlation strength
create_correlation_data <- function(r_target, direction = "positive") {
  x <- rnorm(n, 50, 10)
  if (direction == "positive") {
    y <- r_target * scale(x)[,1] * 8 + rnorm(n, 50, sqrt(1 - r_target^2) * 8)
  } else {
    y <- -r_target * scale(x)[,1] * 8 + rnorm(n, 50, sqrt(1 - r_target^2) * 8)
  }
  return(data.frame(x = x, y = y))
}

# Generate four different patterns
strong_pos <- create_correlation_data(0.85, "positive") %>% mutate(pattern = "Sterke Positieve (r ≈ +0.85)")
moderate_pos <- create_correlation_data(0.45, "positive") %>% mutate(pattern = "Matige Positieve (r ≈ +0.45)")
moderate_neg <- create_correlation_data(0.45, "negative") %>% mutate(pattern = "Matige Negatieve (r ≈ -0.45)")
strong_neg <- create_correlation_data(0.85, "negative") %>% mutate(pattern = "Sterke Negatieve (r ≈ -0.85)")

# Combine all data
all_patterns <- rbind(strong_pos, moderate_pos, moderate_neg, strong_neg)

p_q15 <- ggplot(all_patterns, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred", formula = y ~ x) +
  facet_wrap(~ pattern, ncol = 2, scales = "free") +
  labs(
    title = "Correlatiepatronen: Richting en Sterkte Combinaties",
    subtitle = "Verschillende sterktes en richtingen van correlatie",
    x = "Sociale Binding Score",
    y = "Delinquent Gedrag Index",
    caption = "Positieve correlatie: beiden stijgen samen; Negatieve: tegengestelde richting"
  ) +
  theme_minimal() +
  theme(strip.text = element_text(size = 8))

save_dodona_image(p_q15, 15, width = 6.0, height = 4.5)

# QUESTION 3.18 - When to use which correlation
cat("\n=== Generating Q3.18 Image: Wanneer welke correlatie ===\n")

# Create examples of different data types requiring different correlations
n <- 40

# Example 1: Continuous data (Pearson)
continuous_data <- data.frame(
  x = rnorm(n, 100, 15),
  y = rnorm(n, 100, 15)
) %>% 
  mutate(y = 0.6 * scale(x)[,1] * 15 + y,
         type = "Continue Data (Pearson)")

# Example 2: Ordinal/Ranked data (Spearman)
set.seed(456)
ordinal_ranks <- data.frame(
  x = sample(1:n, n),
  y = sample(1:n, n)
)
# Make them somewhat correlated
ordinal_ranks$y <- ordinal_ranks$x + sample(-10:10, n, replace = TRUE)
ordinal_ranks$y[ordinal_ranks$y < 1] <- 1
ordinal_ranks$y[ordinal_ranks$y > n] <- n
ordinal_ranks$type <- "Ordinale Data (Spearman)"

# Example 3: Binary + Continuous (Point-biserial)
binary_cont <- data.frame(
  x = rep(c(0, 1), each = n/2),
  y = c(rnorm(n/2, 45, 8), rnorm(n/2, 55, 8)),
  type = "Binair + Continu (Point-biserial)"
)

# Example 4: Categorical (Chi-square/Cramér's V)
categorical <- expand.grid(
  x = factor(rep(c("Laag", "Gemiddeld", "Hoog"), each = n/3)),
  y = factor(rep(c("Stedelijk", "Voorstedelijk", "Landelijk"), n/3))
) %>%
  mutate(type = "Categorische Data (Cramér's V)",
         x_num = as.numeric(x),
         y_num = as.numeric(y))

# Combine and create visualization
p1 <- ggplot(continuous_data, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred") +
  labs(title = "Continue Data (Pearson)", x = "Variabele X", y = "Variabele Y") +
  theme_minimal()

p2 <- ggplot(ordinal_ranks, aes(x = x, y = y)) +
  geom_point(color = "forestgreen", size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred") +
  labs(title = "Ordinale Data (Spearman)", x = "Rang X", y = "Rang Y") +
  theme_minimal()

p3 <- ggplot(binary_cont, aes(x = factor(x), y = y)) +
  geom_boxplot(fill = "orange", alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.6) +
  labs(title = "Binair + Continu (Point-biserial)", x = "Binaire Variabele", y = "Continue Variabele") +
  theme_minimal()

p4 <- ggplot(categorical, aes(x = x_num, y = y_num)) +
  geom_jitter(color = "purple", size = 2, width = 0.3, height = 0.3) +
  scale_x_continuous(breaks = 1:3, labels = c("Laag", "Gemiddeld", "Hoog")) +
  scale_y_continuous(breaks = 1:3, labels = c("Stedelijk", "Voorstedelijk", "Landelijk")) +
  labs(title = "Categorische Data (Cramér's V)", x = "Sociaaleconomische Status", y = "Buurttype") +
  theme_minimal()

# Combine all plots
p_q18 <- grid.arrange(p1, p2, p3, p4, ncol = 2,
         top = grid::textGrob("Correlatiemethoden voor Verschillende Datatypen", 
                              gp = grid::gpar(fontsize = 14, fontface = "bold")))

save_dodona_image(p_q18, 18, width = 6.5, height = 5.0)

# QUESTION 3.19 - Impact of outliers
cat("\n=== Generating Q3.19 Image: Impact uitschieters ===\n")

# Create data with and without outliers
n <- 40

# Base data with moderate correlation
set.seed(789)
x_base <- rnorm(n, 50, 10)
y_base <- 0.4 * scale(x_base)[,1] * 8 + rnorm(n, 50, 8)

# Data without outlier
data_normal <- data.frame(x = x_base, y = y_base, type = "Zonder Uitbijter")

# Data with outlier
data_outlier <- data.frame(
  x = c(x_base, 90),
  y = c(y_base, 90),
  type = "Met Uitbijter"
)

# Calculate correlations
r_normal <- round(cor(data_normal$x, data_normal$y), 3)
r_outlier <- round(cor(data_outlier$x, data_outlier$y), 3)

# Combine data
all_data <- rbind(data_normal, data_outlier)

p_q19 <- ggplot(all_data, aes(x = x, y = y)) +
  geom_point(aes(color = ifelse(x > 80 & y > 80, "Uitbijter", "Normale data")), 
             size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred", formula = y ~ x) +
  facet_wrap(~ type, ncol = 2) +
  scale_color_manual(values = c("Normale data" = "steelblue", "Uitbijter" = "red")) +
  labs(
    title = "Impact van Uitbijters op Correlatiecoëfficiënt",
    subtitle = paste0("Zonder uitbijter: r = ", r_normal, " | Met uitbijter: r = ", r_outlier),
    x = "Leeftijd bij Eerste Arrestatie",
    y = "Aantal Latere Arrestaties",
    color = "Datapunt Type",
    caption = "Uitbijters kunnen correlatiecoëfficiënten substantieel beïnvloeden"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

save_dodona_image(p_q19, 19, width = 5.5, height = 3.8)

# QUESTION 3.21 - Correlation interpretation scenarios
cat("\n=== Generating Q3.21 Image: Correlatie interpretatie ===\n")

# Create different correlation scenarios for interpretation
n <- 50

# Scenario 1: Strong positive correlation
scenario1 <- data.frame(
  x = rnorm(n, 50, 10),
  scenario = "Scenario A: r = +0.78"
)
scenario1$y <- 0.78 * scale(scenario1$x)[,1] * 8 + rnorm(n, 50, 6)

# Scenario 2: Weak negative correlation
scenario2 <- data.frame(
  x = rnorm(n, 50, 10),
  scenario = "Scenario B: r = -0.23"
)
scenario2$y <- -0.23 * scale(scenario2$x)[,1] * 8 + rnorm(n, 50, 9)

# Scenario 3: No correlation
scenario3 <- data.frame(
  x = rnorm(n, 50, 10),
  scenario = "Scenario C: r ≈ 0.00"
)
scenario3$y <- rnorm(n, 50, 8)

# Scenario 4: Moderate negative correlation
scenario4 <- data.frame(
  x = rnorm(n, 50, 10),
  scenario = "Scenario D: r = -0.55"
)
scenario4$y <- -0.55 * scale(scenario4$x)[,1] * 8 + rnorm(n, 50, 7)

# Combine all scenarios
all_scenarios <- rbind(scenario1, scenario2, scenario3, scenario4)

p_q21 <- ggplot(all_scenarios, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred", formula = y ~ x) +
  facet_wrap(~ scenario, ncol = 2) +
  labs(
    title = "Verschillende Correlatiescenario's voor Interpretatie",
    subtitle = "Hoe interpreteer je verschillende correlatiesterktes?",
    x = "Sociaaleconomische Status",
    y = "Misdaadcijfer per 1000 inwoners",
    caption = "Sterkte interpretatie: |r| < 0.3 zwak, 0.3-0.7 matig, > 0.7 sterk"
  ) +
  theme_minimal() +
  theme(strip.text = element_text(size = 9))

save_dodona_image(p_q21, 21, width = 6.0, height = 4.5)

# QUESTION 3.23 - Correlation assumptions
cat("\n=== Generating Q3.23 Image: Correlatie aannames ===\n")

# Create examples showing when correlation assumptions are violated
n <- 60

# Example 1: Normal linear relationship (assumptions met)
normal_data <- data.frame(
  x = rnorm(n, 50, 10),
  type = "Aannames Voldaan"
)
normal_data$y <- 0.6 * scale(normal_data$x)[,1] * 8 + rnorm(n, 50, 6)

# Example 2: Non-linear relationship (linearity assumption violated)
nonlinear_data <- data.frame(
  x = seq(10, 90, length.out = n),
  type = "Lineariteit Geschonden"
)
nonlinear_data$y <- 30 + 0.3 * (nonlinear_data$x - 50)^2 + rnorm(n, 0, 5)

# Example 3: Heteroscedasticity (homoscedasticity assumption violated)
hetero_data <- data.frame(
  x = seq(20, 80, length.out = n),
  type = "Homoscedasticiteit Geschonden"
)
hetero_data$y <- 20 + 0.5 * hetero_data$x + rnorm(n, 0, hetero_data$x * 0.2)

# Example 4: Outliers present (normality/no outliers assumption violated)
outlier_data <- data.frame(
  x = c(rnorm(n-3, 50, 8), c(20, 80, 85)),
  y = c(rnorm(n-3, 50, 8), c(80, 20, 85)),
  type = "Uitbijters Aanwezig"
)
outlier_data$y[1:(n-3)] <- 0.5 * scale(outlier_data$x[1:(n-3)])[,1] * 8 + outlier_data$y[1:(n-3)]

# Combine all data
all_data <- rbind(normal_data, nonlinear_data, hetero_data, outlier_data)

p_q23 <- ggplot(all_data, aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  facet_wrap(~ type, ncol = 2) +
  labs(
    title = "Pearson Correlatie Aannames: Voldaan vs. Geschonden",
    subtitle = "Wanneer is Pearson correlatie betrouwbaar?",
    x = "Variabele X",
    y = "Variabele Y",
    caption = "Pearson correlatie werkt best bij lineaire, homoscedastische relaties zonder uitbijters"
  ) +
  theme_minimal() +
  theme(strip.text = element_text(size = 9))

save_dodona_image(p_q23, 23, width = 6.0, height = 4.5)

# =============================================================================
# COMPLETION SUMMARY
# =============================================================================

cat("\n=============================================================================\n")
cat("IMAGE GENERATION COMPLETE!\n")
cat("=============================================================================\n")
cat("Total images generated: 10\n")
cat("All images saved to respective media/ folders with custom dimensions\n")
cat("=============================================================================\n")

# Print summary of image dimensions
cat("\n=== IMAGE DIMENSION SUMMARY ===\n")
image_specs <- data.frame(
  Question = c("Q3.3", "Q3.8", "Q3.11", "Q3.12", "Q3.14", "Q3.15", "Q3.18", "Q3.19", "Q3.21", "Q3.23"),
  Description = c("Belangrijkste maatregelen", "Interpreteer correlatie", "Visualisatie belang", 
                  "Covariantie verschillen", "Pearson vs Spearman", "Richting en kracht",
                  "Wanneer welke correlatie", "Impact uitschieters", "Correlatie interpretatie", 
                  "Correlatie aannames"),
  Width = c(4.5, 5.0, 6.0, 5.5, 5.0, 6.0, 6.5, 5.5, 6.0, 6.0),
  Height = c(3.2, 3.5, 4.5, 4.0, 3.5, 4.5, 5.0, 3.8, 4.5, 4.5),
  Panels = c(1, 1, 4, 2, 1, 4, 4, 2, 4, 4)
)

print(image_specs)

cat("\n=== SCRIPT EXECUTION COMPLETED ===\n")