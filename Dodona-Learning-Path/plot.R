library(ggplot2)
install.packages("dplyr")
library(dplyr)


# Define pyramid levels, colors, and labels
pyramid_data <- data.frame(
  level = factor(c("Create", "Evaluate", "Analyze", "Apply", "Understand", "Remember"),
                 levels = rev(c("Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create"))),
  number = 6:1,
  keywords = c(
    "Define, duplicate, list, memorize, repeat, state.",
    "Classify, describe, discuss, explain, identify.",
    "Execute, implement, solve, use, interpret.",
    "Differentiate, compare, test, experiment, question.",
    "Appraise, argue, critique, judge, support.",
    "Design, construct, develop, author, investigate."
  ),
  color = rev(c("purple", "blue", "green", "yellow", "orange", "red"))
)

# Build polygon coordinates for each level
create_layer <- function(n, total_layers = 6) {
  y_bottom <- n - 1
  y_top <- n
  width_bottom <- 6 + 1 - n
  width_top <- 6 + 1 - n - 0.5

  data.frame(
    x = c(-width_bottom, width_bottom, width_top, -width_top),
    y = c(y_bottom, y_bottom, y_top, y_top),
    group = n
  )
}

# Combine all pyramid layer polygons
polygon_data <- do.call(rbind, lapply(1:6, function(i) {
  layer <- create_layer(i)
  layer$level <- as.character(pyramid_data$level[i])
  layer$fill <- pyramid_data$color[i]
  layer$label <- paste0(pyramid_data$number[i], "\n", pyramid_data$level[i], "\n", pyramid_data$keywords[i])
  layer
}))

# Plot
ggplot() +
  geom_polygon(data = polygon_data, aes(x = x, y = y, group = group, fill = fill), color = "black") +
  geom_text(data = polygon_data %>%
              group_by(group) %>%
              summarize(x = 0, y = mean(y), label = first(label)),
            aes(x = x, y = y, label = label), size = 3.5, color = "white", lineheight = 1.1) +
  scale_fill_identity() +
  coord_fixed() +
  theme_void() +
  ggtitle("Bloom's Taxonomy Pyramid (Dodona Style)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))
