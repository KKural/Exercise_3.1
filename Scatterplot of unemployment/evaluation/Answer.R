context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # correct: 33% of the variance in y is explained by x
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ No. R² is not about prediction accuracy.
            "1" = "❌ Fout. R² geeft aan hoeveel *variantie* wordt verklaard, niet hoeveel voorspellingen correct zijn.",
            
            # ❌ Incorrect. R² does not prove causality.
            "2" = "❌ Fout. R² betekent niet dat werkloosheid 33% van de misdrijven *veroorzaakt*.",
            
            # ❌ Not correct. Perfect correlation would mean R² = 1.
            "3" = "❌ Fout. Een perfecte correlatie zou een R² van 1 opleveren, niet 0,33.",
            
            # ✅ Correct! R² = 0,33 means 33% of the variance in violent crime is explained by unemployment differences.
            "4" = "✅ Juist! Een R² van 0,33 betekent dat 33% van de variantie in gewelddadige misdrijven tussen wijken verklaard wordt door verschillen in werkloosheid."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})