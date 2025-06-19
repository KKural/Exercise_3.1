context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # the correct choice: "Soort misdrijf" is a nominal variable
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # âœ… Correct! "Type of crime" is nominal: distinct categories with no inherent order.
            "1" = "Juist! â€œSoort misdrijfâ€ is een *nominaal* meetniveau: het gaat enkel om verschillende categorieÃ«n zonder ordening.",
            
            # âŒ No, ordinal would mean there's a logical order, which doesn't apply to crime types.
            "2" = "Fout, ordinaal zou betekenen dat er een logische volgorde is, maar dat geldt niet voor soorten misdrijven.",
            
            # âŒ InJuist. Interval variables have meaningful numeric differences; this is a categorical variable.
            "3" = "Fout. Intervalvariabelen hebben numerieke waarden met betekenisvolle verschillen, maar â€œsoort misdrijfâ€ is categorisch.",
            
            # âŒ Not Juist. Ratio requires an absolute zero and quantitative interpretation, which does not apply to crime categories.
            "4" = "Fout. Ratio vereist een absoluut nulpunt en kwantitatieve interpretatie, wat niet van toepassing is op misdrijfcategorieÃ«n."
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

