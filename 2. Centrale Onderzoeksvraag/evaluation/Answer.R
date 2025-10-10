context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # Correct answer: To determine focus and direction
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. De centrale vraag helpt inderdaad om het onderwerp te beperken, maar haar belangrijkste doel is het geven van richting en betekenis aan het hele onderzoek. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)",
            
            "2" = "❌ Fout. De centrale onderzoeksvraag vormt juist het kader waarbinnen subvraagstukken of hypothesen ontwikkeld worden — ze vervangt die niet. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)",
            
            "3" = "❌ Fout. De centrale onderzoeksvraag wordt vooraf opgesteld om het onderzoek te sturen, niet om de resultaten achteraf samen te vatten. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)",
            
            "4" = "✅ Juist! De centrale onderzoeksvraag bepaalt de hoofdfocus, verduidelijkt wat onderzocht wordt en zorgt dat het onderzoek een duidelijke richting en samenhang heeft. [Lees meer](https://handboeksgpl.sites.uu.nl/doing-research/central-question-and-sub-questions/?lang=en)"
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