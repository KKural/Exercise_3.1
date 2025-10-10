context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Q20 - Sampling strategy evaluation
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Universiteitsstudenten zijn slechts een deel van alle jongeren.",
            
            "2" = "❌ Fout. 500 respondenten is een redelijke steekproefgrootte.",
            
            "3" = "✅ Juist! Deze steekproef mist jongeren die werken, werkloos zijn, of andere vormen van onderwijs volgen (hogeschool, secundair onderwijs). Universiteitsstudenten hebben vaak andere kenmerken qua sociaal-economische achtergrond.",
            
            "4" = "❌ Fout. Met juiste toestemming en anonimiteit kan drugsonderzoek wel ethisch uitgevoerd worden."
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