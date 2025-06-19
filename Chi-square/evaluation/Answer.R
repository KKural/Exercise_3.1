context({
  testcase(
    "",
    {
      testEqual(
        "",
        function(env) {
          # Get student's answer as a numeric value
          answer <- as.numeric(env$evaluationResult)
          
          # Check if the answer is within acceptable range
          abs(answer - 11.89) < 0.1  # Allow slight rounding differences
        },
        TRUE,
        comparator = function(generated, expected, ...) {
          # Get the exact student answer for feedback
          student_answer <- as.numeric(get_reporter()$data$evaluationResult)
          
          # Calculate the correct chi-square value
          observed <- matrix(c(25, 18, 12, 15, 22, 28), nrow=3, byrow=TRUE)
          row_sums <- rowSums(observed)
          col_sums <- colSums(observed)
          total <- sum(observed)
          
          expected_values <- matrix(NA, nrow=3, ncol=2)
          chi_square_components <- matrix(NA, nrow=3, ncol=2)
          
          # Calculate expected values and chi-square components
          for(i in 1:3) {
            for(j in 1:2) {
              expected_values[i,j] <- row_sums[i] * col_sums[j] / total
              chi_square_components[i,j] <- ((observed[i,j] - expected_values[i,j])^2) / expected_values[i,j]
            }
          }
          
          chi_square_value <- sum(chi_square_components)
          chi_square_rounded <- round(chi_square_value, 2)
          
          # Determine if answer is correct
          is_correct <- abs(student_answer - chi_square_rounded) < 0.1
          
          if (is_correct) {
            # Detailed feedback for correct answer
            get_reporter()$add_message(
              paste0("✅ Juist! De chi-kwadraat waarde is inderdaad ", chi_square_rounded, ".\n\n",
                    "**Stapsgewijze berekening:**\n\n",
                    "1. **Verwachte waarden berekenen**:\n",
                    "   - E(Laag, Geweld) = (25+15) × (25+18+12) / 120 = ", round(expected_values[1,1], 2), "\n",
                    "   - E(Midden, Geweld) = (18+22) × (25+18+12) / 120 = ", round(expected_values[2,1], 2), "\n",
                    "   - E(Hoog, Geweld) = (12+28) × (25+18+12) / 120 = ", round(expected_values[3,1], 2), "\n",
                    "   - E(Laag, Diefstal) = (25+15) × (15+22+28) / 120 = ", round(expected_values[1,2], 2), "\n",
                    "   - E(Midden, Diefstal) = (18+22) × (15+22+28) / 120 = ", round(expected_values[2,2], 2), "\n",
                    "   - E(Hoog, Diefstal) = (12+28) × (15+22+28) / 120 = ", round(expected_values[3,2], 2), "\n\n",
                    "2. **Chi-kwadraat componenten berekenen**: (O-E)²/E\n",
                    "   - (25-", round(expected_values[1,1], 2), ")²/", round(expected_values[1,1], 2), " = ", round(chi_square_components[1,1], 2), "\n",
                    "   - (18-", round(expected_values[2,1], 2), ")²/", round(expected_values[2,1], 2), " = ", round(chi_square_components[2,1], 2), "\n",
                    "   - (12-", round(expected_values[3,1], 2), ")²/", round(expected_values[3,1], 2), " = ", round(chi_square_components[3,1], 2), "\n",
                    "   - (15-", round(expected_values[1,2], 2), ")²/", round(expected_values[1,2], 2), " = ", round(chi_square_components[1,2], 2), "\n",
                    "   - (22-", round(expected_values[2,2], 2), ")²/", round(expected_values[2,2], 2), " = ", round(chi_square_components[2,2], 2), "\n",
                    "   - (28-", round(expected_values[3,2], 2), ")²/", round(expected_values[3,2], 2), " = ", round(chi_square_components[3,2], 2), "\n\n",
                    "3. **Chi-kwadraat waarde berekenen**: Som van alle componenten = ", chi_square_rounded, "\n\n",
                    "4. **Vrijheidsgraden**: (rijen-1) × (kolommen-1) = 2 × 1 = 2\n\n",
                    "5. **Conclusie**: Bij α = 0.05 en df = 2 is de kritieke waarde 5.99. Omdat ", chi_square_rounded, " > 5.99, verwerpen we de nulhypothese dat er geen verband is tussen opleidingsniveau en type misdrijf.")
            )
          } else {
            # Feedback for incorrect answers
            if (is.na(student_answer)) {
              get_reporter()$add_message("❌ Fout. Je hebt geen numerieke waarde ingevoerd.")
            } else if (student_answer < 0) {
              get_reporter()$add_message("❌ Fout. De chi-kwadraat waarde kan niet negatief zijn.")
            } else if (abs(student_answer - 5.99) < 0.1) {
              get_reporter()$add_message("❌ Fout. Je lijkt de kritieke waarde van de chi-kwadraat verdeling (5.99 bij α = 0.05, df = 2) te hebben gegeven in plaats van de berekende toetsstatistiek.")
            } else {
              get_reporter()$add_message(
                paste0("❌ Fout. Je antwoord ", student_answer, " is niet correct. De juiste chi-kwadraat waarde is ", chi_square_rounded, ".\n\n",
                      "**Herinner je de formule voor chi-kwadraat:**\n",
                      "χ² = Σ [(O - E)² / E]\n\n",
                      "waar O = geobserveerde frequentie en E = verwachte frequentie.\n\n",
                      "**Tips voor de berekening:**\n",
                      "1. Bereken eerst de verwachte frequenties voor elke cel: E = (rijtotaal × kolomtotaal) / totaal\n",
                      "2. Bereken voor elke cel: (O - E)² / E\n",
                      "3. Tel alle waarden uit stap 2 bij elkaar op om χ² te krijgen")
              )
            }
          }
          
          return(generated)
        }
      )
    }
  )
})