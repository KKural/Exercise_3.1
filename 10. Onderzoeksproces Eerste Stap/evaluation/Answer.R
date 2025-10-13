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
            "1" = "❌ Fout. Universiteitsstudenten zijn slechts een deel van alle jongeren. Deze steekproef mist jongeren die werken, werkloos zijn, of andere vormen van onderwijs volgen. [Lees meer](https://www.qualtrics.com/en-gb/experience-management/research/sampling-methods/)",
            
            "2" = "❌ Fout. 500 respondenten is een redelijke steekproefgrootte voor dit type onderzoek. Het probleem ligt niet in het aantal, maar in wie er onderzocht wordt. [Lees meer](https://www.qualtrics.com/en-gb/experience-management/research/sampling-methods/)",
            
            "3" = "✅ Juist! De steekproef bevat enkel universiteitsstudenten en laat veel andere jongeren buiten beschouwing, zoals zij die in het secundair of hoger beroepsonderwijs zitten, werken of werkloos zijn. Daardoor is de steekproef niet volledig representatief voor alle jongeren. [Lees meer](https://www.qualtrics.com/en-gb/experience-management/research/sampling-methods/)",
            
            "4" = "❌ Fout. Met juiste toestemming en anonimiteit kan drugsonderzoek wel ethisch uitgevoerd worden. Het probleem ligt in de representativiteit van de steekproef, niet in de ethiek van het onderwerp. [Lees meer](https://www.qualtrics.com/en-gb/experience-management/research/sampling-methods/)"
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