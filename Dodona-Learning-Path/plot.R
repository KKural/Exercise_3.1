# ----------------------------
# 1. Install Required Packages
# ----------------------------
install.packages(c("ggplot2", "dplyr", "tibble", "purrr"))

# ----------------------------
# 2. Load Packages
# ----------------------------
library(ggplot2)
library(dplyr)
library(tibble)
library(purrr)

# ----------------------------
# 3. Define Data
# ----------------------------
pyramid_data <- tibble::tibble(
  level = factor(c("Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create"),
                 levels = c("Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create")),
  count = c(1, 3, 4, 3, 3, 1),
  color = c("#8E44AD", "#2980B9", "#27AE60", "#F1C40F", "#E67E22", "#E74C3C"),
  keywords = c(
    "Define, duplicate, list",
    "Classify, explain, report",
    "Execute, implement, use",
    "Differentiate, compare, test",
    "Appraise, critique, support",
    "Design, develop, construct"
  )
)

# ----------------------------
# 4. Function to Build Each Layer
# ----------------------------
make_layer <- function(index, total = 6) {
  width_base <- total - index + 1
  width_top <- total - index + 0.5
  y_bottom <- index - 1
  y_top <- index

  tibble(
    x = c(-width_base, width_base, width_top, -width_top),
    y = c(y_bottom, y_bottom, y_top, y_top),
    level = pyramid_data$level[index],
    fill = pyramid_data$color[index],
    count = pyramid_data$count[index],
    label = paste0(
      total - index + 1, ". ", pyramid_data$level[index], "\n(",
      pyramid_data$count[index], " question", ifelse(pyramid_data$count[index] > 1, "s", ""), ")\n",
      pyramid_data$keywords[index]
    ),
    group = index
  )
}

# ----------------------------
# 5. Build Polygon and Label Data
# ----------------------------
polygon_df <- purrr::map_dfr(1:6, make_layer)

label_df <- polygon_df %>%
  group_by(group) %>%
  summarize(
    x = 0,
    y = mean(y),
    label = first(label),
    fill = first(fill)
  )

# ----------------------------
# 6. Create Plot
# ----------------------------
pyramid_plot <- ggplot() +
  geom_polygon(data = polygon_df, aes(x = x, y = y, group = group, fill = fill), color = "black") +
  geom_text(data = label_df, aes(x = x, y = y, label = label), color = "white", size = 3.5, lineheight = 1.1) +
  scale_fill_identity() +
  coord_fixed() +
  theme_void() +
  ggtitle("Bloom’s Taxonomy Pyramid of Dodona Questions") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))

# Display
print(pyramid_plot)

# ----------------------------
# 7. Save as PNG
# ----------------------------
ggsave("Dodona-Learning-Path/bloom_taxonomy_pyramid_r.png", plot = pyramid_plot, width = 8, height = 6, dpi = 300)
