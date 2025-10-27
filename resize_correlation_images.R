# Resize and Regenerate Correlation Exercise Images
# This script will create properly sized images for correlation exercises 3.1-3.25

library(ggplot2)
library(dplyr)

# Set standard image dimensions (based on reference image)
image_width <- 8    # inches
image_height <- 6   # inches
image_dpi <- 300    # high quality for educational materials

# Standard theme for all correlation exercise images
standard_theme <- theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    panel.grid.major = element_line(color = "lightgray", size = 0.5),
    panel.grid.minor = element_line(color = "lightgray", size = 0.3),
    text = element_text(size = 12, family = "Arial"),
    plot.title = element_text(size = 14, hjust = 0.5, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10)
  )

# Function to save plot with standard dimensions
save_standard_plot <- function(plot, filename) {
  ggsave(filename, plot, 
         width = image_width, height = image_height, 
         dpi = image_dpi, bg = "white")
}

# 3.3 - Correlation Statistics Visualization
create_3_3_image <- function() {
  # Create sample data for correlation matrix visualization
  set.seed(123)
  n <- 45
  police_presence <- rnorm(n, 4.12, 1.3)
  drug_crimes <- rnorm(n, 25.96, 9.58)
  
  # Create scatter plot showing correlation
  p <- ggplot(data.frame(x = police_presence, y = drug_crimes), aes(x = x, y = y)) +
    geom_point(color = "steelblue", size = 2, alpha = 0.7) +
    geom_smooth(method = "lm", color = "red", se = TRUE, alpha = 0.2) +
    labs(
      title = "Correlatie: Politieaanwezigheid vs Drugsdelicten",
      x = "Politieaanwezigheid (agenten per 1000 inwoners)",
      y = "Drugsdelicten (per 1000 inwoners)"
    ) +
    standard_theme
  
  save_standard_plot(p, "3.3 Correlatie - Belangrijkste maatregelen/images/question_3.3.png")
}

# 3.8 - Correlation Interpretation (already exists, just resize)
create_3_8_image <- function() {
  # Social cohesion vs crime prevention effectiveness
  set.seed(456)
  n <- 75
  social_cohesion <- runif(n, 1, 10)
  prevention_effectiveness <- 2 + 0.75 * social_cohesion + rnorm(n, 0, 1.2)
  
  p <- ggplot(data.frame(x = social_cohesion, y = prevention_effectiveness), aes(x = x, y = y)) +
    geom_point(color = "darkgreen", size = 2, alpha = 0.7) +
    geom_smooth(method = "lm", color = "red", se = TRUE, alpha = 0.2) +
    labs(
      title = "Sociale Cohesie vs Misdaadpreventie Effectiviteit",
      x = "Sociale Cohesie Score (1-10)",
      y = "Preventie Effectiviteit Score"
    ) +
    standard_theme
  
  save_standard_plot(p, "3.8 Correlatie - Interpreteer correlatie/images/question_3.8.png")
}

# 3.12 - Covariance vs Correlation
create_3_12_image <- function() {
  set.seed(789)
  x <- rnorm(50, 100, 15)
  y <- 2 * x + rnorm(50, 0, 20)
  
  p <- ggplot(data.frame(x = x, y = y), aes(x = x, y = y)) +
    geom_point(color = "purple", size = 2, alpha = 0.7) +
    geom_smooth(method = "lm", color = "red", se = TRUE, alpha = 0.2) +
    labs(
      title = "Covariantie vs Correlatie Voorbeeld",
      x = "Variabele X",
      y = "Variabele Y"
    ) +
    standard_theme
  
  save_standard_plot(p, "3.12 Correlatie - Covariantie verschillen/images/question_3.12.png")
}

# 3.14 - Pearson vs Spearman
create_3_14_image <- function() {
  set.seed(321)
  x <- c(1:20, 25, 30, 35, 100)  # Include outliers
  y <- c(1:20, 22, 24, 26, 50)   # Non-linear relationship
  
  p <- ggplot(data.frame(x = x, y = y), aes(x = x, y = y)) +
    geom_point(color = "orange", size = 2.5, alpha = 0.8) +
    geom_smooth(method = "lm", color = "blue", se = FALSE, linetype = "dashed", alpha = 0.7) +
    labs(
      title = "Pearson vs Spearman Correlatie",
      subtitle = "Met uitschieters en non-lineaire relatie",
      x = "Variabele X",
      y = "Variabele Y"
    ) +
    standard_theme
  
  save_standard_plot(p, "3.14 Correlatie - Pearson vs Spearman/images/question_3.14.png")
}

# 3.15 - Direction and Strength
create_3_15_image <- function() {
  set.seed(654)
  
  # Create 4 different correlation strengths
  par(mfrow = c(2, 2))
  
  # Strong positive
  x1 <- rnorm(30)
  y1 <- 0.9 * x1 + rnorm(30, 0, 0.3)
  
  # Weak positive  
  x2 <- rnorm(30)
  y2 <- 0.3 * x2 + rnorm(30, 0, 0.8)
  
  # Strong negative
  x3 <- rnorm(30)
  y3 <- -0.85 * x3 + rnorm(30, 0, 0.4)
  
  # No correlation
  x4 <- rnorm(30)
  y4 <- rnorm(30)
  
  # Combine into one plot
  df <- data.frame(
    x = c(x1, x2, x3, x4),
    y = c(y1, y2, y3, y4),
    type = rep(c("Sterk Positief (r≈0.9)", "Zwak Positief (r≈0.3)", 
                 "Sterk Negatief (r≈-0.85)", "Geen Correlatie (r≈0)"), each = 30)
  )
  
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_point(color = "steelblue", size = 1.5, alpha = 0.7) +
    geom_smooth(method = "lm", color = "red", se = FALSE, size = 0.8) +
    facet_wrap(~type, scales = "free") +
    labs(
      title = "Richting en Sterkte van Correlaties",
      x = "Variabele X",
      y = "Variabele Y"
    ) +
    standard_theme +
    theme(strip.text = element_text(size = 10, face = "bold"))
  
  save_standard_plot(p, "3.15 Correlatie - Richting en kracht/images/question_3.15.png")
}

# 3.18 - When to use which correlation
create_3_18_image <- function() {
  set.seed(987)
  
  # Normal data for Pearson
  x_normal <- rnorm(50, 50, 10)
  y_normal <- 0.7 * x_normal + rnorm(50, 0, 5)
  
  # Ordinal/ranked data for Spearman
  x_ordinal <- rank(rexp(50, 0.1))
  y_ordinal <- rank(rexp(50, 0.1))
  
  df <- data.frame(
    x = c(x_normal, x_ordinal),
    y = c(y_normal, y_ordinal),
    type = rep(c("Pearson (Continue Data)", "Spearman (Ordinale Data)"), each = 50)
  )
  
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_point(color = "darkred", size = 2, alpha = 0.6) +
    geom_smooth(method = "lm", color = "blue", se = TRUE, alpha = 0.2) +
    facet_wrap(~type, scales = "free") +
    labs(
      title = "Wanneer Welke Correlatie Gebruiken?",
      x = "Variabele X",
      y = "Variabele Y"
    ) +
    standard_theme +
    theme(strip.text = element_text(size = 11, face = "bold"))
  
  save_standard_plot(p, "3.18 Correlatie - Wanneer welke correlatie/images/question_3.18.png")
}

# 3.19 - Impact of Outliers
create_3_19_image <- function() {
  set.seed(147)
  
  # Normal data
  x_normal <- rnorm(25, 50, 10)
  y_normal <- 0.6 * x_normal + rnorm(25, 0, 5)
  
  # Add outliers
  x_outlier <- c(x_normal, 100, 5)
  y_outlier <- c(y_normal, 20, 80)
  
  df <- data.frame(
    x = c(x_normal, x_outlier),
    y = c(y_normal, y_outlier),
    type = rep(c("Zonder Uitschieters", "Met Uitschieters"), each = 27),
    outlier = c(rep(FALSE, 25), rep(FALSE, 25), c(rep(FALSE, 25), TRUE, TRUE))
  )
  
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_point(aes(color = outlier), size = 2, alpha = 0.7) +
    geom_smooth(method = "lm", color = "red", se = TRUE, alpha = 0.2) +
    scale_color_manual(values = c("FALSE" = "steelblue", "TRUE" = "red")) +
    facet_wrap(~type, scales = "free") +
    labs(
      title = "Impact van Uitschieters op Correlatie",
      x = "Variabele X",
      y = "Variabele Y"
    ) +
    guides(color = "none") +
    standard_theme +
    theme(strip.text = element_text(size = 11, face = "bold"))
  
  save_standard_plot(p, "3.19 Correlatie - Impact uitschieters/images/question_3.19.png")
}

# 3.21 - Correlation Interpretation  
create_3_21_image <- function() {
  set.seed(258)
  
  # Different correlation strengths with criminology context
  correlations <- c(0.9, 0.7, 0.3, 0.1)
  titles <- c("Zeer Sterk (r=0.9)", "Sterk (r=0.7)", "Matig (r=0.3)", "Zwak (r=0.1)")
  
  plots <- list()
  for(i in 1:4) {
    x <- rnorm(40)
    y <- correlations[i] * x + rnorm(40, 0, sqrt(1 - correlations[i]^2))
    
    df_temp <- data.frame(x = x, y = y, strength = titles[i])
    plots[[i]] <- df_temp
  }
  
  df_combined <- do.call(rbind, plots)
  
  p <- ggplot(df_combined, aes(x = x, y = y)) +
    geom_point(color = "darkgreen", size = 1.8, alpha = 0.7) +
    geom_smooth(method = "lm", color = "red", se = FALSE, size = 0.8) +
    facet_wrap(~strength, scales = "free") +
    labs(
      title = "Correlatie Sterkte Interpretatie",
      x = "Variabele X",
      y = "Variabele Y"
    ) +
    standard_theme +
    theme(strip.text = element_text(size = 10, face = "bold"))
  
  save_standard_plot(p, "3.21 Correlatie - Correlatie interpretatie/images/question_3.21.png")
}

# Main execution
print("Starting image generation with proper dimensions...")

# Create all images
create_3_3_image()
print("Created 3.3 image")

create_3_8_image()
print("Created 3.8 image")

create_3_12_image() 
print("Created 3.12 image")

create_3_14_image()
print("Created 3.14 image")

create_3_15_image()
print("Created 3.15 image")

create_3_18_image()
print("Created 3.18 image")

create_3_19_image()
print("Created 3.19 image")

create_3_21_image()
print("Created 3.21 image")

print("All correlation exercise images have been regenerated with proper dimensions!")
print(paste("Image dimensions:", image_width, "x", image_height, "inches at", image_dpi, "DPI"))