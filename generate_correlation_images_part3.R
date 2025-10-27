# Generate Final Images for Dodona Correlation Exercises (Part 3)

library(ggplot2)
library(dplyr)
library(gridExtra)

# ============================================================================
# IMAGE 3.19: Uitschieter Impact (Q19)
# ============================================================================
set.seed(123)
n <- 30
x_basis <- rnorm(n, 50, 10)
y_basis <- 0.7 * scale(x_basis)[,1] * 8 + rnorm(n, 60, 5)

# Maak datasets met verschillende uitschieters
x_uitschieter1 <- c(x_basis, 100)  # hoog-hoog (rechts boven)
y_uitschieter1 <- c(y_basis, 100)

x_uitschieter2 <- c(x_basis, 0)    # laag-laag (links onder)
y_uitschieter2 <- c(y_basis, 0)

x_uitschieter3 <- c(x_basis, 100)  # hoog-laag (rechts onder)
y_uitschieter3 <- c(y_basis, 0)

x_uitschieter4 <- c(x_basis, 0)    # laag-hoog (links boven)
y_uitschieter4 <- c(y_basis, 100)

# Bereken correlaties
cor1 <- round(cor(x_uitschieter1, y_uitschieter1), 2)
cor2 <- round(cor(x_uitschieter2, y_uitschieter2), 2)
cor3 <- round(cor(x_uitschieter3, y_uitschieter3), 2)
cor4 <- round(cor(x_uitschieter4, y_uitschieter4), 2)
cor_basis <- round(cor(x_basis, y_basis), 2)

# Combineer in één dataframe voor plotten
uitschieter_data <- data.frame(
  dataset = rep(c("Geen Uitschieter", "Hoog-Hoog Uitschieter", 
                 "Laag-Laag Uitschieter", "Hoog-Laag Uitschieter", 
                 "Laag-Hoog Uitschieter"), each=n+1),
  x = c(x_basis, NA, x_uitschieter1, x_uitschieter2, x_uitschieter3, x_uitschieter4),
  y = c(y_basis, NA, y_uitschieter1, y_uitschieter2, y_uitschieter3, y_uitschieter4),
  uitschieter = c(rep(FALSE, n), TRUE, rep(c(rep(FALSE, n), TRUE), 4))
)

# Verwijder de NA rij
uitschieter_data <- uitschieter_data[!is.na(uitschieter_data$x),]

# Voeg correlatie informatie toe
dataset_labels <- c(
  "Geen Uitschieter" = paste0("Geen Uitschieter (r = ", cor_basis, ")"),
  "Hoog-Hoog Uitschieter" = paste0("Hoog-Hoog Uitschieter (r = ", cor1, ")"),
  "Laag-Laag Uitschieter" = paste0("Laag-Laag Uitschieter (r = ", cor2, ")"),
  "Hoog-Laag Uitschieter" = paste0("Hoog-Laag Uitschieter (r = ", cor3, ")"),
  "Laag-Hoog Uitschieter" = paste0("Laag-Hoog Uitschieter (r = ", cor4, ")")
)

uitschieter_data$dataset_labeled <- dataset_labels[uitschieter_data$dataset]

p3.19 <- ggplot(uitschieter_data, aes(x = x, y = y, color = uitschieter)) +
  geom_point(size = ifelse(uitschieter_data$uitschieter, 4, 2), alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  scale_color_manual(values = c("FALSE" = "steelblue", "TRUE" = "red")) +
  facet_wrap(~ dataset_labeled, scales = "free", ncol = 3) +
  labs(
    title = "Impact van Uitschieters op Correlatie",
    subtitle = "Rode punten zijn uitschieters, rode lijn toont correlatie",
    x = "Variabele X",
    y = "Variabele Y"
  ) +
  theme_minimal() +
  theme(legend.position = "none",
        strip.text = element_text(size = 9))

ggsave("dodona_images/question_3.19.png", p3.19, width = 12, height = 8, dpi = 300)

# ============================================================================
# IMAGE 3.21: Interpretatie Correlatie (Q21)
# ============================================================================
set.seed(456)
n <- 100

# Genereer data met r = 0.40
x <- rnorm(n, 50, 15)
y <- 0.40 * scale(x)[,1] * 12 + rnorm(n, 60, 10)

# Bereken daadwerkelijke correlatie
actual_r <- round(cor(x, y), 2)
r_squared <- round(actual_r^2, 2)

correlation_data <- data.frame(
  SES = x,
  Criminaliteit = y
)

p3.21 <- ggplot(correlation_data, aes(x = SES, y = Criminaliteit)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred", formula = y ~ x) +
  labs(
    title = paste0("Relatie tussen SES en Criminaliteit (r = ", actual_r, ")"),
    subtitle = paste0("R² = ", r_squared, " (", round(r_squared * 100, 1), "% verklaarde variantie)"),
    x = "Sociaaleconomische Status (SES)",
    y = "Criminaliteitscijfer",
    caption = "Elke punt vertegenwoordigt een buurt"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold"))

ggsave("dodona_images/question_3.21.png", p3.21, width = 10, height = 6, dpi = 300)

# ============================================================================
# IMAGE 3.23: Correlatie Aannames (Q23)
# ============================================================================
set.seed(123)
n <- 50

# Dataset 1: Voldoet aan alle aannames (ideaal)
x1 <- rnorm(n, 50, 10)
y1 <- 20 + 0.6*x1 + rnorm(n, 0, 5)
data1 <- data.frame(x = x1, y = y1, type = "A. Ideaal: Lineair, Normaal, Geen Uitschieters")

# Dataset 2: Niet-lineaire relatie (schending lineariteit)
x2 <- seq(10, 90, length.out = n)
y2 <- 0.01*x2^2 + rnorm(n, 0, 8)
data2 <- data.frame(x = x2, y = y2, type = "B. Schending: Niet-lineaire Relatie")

# Dataset 3: Extreme uitschieters (schending normaliteit/robuustheid)
x3 <- rnorm(n-2, 50, 10)
y3 <- 20 + 0.6*x3 + rnorm(n-2, 0, 5)
x3 <- c(x3, 80, 20)  # Voeg uitschieters toe
y3 <- c(y3, 20, 80)  # Extreme afwijkende punten
data3 <- data.frame(x = x3, y = y3, type = "C. Schending: Extreme Uitschieters Aanwezig")

# Dataset 4: Heteroscedasticiteit (ongelijke variantie)
x4 <- seq(10, 90, length.out = n)
y4 <- 20 + 0.6*x4 + rnorm(n, 0, x4/10)  # Variantie neemt toe met x
data4 <- data.frame(x = x4, y = y4, type = "D. Schending: Ongelijke Variantie (Heteroscedasticiteit)")

# Combineer alle datasets
all_data <- rbind(data1, data2, data3, data4)

# Bereken correlaties voor elke dataset
cor1 <- round(cor(x1, y1), 3)
cor2 <- round(cor(x2, y2), 3)
cor3 <- round(cor(x3, y3), 3)
cor4 <- round(cor(x4, y4), 3)

# Update labels met correlaties
all_data$type <- factor(all_data$type, levels = unique(all_data$type))
levels(all_data$type) <- c(
  paste0("A. Ideaal: r = ", cor1),
  paste0("B. Niet-lineair: r = ", cor2, " (misleidend)"),
  paste0("C. Uitschieters: r = ", cor3, " (beïnvloed)"),
  paste0("D. Ongelijke var.: r = ", cor4, " (onbetrouwbaar)")
)

p3.23 <- ggplot(all_data, aes(x = x, y = y)) +
  geom_point(size = 2.5, color = "steelblue", alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  facet_wrap(~ type, scales = "free", ncol = 2) +
  labs(
    title = "Veronderstellingen van Pearson's Correlatie",
    subtitle = "Hoe schendingen van aannames de resultaten beïnvloeden",
    x = "X Variabele",
    y = "Y Variabele"
  ) +
  theme_minimal() +
  theme(strip.text = element_text(size = 10, face = "bold"))

ggsave("dodona_images/question_3.23.png", p3.23, width = 12, height = 8, dpi = 300)

print("Final batch of images generated:")
print("- question_3.19.png (Uitschieter impact)")
print("- question_3.21.png (Interpretatie correlatie)")  
print("- question_3.23.png (Correlatie aannames)")
print("")
print("All visualization images are now complete!")