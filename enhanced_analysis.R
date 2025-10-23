library(tidyverse)
library(scales)
library(patchwork)
library(viridis)

# ---- Load and Clean Data ------------------------------------------------
df <- read_csv("scoresheet-basisconcepten.csv", show_col_types = FALSE)

status_cols <- df %>% select(starts_with("Status")) %>% names()
df_attempted <- df %>%
  filter(if_any(all_of(status_cols), ~ !is.na(.) & . != "")) %>%
  filter(if_all(all_of(status_cols), ~ . != "unstarted")) %>%
  filter(if_all(all_of(status_cols), ~ . %in% c("correct","wrong")))

cat("📊 Data Overview: ", nrow(df_attempted), "students •", length(status_cols), "exercises\n\n")

# ---- Core Analysis ------------------------------------------------------

# Define Bloom's taxonomy mapping
blooms_mapping <- tibble(
  Exercise = c("1. Meetniveau - Leeftijd van verdachte", "2. Centrale onderzoeksvraag - Doel en functie", 
               "3. Onderzoeksdeelvragen - Functie en toepassing", "4. Observatie en nieuwsgierigheid - Eerste stappen onderzoek",
               "5. Populatie vs. Steekproef", "6. Beschrijvende Statistiek", "7. Nominale Variabele Identificatie",
               "8. Correlatie vs. Causatie", "9. Negatieve Resultaten", "10. Steekproefstrategie Evalueren"),
  Level = c("Remember", "Understand", "Understand", "Understand", "Understand", "Understand", 
            "Apply", "Analyze", "Evaluate", "Evaluate"),
  Weight = c(10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
)

# Print mapping for debugging
cat("🔍 Bloom's mapping defined:\n")
print(blooms_mapping)
cat("\n")

# Student performance
student_perf <- df_attempted %>%
  transmute(
    id, username, first_name, last_name,
    Correct = rowSums(across(all_of(status_cols), ~ . == "correct")),
    Total = length(status_cols),
    Accuracy = round(100 * Correct / Total, 1)
  )

# Exercise difficulty with Bloom's levels
exercise_stats <- df_attempted %>%
  pivot_longer(all_of(status_cols), names_to = "Exercise", values_to = "Status") %>%
  mutate(Exercise = str_remove(Exercise, "^Status\\s*")) %>%
  group_by(Exercise) %>%
  summarise(
    Accuracy = round(100 * mean(Status == "correct"), 1),
    Difficulty = case_when(
      Accuracy >= 85 ~ "Easy",
      Accuracy >= 70 ~ "Moderate", 
      Accuracy >= 55 ~ "Hard",
      TRUE ~ "Very Hard"
    ),
    .groups = "drop"
  ) %>%
  left_join(blooms_mapping, by = "Exercise") %>%
  arrange(desc(Accuracy))

# Bloom's taxonomy performance analysis
blooms_performance <- exercise_stats %>%
  group_by(Level) %>%
  summarise(
    Questions = n(),
    Avg_Accuracy = round(mean(Accuracy), 1),
    Min_Accuracy = min(Accuracy),
    Max_Accuracy = max(Accuracy),
    .groups = "drop"
  ) %>%
  mutate(
    Level = factor(Level, levels = c("Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create")),
    Performance = case_when(
      Avg_Accuracy >= 80 ~ "Strong",
      Avg_Accuracy >= 65 ~ "Good",
      Avg_Accuracy >= 50 ~ "Moderate",
      TRUE ~ "Weak"
    )
  ) %>%
  arrange(Level)

# Student performance by Bloom's level
student_blooms <- df_attempted %>%
  pivot_longer(all_of(status_cols), names_to = "Exercise", values_to = "Status") %>%
  mutate(Exercise = str_remove(Exercise, "^Status\\s*")) %>%
  left_join(blooms_mapping, by = "Exercise") %>%
  group_by(id, username, first_name, last_name, Level) %>%
  summarise(
    Correct = sum(Status == "correct"),
    Total = n(),
    Accuracy = round(100 * Correct / Total, 1),
    .groups = "drop"
  ) %>%
  pivot_wider(names_from = Level, values_from = Accuracy, names_prefix = "Bloom_") %>%
  left_join(student_perf, by = c("id", "username", "first_name", "last_name"))

# Performance bands
student_bands <- student_perf %>%
  mutate(Band = case_when(
    Accuracy >= 90 ~ "90-100%",
    Accuracy >= 75 ~ "75-89%", 
    Accuracy >= 60 ~ "60-74%",
    Accuracy >= 45 ~ "45-59%",
    TRUE ~ "<45%"
  )) %>%
  count(Band) %>%
  mutate(
    Band = factor(Band, levels = c("90-100%","75-89%","60-74%","45-59%","<45%")),
    Percentage = round(100 * n / sum(n), 1)
  )

# ---- Visualizations ----------------------------------------------------

# Define clean color palettes
band_colors <- c("90-100%" = "#27AE60", "75-89%" = "#2ECC71", "60-74%" = "#F39C12", 
                 "45-59%" = "#E67E22", "<45%" = "#E74C3C")

blooms_colors <- c("Remember" = "#9B59B6", "Understand" = "#3498DB", "Apply" = "#2ECC71", 
                   "Analyze" = "#F39C12", "Evaluate" = "#E74C3C", "Create" = "#8E44AD")

difficulty_colors <- c("Easy" = "#27AE60", "Moderate" = "#F39C12", 
                      "Hard" = "#E67E22", "Very Hard" = "#E74C3C")

# Calculate statistics for labels
mean_acc <- round(mean(student_perf$Accuracy), 1)
median_acc <- round(median(student_perf$Accuracy), 1)

# Plot 1: Performance Distribution
p1 <- ggplot(student_bands, aes(x = Band, y = n, fill = Band)) +
  geom_col(width = 0.7, alpha = 0.9) +
  geom_text(aes(label = paste0(n, "\n(", Percentage, "%)")), 
            vjust = -0.2, size = 3.5, fontface = "bold") +
  scale_fill_manual(values = band_colors, guide = "none") +
  labs(title = "🎯 Student Performance Distribution",
       x = "Accuracy Band", y = "Number of Students") +
  expand_limits(y = max(student_bands$n) * 1.15) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        panel.grid.minor = element_blank())

# Plot 2: Bloom's Taxonomy Performance
p2 <- ggplot(blooms_performance, aes(x = Level, y = Avg_Accuracy, fill = Level)) +
  geom_col(width = 0.7, alpha = 0.9) +
  geom_text(aes(label = paste0(Avg_Accuracy, "%\n(", Questions, " Q)")), 
            vjust = -0.2, size = 3.2, fontface = "bold") +
  scale_fill_manual(values = blooms_colors, guide = "none") +
  labs(title = "🧠 Performance by Bloom's Taxonomy Level",
       subtitle = "Average accuracy across cognitive levels",
       x = "Cognitive Level", y = "Average Accuracy (%)") +
  expand_limits(y = 105) +
  theme_minimal(base_size = 11) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray50"),
        axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.minor = element_blank())

# Plot 3: Exercise Difficulty with Bloom's levels
p3 <- ggplot(exercise_stats, aes(x = reorder(Exercise, Accuracy), y = Accuracy, fill = Level)) +
  geom_col(width = 0.8, alpha = 0.9) +
  geom_text(aes(label = paste0(Accuracy, "%")), hjust = -0.1, size = 2.8) +
  scale_fill_manual(values = blooms_colors, name = "Bloom's Level") +
  coord_flip() +
  labs(title = "📚 Exercise Analysis by Cognitive Level",
       x = "Exercise", y = "Accuracy (%)") +
  expand_limits(y = 105) +
  theme_minimal(base_size = 10) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        legend.position = "bottom",
        panel.grid.minor = element_blank())

# Plot 4: Score Distribution with better representation
# Create distribution by individual exercise responses for more variation
exercise_scores <- df_attempted %>%
  pivot_longer(all_of(status_cols), names_to = "Exercise", values_to = "Status") %>%
  mutate(
    Exercise = str_remove(Exercise, "^Status\\s*"),
    Score = ifelse(Status == "correct", 100, 0)
  )

# Calculate statistics for exercise-level scores (more representative)
mean_score <- round(mean(exercise_scores$Score), 1)
median_score <- round(median(exercise_scores$Score), 1)
q1_score <- round(quantile(exercise_scores$Score, 0.25), 1)
q3_score <- round(quantile(exercise_scores$Score, 0.75), 1)

# Student-level stats for comparison
student_mean <- round(mean(student_perf$Accuracy), 1)
student_median <- round(median(student_perf$Accuracy), 1)

p4 <- ggplot(student_perf, aes(x = Accuracy)) +
  geom_histogram(bins = 10, fill = "#3498DB", alpha = 0.7, color = "white", linewidth = 0.5) +
  geom_vline(xintercept = student_mean, color = "#E74C3C", linetype = "dashed", linewidth = 1.2) +
  geom_vline(xintercept = student_median, color = "#27AE60", linetype = "dashed", linewidth = 1.2) +
  # Smart positioning: if mean and median are close, stack the labels
  {if(abs(student_mean - student_median) < 5) {
    list(
      annotate("text", x = student_mean, y = Inf, 
               label = paste("Mean:", student_mean, "%"), 
               vjust = 2.5, hjust = 0.5, color = "#E74C3C", fontface = "bold", size = 3.2),
      annotate("text", x = student_median, y = Inf, 
               label = paste("Median:", student_median, "%"), 
               vjust = 4, hjust = 0.5, color = "#27AE60", fontface = "bold", size = 3.2)
    )
  } else {
    list(
      annotate("text", x = student_mean + 3, y = Inf, 
               label = paste("Mean:", student_mean, "%"), 
               vjust = 1.5, hjust = 0, color = "#E74C3C", fontface = "bold", size = 3.2),
      annotate("text", x = student_median - 3, y = Inf, 
               label = paste("Median:", student_median, "%"), 
               vjust = 1.5, hjust = 1, color = "#27AE60", fontface = "bold", size = 3.2)
    )
  }} +
  # Add summary stats as subtitle
  labs(
    title = "📈 Student Score Distribution",
    subtitle = paste0("Per-student accuracy (Range: ", min(student_perf$Accuracy), "% - ", max(student_perf$Accuracy), "%)"),
    x = "Accuracy (%)", 
    y = "Number of Students"
  ) +
  scale_x_continuous(breaks = seq(0, 100, 20), limits = c(0, 105)) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray50"),
    panel.grid.minor = element_blank()
  )

# Combined Dashboard  
dashboard <- (p1 + p2) / (p3 + p4)
dashboard <- dashboard + plot_annotation(
  title = "📊 DODONA PILOT TEST - BLOOM'S TAXONOMY ANALYSIS",
  subtitle = paste0("Statistics in Criminology • ", nrow(df_attempted), " students • ", length(status_cols), " exercises"),
  theme = theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
                plot.subtitle = element_text(size = 12, hjust = 0.5))
)

print(dashboard)

# ---- Summary Statistics -------------------------------------------------

cat("\n📊 PILOT TEST SUMMARY\n")
cat(rep("=", 50), "\n")

cat("👥 STUDENTS (n =", nrow(student_perf), "):\n")
cat("   Mean accuracy:   ", student_mean, "%\n")
cat("   Median accuracy: ", student_median, "%\n") 
cat("   Std deviation:   ", round(sd(student_perf$Accuracy), 1), "%\n")
cat("   Score range:     ", min(student_perf$Accuracy), "% -", max(student_perf$Accuracy), "%\n")
cat("   Perfect scores:  ", sum(student_perf$Accuracy == 100), "\n")
cat("   Below 80%:       ", sum(student_perf$Accuracy < 80), "\n\n")

cat("📚 EXERCISE-LEVEL STATS:\n")
cat("   Individual responses mean: ", mean_score, "%\n")
cat("   Individual responses median:", median_score, "%\n")
cat("   Q1 (25th percentile):     ", q1_score, "%\n")
cat("   Q3 (75th percentile):     ", q3_score, "%\n\n")

cat("📚 BLOOM'S TAXONOMY ANALYSIS:\n")
print(blooms_performance)
cat("\n")

cat("🎯 COGNITIVE LEVEL INSIGHTS:\n")
best_level <- blooms_performance$Level[which.max(blooms_performance$Avg_Accuracy)]
worst_level <- blooms_performance$Level[which.min(blooms_performance$Avg_Accuracy)]
cat("   • Strongest level:  ", best_level, "(", max(blooms_performance$Avg_Accuracy), "%)\n")
cat("   • Weakest level:   ", worst_level, "(", min(blooms_performance$Avg_Accuracy), "%)\n")

remember_perf <- blooms_performance$Avg_Accuracy[blooms_performance$Level == "Remember"]
understand_perf <- blooms_performance$Avg_Accuracy[blooms_performance$Level == "Understand"]
higher_order <- blooms_performance %>% filter(Level %in% c("Apply", "Analyze", "Evaluate")) %>% pull(Avg_Accuracy)

if(length(remember_perf) > 0) cat("   • Remember level:   ", remember_perf, "%\n")
if(length(understand_perf) > 0) cat("   • Understand level: ", understand_perf, "%\n")
if(length(higher_order) > 0) cat("   • Higher-order avg: ", round(mean(higher_order), 1), "%\n")

cat("\n📚 EXERCISES:\n")
hardest <- exercise_stats$Exercise[which.min(exercise_stats$Accuracy)]
easiest <- exercise_stats$Exercise[which.max(exercise_stats$Accuracy)]
cat("   Hardest: ", hardest, "(", min(exercise_stats$Accuracy), "%)\n")
cat("   Easiest: ", easiest, "(", max(exercise_stats$Accuracy), "%)\n")
cat("   Avg difficulty: ", round(mean(exercise_stats$Accuracy), 1), "%\n\n")

cat("💡 INSIGHTS:\n")
low_performers <- sum(student_perf$Accuracy < 60)
if(low_performers > 0) cat("   • ", low_performers, " students need additional support\n")
hard_questions <- sum(exercise_stats$Accuracy < 60) 
if(hard_questions > 0) cat("   • ", hard_questions, " exercises may need review\n")
cat("   • Overall performance: ", ifelse(student_mean >= 70, "Good", "Needs improvement"), "\n")
cat("   • Distribution: ", 
    ifelse(sd(student_perf$Accuracy) < 10, "Very concentrated", 
           ifelse(sd(student_perf$Accuracy) < 20, "Moderately spread", "Wide spread")), "\n")

# ---- Save Results -------------------------------------------------------

ggsave("pilot_blooms_analysis_dashboard.png", dashboard, width = 14, height = 10, dpi = 300, bg = "white")
write_csv(student_perf, "student_results.csv")
write_csv(exercise_stats, "exercise_analysis.csv")
write_csv(blooms_performance, "blooms_taxonomy_performance.csv")
write_csv(student_blooms, "student_blooms_detailed.csv")

cat("\n💾 Saved: pilot_blooms_analysis_dashboard.png, student_results.csv, exercise_analysis.csv, blooms_taxonomy_performance.csv\n")
cat("✅ Analysis complete!\n")