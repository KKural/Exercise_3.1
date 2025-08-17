context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        8.54,  # the correct standard deviation
        comparator = function(generated, expected, ...) {
          # Get the exact student answer for feedback
          student_answer <- tryCatch({
            as.numeric(generated)
          }, error = function(e) {
            return(NA)
          })
          
          # Data and calculations
          data <- c(12, 15, 18, 22, 25, 28, 32, 35)
          n <- length(data)
          mean_val <- mean(data)  # 23.375
          deviations <- data - mean_val
          squared_deviations <- deviations^2
          variance <- sum(squared_deviations) / n  # Population variance
          std_dev <- sqrt(variance)  # 8.540126
          std_dev_rounded <- round(std_dev, 2)  # 8.54
          
          # Determine if answer is correct
          is_correct <- !is.na(student_answer) && abs(student_answer - std_dev_rounded) < 0.01
          
          if (is_correct) {
            # Detailed feedback for correct answer
            get_reporter()$add_message(
              paste0("✅ Juist! De standaarddeviatie is inderdaad ", std_dev_rounded, ".\n\n",
                    "**Stapsgewijze berekening:**\n\n",
                    "**Stap 1: Gemiddelde berekenen**\n",
                    "μ = (12 + 15 + 18 + 22 + 25 + 28 + 32 + 35) / 8 = ", round(mean_val, 3), "\n\n",
                    "**Stap 2: Afwijkingen van het gemiddelde**\n",
                    paste(data, "-", round(mean_val, 3), "=", round(deviations, 3), collapse = "\n"), "\n\n",
                    "**Stap 3: Gekwadrateerde afwijkingen**\n",
                    paste(round(deviations, 3), "² =", round(squared_deviations, 3), collapse = "\n"), "\n\n",
                    "**Stap 4: Variantie berekenen**\n",
                    "σ² = Σ(x - μ)² / n = ", round(sum(squared_deviations), 3), " / 8 = ", round(variance, 3), "\n\n",
                    "**Stap 5: Standaarddeviatie**\n",
                    "σ = √(σ²) = √", round(variance, 3), " = ", std_dev_rounded, "\n\n",
                    "**Interpretatie:** Een standaarddeviatie van ", std_dev_rounded, " betekent dat de meeste geweldsmisdrijven binnen ongeveer ", std_dev_rounded, " incidenten van het gemiddelde (", round(mean_val, 1), ") liggen."), 
              type = "markdown"
            )
          } else {
            # Feedback for incorrect answers
            if (is.na(student_answer)) {
              get_reporter()$add_message(
                "❌ Fout. Je hebt geen geldige numerieke waarde ingevoerd. Voer de standaarddeviatie in als een getal, bijvoorbeeld: 8.54", 
                type = "markdown")
            } else if (abs(student_answer - round(sqrt(var(data)), 2)) < 0.01) {
              get_reporter()$add_message(
                paste0("❌ Bijna goed! Je hebt ", student_answer, " geantwoord, maar dit lijkt de steekproef-standaarddeviatie te zijn (n-1 in de noemer).\n\n",
                       "Voor deze opgave gebruiken we de **populatie-standaarddeviatie** (n in de noemer): ", std_dev_rounded, "\n\n",
                       "**Verschil:**\n",
                       "- Steekproef-formule: delen door (n-1) = ", round(sqrt(var(data)), 2), "\n",
                       "- Populatie-formule: delen door n = ", std_dev_rounded), 
                type = "markdown")
            } else if (abs(student_answer - round(variance, 2)) < 0.01) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je hebt ", student_answer, " geantwoord, maar dit is de **variantie** (σ²), niet de standaarddeviatie.\n\n",
                       "De standaarddeviatie is de **wortel** van de variantie:\n",
                       "σ = √(σ²) = √", round(variance, 2), " = ", std_dev_rounded), 
                type = "markdown")
            } else if (abs(student_answer - round(mean_val, 2)) < 0.01) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je hebt ", student_answer, " geantwoord, maar dit is het **gemiddelde**, niet de standaarddeviatie.\n\n",
                       "De standaarddeviatie meet de spreiding rond het gemiddelde en is ", std_dev_rounded), 
                type = "markdown")
            } else {
              get_reporter()$add_message(
                paste0("❌ Fout. Je antwoord ", student_answer, " is niet correct. De juiste standaarddeviatie is ", std_dev_rounded, ".\n\n",
                       "**Controleer je berekening:**\n\n",
                       "1. Gemiddelde: (12+15+18+22+25+28+32+35)/8 = ", round(mean_val, 3), "\n",
                       "2. Variantie: Σ(x-μ)²/n = ", round(variance, 3), "\n",
                       "3. Standaarddeviatie: √(variantie) = ", std_dev_rounded, "\n\n",
                       "**Tip:** Gebruik een rekenmachine voor nauwkeurige berekeningen en rond pas het eindresultaat af."), 
                type = "markdown")
            }
          }
          
          return(is_correct)
        }
      )
    }
  )
})
