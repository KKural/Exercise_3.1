context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2.89,  # the correct t-statistic
        comparator = function(generated, expected, ...) {
          # Get the exact student answer for feedback
          student_answer <- tryCatch({
            as.numeric(generated)
          }, error = function(e) {
            return(NA)
          })
          
          # Data
          group1 <- c(15, 18, 22, 19, 21, 17)  # Before intervention
          group2 <- c(12, 10, 14, 11, 9, 13)   # After intervention
          
          n1 <- length(group1)
          n2 <- length(group2)
          
          # Calculations
          mean1 <- mean(group1)  # 18.67
          mean2 <- mean(group2)  # 11.5
          
          # Sample standard deviations (n-1)
          sd1 <- sd(group1)      # 2.73
          sd2 <- sd(group2)      # 1.87
          
          # Pooled standard deviation
          pooled_var <- ((n1-1)*sd1^2 + (n2-1)*sd2^2) / (n1 + n2 - 2)
          pooled_sd <- sqrt(pooled_var)  # 2.35
          
          # Standard error
          se <- pooled_sd * sqrt(1/n1 + 1/n2)  # 1.36
          
          # t-statistic
          t_stat <- (mean1 - mean2) / se  # 2.89
          t_stat_rounded <- round(t_stat, 2)
          
          # Degrees of freedom
          df <- n1 + n2 - 2  # 10
          
          # Determine if answer is correct
          is_correct <- !is.na(student_answer) && abs(student_answer - t_stat_rounded) < 0.05
          
          if (is_correct) {
            # Detailed feedback for correct answer
            get_reporter()$add_message(
              paste0("✅ Juist! De t-statistiek is inderdaad ", t_stat_rounded, ".\n\n",
                    "**Stapsgewijze berekening:**\n\n",
                    "**Stap 1: Gemiddelden berekenen**\n",
                    "x̄₁ (voor interventie) = (15+18+22+19+21+17)/6 = ", round(mean1, 2), "\n",
                    "x̄₂ (na interventie) = (12+10+14+11+9+13)/6 = ", round(mean2, 2), "\n\n",
                    "**Stap 2: Standaarddeviaties berekenen (steekproef)**\n",
                    "s₁ = ", round(sd1, 2), "\n",
                    "s₂ = ", round(sd2, 2), "\n\n",
                    "**Stap 3: Gepoolde standaarddeviatie**\n",
                    "s²pooled = [(n₁-1)s₁² + (n₂-1)s₂²] / (n₁+n₂-2)\n",
                    "s²pooled = [(6-1)×", round(sd1^2, 2), " + (6-1)×", round(sd2^2, 2), "] / 10\n",
                    "s²pooled = [", round((n1-1)*sd1^2, 2), " + ", round((n2-1)*sd2^2, 2), "] / 10 = ", round(pooled_var, 2), "\n",
                    "spooled = √", round(pooled_var, 2), " = ", round(pooled_sd, 2), "\n\n",
                    "**Stap 4: Standaardfout**\n",
                    "SE = spooled × √(1/n₁ + 1/n₂) = ", round(pooled_sd, 2), " × √(1/6 + 1/6) = ", round(pooled_sd, 2), " × ", round(sqrt(1/6 + 1/6), 3), " = ", round(se, 2), "\n\n",
                    "**Stap 5: t-statistiek**\n",
                    "t = (x̄₁ - x̄₂) / SE = (", round(mean1, 2), " - ", round(mean2, 2), ") / ", round(se, 2), " = ", round(mean1-mean2, 2), " / ", round(se, 2), " = ", t_stat_rounded, "\n\n",
                    "**Interpretatie:** Met df = ", df, " en t = ", t_stat_rounded, ", is dit een significant resultaat (kritieke waarde ≈ 1.81 bij α = 0.05, eenzijdig). De interventie lijkt effectief te zijn!"), 
              type = "markdown"
            )
          } else {
            # Feedback for incorrect answers
            if (is.na(student_answer)) {
              get_reporter()$add_message(
                "❌ Fout. Je hebt geen geldige numerieke waarde ingevoerd. Voer de t-statistiek in als een getal, bijvoorbeeld: 2.89", 
                type = "markdown")
            } else if (abs(student_answer - (mean1 - mean2)) < 0.1) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je hebt ", student_answer, " geantwoord, maar dit is alleen het **verschil tussen de gemiddelden**, niet de t-statistiek.\n\n",
                       "Je moet het verschil nog delen door de standaardfout:\n",
                       "t = (x̄₁ - x̄₂) / SE = ", round(mean1-mean2, 2), " / ", round(se, 2), " = ", t_stat_rounded), 
                type = "markdown")
            } else if (abs(student_answer - round(pooled_sd, 2)) < 0.1) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je hebt ", student_answer, " geantwoord, maar dit lijkt de **gepoolde standaarddeviatie** te zijn, niet de t-statistiek.\n\n",
                       "De t-statistiek is: t = (x̄₁ - x̄₂) / SE = ", t_stat_rounded), 
                type = "markdown")
            } else if (student_answer < 0 && t_stat_rounded > 0) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je antwoord ", student_answer, " is negatief, maar de t-statistiek moet **positief** zijn.\n\n",
                       "Voor interventie: x̄₁ = ", round(mean1, 2), " > Na interventie: x̄₂ = ", round(mean2, 2), "\n\n",
                       "Dus t = (", round(mean1, 2), " - ", round(mean2, 2), ") / SE = positief\n\n",
                       "Het juiste antwoord is ", t_stat_rounded), 
                type = "markdown")
            } else {
              get_reporter()$add_message(
                paste0("❌ Fout. Je antwoord ", student_answer, " is niet correct. De juiste t-statistiek is ", t_stat_rounded, ".\n\n",
                       "**Controleer je berekening:**\n\n",
                       "1. Gemiddelden: x̄₁ = ", round(mean1, 2), ", x̄₂ = ", round(mean2, 2), "\n",
                       "2. Standaarddeviaties: s₁ = ", round(sd1, 2), ", s₂ = ", round(sd2, 2), "\n",
                       "3. Gepoolde SD: spooled = ", round(pooled_sd, 2), "\n",
                       "4. Standaardfout: SE = ", round(se, 2), "\n",
                       "5. t-statistiek: t = ", round(mean1-mean2, 2), " / ", round(se, 2), " = ", t_stat_rounded, "\n\n",
                       "**Tip:** Controleer of je de steekproef-standaarddeviatie gebruikt (n-1) en niet de populatie-versie (n)."), 
                type = "markdown")
            }
          }
          
          return(is_correct)
        }
      )
    }
  )
})
