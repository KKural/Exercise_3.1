context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Q8 from your rotation pattern
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Dit gaat over steekproefgrootte, niet over de logische redenering.",
            
            "2" = "❌ Fout. Het probleem ligt in de interpretatie, niet in de statistiek.",
            
            "3" = "✅ Juist! Er kunnen confounding variabelen zijn: rijkere wijken hebben misschien zowel meer straatverlichting ALS minder criminaliteit door andere factoren (meer politie, beter onderwijs, meer werkgelegenheid).",
            
            "4" = "❌ Fout. De tijdsperiode is niet het kernprobleem hier."
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