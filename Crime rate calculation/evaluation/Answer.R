context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # the correct choice: 4.0 per 1,000 residents
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Correct! (1,200 / 300,000) * 1,000 = 4.0 burglaries per 1,000 residents.
            "1" = "✅ Juist! (1.200 / 300.000) × 1.000 = 4,0 inbraken per 1.000 inwoners.",
            
            # ❌ Incorrect. You may have miscalculated the proportion—check your division.
            "2" = "❌ Fout. Je hebt waarschijnlijk een fout gemaakt bij het delen. Probeer het opnieuw met de juiste formule.",
            
            # ❌ No. That would be true if there were 1.050 burglaries, not 1.200.
            "3" = "❌ Fout. Dat zou kloppen als er 1.050 inbraken waren, maar er waren 1.200.",
            
            # ❌ Not correct. 5,0 would imply 1.500 burglaries for 300.000 people.
            "4" = "❌ Fout. Een cijfer van 5,0 zou betekenen dat er 1.500 inbraken waren, niet 1.200."
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
