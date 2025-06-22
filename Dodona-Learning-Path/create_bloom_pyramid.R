```
library(ggplot2)
library(dplyr)
library(tidyr)
library(grid)
library(gridExtra)

# Create data for the pyramid
bloom_levels <- c("CREATE", "EVALUATE", "ANALYZE", "APPLY", "UNDERSTAND", "REMEMBER")
level_heights <- c(1, 1.2, 1.4, 1.6, 1.8, 2)
level_colors <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#F5B041") # Changed yellow to a more amber/golden color
level_descriptions <- c(
  "Produce new work",
  "Justify decisions",
  "Draw connections",
  "Use information",
  "Explain concepts",
  "Recall facts"
)

# Create the dataframe
df <- data.frame(
  level = factor(bloom_levels, levels = rev(bloom_levels)),
  height = level_heights,
  color = level_colors,
  description = level_descriptions
)

# Create the pyramid plot
p <- ggplot(df, aes(x = 1, y = height, fill = level)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y", start = 0, direction = -1) +
  xlim(c(0, 2)) +
  scale_fill_manual(values = rev(level_colors)) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.margin = margin(t = 40, r = 20, b = 40, l = 20),
    plot.background = element_rect(fill = "white", color = NA)
  ) +
  # Add a better centering adjustment
  theme(plot.title.position = "plot")

# Add labels
for (i in 1:nrow(df)) {
  angle <- (cumsum(df$height)[i] - df$height[i]/2) * 180 / sum(df$height)
  label_x <- 1.8 * cos(angle * pi / 180)
  label_y <- 1.8 * sin(angle * pi / 180)
  
  # Main label (level name)
  p <- p + annotate("text", 
                   x = 0.6 * cos(angle * pi / 180), 
                   y = 0.6 * sin(angle * pi / 180), 
                   label = as.character(df$level[i]), 
                   fontface = "bold", 
                   size = 5,
                   color = "white")
  
  # Description - better positioned labels
  p <- p + annotate("text", 
                   x = label_x, 
                   y = label_y, 
                   label = df$description[i], 
                   hjust = ifelse(angle > 90, 0, 1),
                   size = 4)
}

# Add title
p <- p + annotate("text", x = 0, y = 2.2, label = "BLOOM'S TAXONOMY", 
                 fontface = "bold", size = 6, hjust = 0.5)

# Add subtitle
p <- p + annotate("text", x = 0, y = 2.1, 
                 label = "Hierarchy of Cognitive Skills", 
                 fontface = "italic", size = 4, hjust = 0.5)

# Save the plot as both PNG and SVG
ggsave("bloom-pyramid.png", p, width = 8, height = 8, dpi = 300)
ggsave("bloom-pyramid.svg", p, width = 8, height = 8)
```
