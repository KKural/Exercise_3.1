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
            # ✅ Correct! Detailed calculation steps showing how to arrive at 15
            "1" = "✅ Juist! Je hebt het voorspelde misdaadcijfer correct berekend:
                   
                   misdaadcijfer = 5 + 2,5 × (werkloosheid)
                   misdaadcijfer = 5 + 2,5 × 4
                   misdaadcijfer = 5 + 10
                   misdaadcijfer = 15 per 1.000 inwoners",
            
            # ❌ Incorrect. Shows what calculation error led to 10
            "2" = "❌ Fout. Je berekening is onvolledig:
                   
                   Je berekende waarschijnlijk: 2,5 × 4 = 10
                   
                   Maar je moet de constante term (intercept) van 5 toevoegen:
                   misdaadcijfer = 5 + 2,5 × 4 = 5 + 10 = 15 per 1.000 inwoners",
            
            # ❌ Incorrect. Shows why 6 doesn't make mathematical sense
            "3" = "❌ Fout. Je uitkomst van 6 klopt niet met het gegeven model:
                   
                   misdaadcijfer = 5 + 2,5 × 4
                   
                   Om 6 te krijgen zou je een andere formule moeten gebruiken, bijvoorbeeld:
                   misdaadcijfer = 5 + 0,25 × 4 = 6
                   OF
                   misdaadcijfer = 2 + 1 × 4 = 6
                   
                   Het juiste antwoord is: 5 + 2,5 × 4 = 15 per 1.000 inwoners",
            
            # ❌ Incorrect. Shows calculation errors that might lead to 7
            "4" = "❌ Fout. Je berekening bevat een rekenfout:
                   
                   Het juiste model is: misdaadcijfer = 5 + 2,5 × 4
                   
                   Mogelijke fouten die tot 7 leiden:
                   • 5 + (2,5 ÷ 4) = 5 + 0,625 ≈ 5,6 (afgerond naar 7)
                   • 5 + 2 = 7 (verkeerde coëfficiënt gebruikt)
                   
                   De juiste berekening is: 5 + 2,5 × 4 = 5 + 10 = 15 per 1.000 inwoners"
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