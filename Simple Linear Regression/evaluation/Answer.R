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
            # âœ… Correct! 5 + 2.5 Ã— 4 = 15. Thatâ€™s the predicted crime rate per 1,000.
            "1" = "✅ Juist! 5 + 2,5 Ã— 4 = 15. Dat is het voorspelde misdaadcijfer per 1.000 inwoners.",
            
            # âŒ No. 10 would result from multiplying 2.5 Ã— 4, but you forgot the intercept (5).
            "2" = "❌ Fout. Je hebt waarschijnlijk enkel 2,5 Ã— 4 = 10 gedaan, maar je vergat de constante term van 5.",
            
            # âŒ Not Juist. 6 would mean a much lower slope or no intercept â€” not what the model says.
            "3" = "❌ Fout. Een uitkomst van 6 klopt niet met het model: je zou dan een veel lagere helling of geen intercept nodig hebben.",
            
            # âŒ InJuist. 7 suggests either a wrong slope or missed multiplication. Check the formula.
            "4" = "❌ Fout.. 7 is geen juiste uitkomst volgens het model. Herbekijk de berekening: 5 + 2,5 Ã— 4."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # âŒ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})

