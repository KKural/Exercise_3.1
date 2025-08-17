context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        -0.983,  # the correct correlation coefficient
        comparator = function(generated, expected, ...) {
          # Get the exact student answer for feedback
          student_answer <- tryCatch({
            as.numeric(generated)
          }, error = function(e) {
            return(NA)
          })
          
          # Data
          x <- c(2, 4, 6, 8, 10, 12)  # Police patrols
          y <- c(8, 6, 4, 2, 1, 0)    # Thefts
          n <- length(x)
          
          # Calculations
          x_mean <- mean(x)  # 7
          y_mean <- mean(y)  # 3.5
          
          x_dev <- x - x_mean
          y_dev <- y - y_mean
          
          xy_products <- x_dev * y_dev
          x_squared <- x_dev^2
          y_squared <- y_dev^2
          
          sum_xy <- sum(xy_products)     # -70
          sum_x_squared <- sum(x_squared) # 70
          sum_y_squared <- sum(y_squared) # 22.5
          
          correlation <- sum_xy / sqrt(sum_x_squared * sum_y_squared)
          correlation_rounded <- round(correlation, 3)  # -0.983
          
          # Determine if answer is correct
          is_correct <- !is.na(student_answer) && abs(student_answer - correlation_rounded) < 0.01
          
          if (is_correct) {
            # Detailed feedback for correct answer
            get_reporter()$add_message(
              paste0("✅ Juist! De correlatiecoëfficiënt is inderdaad ", correlation_rounded, ".\n\n",
                    "**Stapsgewijze berekening:**\n\n",
                    "**Stap 1: Gemiddelden berekenen**\n",
                    "x̄ = (2+4+6+8+10+12)/6 = ", x_mean, "\n",
                    "ȳ = (8+6+4+2+1+0)/6 = ", y_mean, "\n\n",
                    "**Stap 2: Afwijkingen van gemiddelden**\n",
                    "| x | y | (x-x̄) | (y-ȳ) |\n",
                    "|---|---|-------|-------|\n",
                    paste(sprintf("| %d | %d | %g | %g |", x, y, x_dev, y_dev), collapse = "\n"), "\n\n",
                    "**Stap 3: Producten en kwadraten**\n",
                    "| (x-x̄)(y-ȳ) | (x-x̄)² | (y-ȳ)² |\n",
                    "|-------------|---------|--------|\n",
                    paste(sprintf("| %g | %g | %g |", xy_products, x_squared, y_squared), collapse = "\n"), "\n\n",
                    "**Stap 4: Sommen**\n",
                    "Σ(x-x̄)(y-ȳ) = ", sum_xy, "\n",
                    "Σ(x-x̄)² = ", sum_x_squared, "\n",
                    "Σ(y-ȳ)² = ", sum_y_squared, "\n\n",
                    "**Stap 5: Correlatie berekenen**\n",
                    "r = ", sum_xy, " / √(", sum_x_squared, " × ", sum_y_squared, ") = ", sum_xy, " / √", sum_x_squared * sum_y_squared, " = ", sum_xy, " / ", round(sqrt(sum_x_squared * sum_y_squared), 3), " = ", correlation_rounded, "\n\n",
                    "**Interpretatie:** Een correlatie van ", correlation_rounded, " duidt op een zeer sterke negatieve relatie tussen politiepatrouilles en diefstallen."), 
              type = "markdown"
            )
          } else {
            # Feedback for incorrect answers
            if (is.na(student_answer)) {
              get_reporter()$add_message(
                "❌ Fout. Je hebt geen geldige numerieke waarde ingevoerd. Voer de correlatiecoëfficiënt in als een getal, bijvoorbeeld: -0.983", 
                type = "markdown")
            } else if (abs(student_answer - abs(correlation_rounded)) < 0.01) {
              get_reporter()$add_message(
                paste0("❌ Bijna goed! Je hebt ", student_answer, " geantwoord, maar dit is de **absolute waarde** van de correlatie.\n\n",
                       "Omdat meer patrouilles leiden tot minder diefstallen, is de correlatie **negatief**: ", correlation_rounded, "\n\n",
                       "**Let op het teken:** Een negatieve relatie geeft een negatieve correlatie."), 
                type = "markdown")
            } else if (abs(student_answer - sum_xy) < 0.5) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je hebt ", student_answer, " geantwoord, maar dit lijkt de **som van de producten** te zijn, niet de correlatie.\n\n",
                       "Je moet nog delen door de wortel van het product van de kwadratensom:\n",
                       "r = ", sum_xy, " / √(", sum_x_squared, " × ", sum_y_squared, ") = ", correlation_rounded), 
                type = "markdown")
            } else if (student_answer > 0 && correlation_rounded < 0) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je antwoord ", student_answer, " is positief, maar de correlatie moet **negatief** zijn.\n\n",
                       "Meer patrouilles → minder diefstallen = negatieve correlatie\n\n",
                       "Controleer de tekens in je berekening. Het juiste antwoord is ", correlation_rounded), 
                type = "markdown")
            } else {
              get_reporter()$add_message(
                paste0("❌ Fout. Je antwoord ", student_answer, " is niet correct. De juiste correlatiecoëfficiënt is ", correlation_rounded, ".\n\n",
                       "**Controleer je berekening:**\n\n",
                       "1. Gemiddelden: x̄ = ", x_mean, ", ȳ = ", y_mean, "\n",
                       "2. Som producten: Σ(x-x̄)(y-ȳ) = ", sum_xy, "\n",
                       "3. Som kwadraten: Σ(x-x̄)² = ", sum_x_squared, ", Σ(y-ȳ)² = ", sum_y_squared, "\n",
                       "4. Correlatie: r = ", sum_xy, " / √(", sum_x_squared * sum_y_squared, ") = ", correlation_rounded, "\n\n",
                       "**Tip:** Gebruik een rekenmachine en let goed op de tekens bij de berekeningen."), 
                type = "markdown")
            }
          }
          
          return(is_correct)
        }
      )
    }
  )
})
