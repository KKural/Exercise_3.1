context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # correct: 45% of the variance in y is explained by x
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ No. R² is not about prediction accuracy, but explained variance.
            "1" = "❌ Nee. R² geeft aan hoeveel *variantie* wordt verklaard, niet hoeveel voorspellingen correct zijn.",
            
            # ❌ Incorrect. R² is about association, not causality.
            "2" = "❌ Fout. R² betekent niet dat werkloosheid 45% van de misdrijven *veroorzaakt*.",
            
            # ❌ Not correct. Perfect correlation would mean R² = 1, not 0,45.
            "3" = "❌ Niet juist. Een perfecte correlatie zou een R² van 1 opleveren, niet 0,45.",
            
            # ✅ Correct! 45% of the variance in violent crime is explained by differences in unemployment between districts.
            "4" = "✅ Correct! Een R² van 0,45 betekent dat 45% van de variantie in gewelddadige misdrijven tussen wijken verklaard wordt door verschillen in werkloosheid."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # ❌ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})
