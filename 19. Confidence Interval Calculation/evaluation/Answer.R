context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) env$evaluationResult,
        "25.12,30.88",  # the correct confidence interval
        comparator = function(generated, expected, ...) {
          # Parse the student answer
          student_answer <- tryCatch({
            parts <- unlist(strsplit(as.character(generated), ","))
            if(length(parts) != 2) return(NA)
            lower <- as.numeric(trim(parts[1]))
            upper <- as.numeric(trim(parts[2]))
            c(lower, upper)
          }, error = function(e) {
            return(NA)
          })
          
          # Data
          data <- c(24, 28, 32, 26, 30, 22, 35, 29, 27)
          n <- length(data)
          
          # Calculations
          sample_mean <- mean(data)  # 28
          sample_sd <- sd(data)      # 4.36
          se <- sample_sd / sqrt(n)  # 1.45
          
          # t-value for 95% CI with df = 8
          t_value <- 2.306
          
          # Margin of error
          me <- t_value * se  # 3.35
          
          # Confidence interval
          lower_bound <- sample_mean - me  # 24.65
          upper_bound <- sample_mean + me  # 31.35
          
          # Round to 2 decimal places
          lower_rounded <- round(lower_bound, 2)
          upper_rounded <- round(upper_bound, 2)
          
          # Determine if answer is correct
          is_correct <- !any(is.na(student_answer)) && 
                       length(student_answer) == 2 &&
                       abs(student_answer[1] - lower_rounded) < 0.05 && 
                       abs(student_answer[2] - upper_rounded) < 0.05
          
          if (is_correct) {
            # Detailed feedback for correct answer
            get_reporter()$add_message(
              paste0("✅ Juist! Het 95% betrouwbaarheidsinterval is inderdaad [", lower_rounded, ", ", upper_rounded, "].\n\n",
                    "**Stapsgewijze berekening:**\n\n",
                    "**Stap 1: Steekproefgemiddelde**\n",
                    "x̄ = (24+28+32+26+30+22+35+29+27)/9 = ", round(sample_mean, 2), "\n\n",
                    "**Stap 2: Steekproef-standaarddeviatie**\n",
                    "s = √[Σ(x-x̄)²/(n-1)] = ", round(sample_sd, 2), "\n\n",
                    "**Stap 3: Standaardfout**\n",
                    "SE = s/√n = ", round(sample_sd, 2), "/√9 = ", round(sample_sd, 2), "/3 = ", round(se, 2), "\n\n",
                    "**Stap 4: Kritieke t-waarde**\n",
                    "Voor 95% CI met df = n-1 = 8: t₀.₀₂₅,₈ = ", t_value, "\n\n",
                    "**Stap 5: Foutmarge**\n",
                    "ME = t × SE = ", t_value, " × ", round(se, 2), " = ", round(me, 2), "\n\n",
                    "**Stap 6: Betrouwbaarheidsinterval**\n",
                    "Ondergrens = x̄ - ME = ", round(sample_mean, 2), " - ", round(me, 2), " = ", lower_rounded, "\n",
                    "Bovengrens = x̄ + ME = ", round(sample_mean, 2), " + ", round(me, 2), " = ", upper_rounded, "\n\n",
                    "**Interpretatie:** We zijn 95% zeker dat het ware populatiegemiddelde aantal autodiefstallen per maand tussen ", lower_rounded, " en ", upper_rounded, " ligt."), 
              type = "markdown"
            )
          } else {
            # Feedback for incorrect answers
            if (any(is.na(student_answer))) {
              get_reporter()$add_message(
                "❌ Fout. Je hebt geen geldige invoer gegeven. Voer het interval in als: ondergrens,bovengrens (bijvoorbeeld: 25.67,31.23)", 
                type = "markdown")
            } else if (length(student_answer) != 2) {
              get_reporter()$add_message(
                "❌ Fout. Je moet twee waarden invoeren gescheiden door een komma: ondergrens,bovengrens", 
                type = "markdown")
            } else if (student_answer[1] > student_answer[2]) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je ondergrens (", student_answer[1], ") is groter dan je bovengrens (", student_answer[2], ").\n\n",
                       "Het juiste interval is [", lower_rounded, ", ", upper_rounded, "]"), 
                type = "markdown")
            } else if (abs(student_answer[1] - sample_mean) < 0.1 && abs(student_answer[2] - sample_mean) < 0.1) {
              get_reporter()$add_message(
                paste0("❌ Fout. Je hebt beide keren het gemiddelde (", round(sample_mean, 2), ") ingevoerd.\n\n",
                       "Het betrouwbaarheidsinterval moet zijn: [gemiddelde - foutmarge, gemiddelde + foutmarge]\n",
                       "Juiste interval: [", lower_rounded, ", ", upper_rounded, "]"), 
                type = "markdown")
            } else {
              # Check if they used wrong t-value
              t_1_96 <- 1.96  # z-value instead of t
              me_wrong <- t_1_96 * se
              lower_wrong <- round(sample_mean - me_wrong, 2)
              upper_wrong <- round(sample_mean + me_wrong, 2)
              
              if (abs(student_answer[1] - lower_wrong) < 0.1 && abs(student_answer[2] - upper_wrong) < 0.1) {
                get_reporter()$add_message(
                  paste0("❌ Bijna goed! Je hebt waarschijnlijk z = 1.96 gebruikt in plaats van t = 2.306.\n\n",
                         "Voor kleine steekproeven (n < 30) gebruik je de **t-verdeling**, niet de normale verdeling.\n\n",
                         "Met t₀.₀₂₅,₈ = 2.306 krijg je: [", lower_rounded, ", ", upper_rounded, "]"), 
                  type = "markdown")
              } else {
                get_reporter()$add_message(
                  paste0("❌ Fout. Je antwoord [", student_answer[1], ", ", student_answer[2], "] is niet correct.\n\n",
                         "Het juiste 95% betrouwbaarheidsinterval is [", lower_rounded, ", ", upper_rounded, "].\n\n",
                         "**Controleer je berekening:**\n\n",
                         "1. Gemiddelde: x̄ = ", round(sample_mean, 2), "\n",
                         "2. Standaarddeviatie: s = ", round(sample_sd, 2), "\n",
                         "3. Standaardfout: SE = ", round(se, 2), "\n",
                         "4. t-waarde: t₀.₀₂₅,₈ = ", t_value, "\n",
                         "5. Foutmarge: ME = ", round(me, 2), "\n",
                         "6. Interval: [", round(sample_mean, 2), " ± ", round(me, 2), "] = [", lower_rounded, ", ", upper_rounded, "]"), 
                  type = "markdown")
              }
            }
          }
          
          return(is_correct)
        }
      )
    }
  )
})
