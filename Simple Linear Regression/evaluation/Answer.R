context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # the correct choice: 15 per 1,000
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Correct! 5 + 2.5 × 4 = 15. That’s the predicted crime rate per 1,000.
            "1" = "✅ Correct! 5 + 2,5 × 4 = 15. Dat is het voorspelde misdaadcijfer per 1.000 inwoners.",
            
            # ❌ No. 10 would result from multiplying 2.5 × 4, but you forgot the intercept (5).
            "2" = "❌ Nee. Je hebt waarschijnlijk enkel 2,5 × 4 = 10 gedaan, maar je vergat de constante term van 5.",
            
            # ❌ Not correct. 6 would mean a much lower slope or no intercept — not what the model says.
            "3" = "❌ Niet juist. Een uitkomst van 6 klopt niet met het model: je zou dan een veel lagere helling of geen intercept nodig hebben.",
            
            # ❌ Incorrect. 7 suggests either a wrong slope or missed multiplication. Check the formula.
            "4" = "❌ Fout. 7 is geen juiste uitkomst volgens het model. Herbekijk de berekening: 5 + 2,5 × 4."
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
