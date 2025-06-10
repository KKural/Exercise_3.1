context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # the correct choice: distribution of many sample means from repeated sampling
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ No. That’s just the distribution of crime values in the city, not of sample means.
            "1" = "❌ Nee. Dit is enkel de verdeling van misdaadcijfers in de stad, niet van steekproefgemiddelden.",
            
            # ❌ Not correct. The distribution of predicted values from a regression is a different concept. 
            "2" = "❌ Niet juist. De verdeling van voorspelde waarden uit een regressie is iets anders dan een steekproevenverdeling van gemiddelden."
            
            # ❌ Incorrect. This refers to a time series, not a sampling distribution.
            "3" = "❌ Fout. Dit beschrijft een tijdsverloop van populatiecijfers, geen steekproevenverdeling.",
            
            # ✅ Correct! A sampling distribution of the mean shows how sample means vary across many random samples.
            "4" = "✅ Correct! Een steekproevenverdeling toont hoe steekproefgemiddelden variëren bij herhaaldelijk bemonsteren van wijken."
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
