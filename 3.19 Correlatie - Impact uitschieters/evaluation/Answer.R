context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Hoog-laag (rechts onder)
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Hoog-hoog uitschieters liggen in lijn met de positieve trend en zullen de correlatie minimaal beïnvloeden of zelfs versterken. Deze uitschieters ondersteunen het patroon dat hoge X-waarden samengaan met hoge Y-waarden.",
            
            "2" = "❌ **Fout.** Laag-laag uitschieters liggen ook in lijn met de positieve trend en zullen de correlatie minimaal beïnvloeden. Deze uitschieters ondersteunen het patroon dat lage X-waarden samengaan met lage Y-waarden.",
            
            "3" = "✅ **Juist!** Hoog-laag uitschieters (rechts onder) gaan direct tegen de positieve trend in. Terwijl de algemene trend suggereert dat hoge X-waarden samengaan met hoge Y-waarden, toont deze uitschieter een hoge X-waarde gekoppeld aan een lage Y-waarde. Dit creëert de grootste disruptie van het lineaire patroon en vermindert de correlatiecoëfficiënt het meest.",
            
            "4" = "❌ **Fout.** Laag-hoog uitschieters gaan wel tegen de trend in, maar hebben doorgaans minder impact dan hoog-laag uitschieters omdat ze zich in een ander deel van de dataverdeling bevinden. Bovendien zijn hoog-laag uitschieters vaak extremer in hun afwijking van de trendlijn."
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