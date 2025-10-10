context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: To break down central question into manageable parts
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ Juist! Onderzoeksdeelvragen maken de vaak vage en brede centrale onderzoeksvraag toetsbaar door deze op te delen in subproblemen die gemakkelijker te behandelen zijn. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)",
            
            "2" = "❌ Fout. Het doel is niet om het onderzoek langer te maken, maar om het beter te organiseren. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)",
            
            "3" = "❌ Fout. Het doel van deelvragen is niet om meer variabelen toe te voegen, maar om de hoofdvraag systematisch te onderzoeken. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)",
            
            "4" = "❌ Fout. Deelvragen zijn een methodologisch hulpmiddel, niet bedoeld om het onderzoek aantrekkelijker te maken voor het publiek. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)"
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