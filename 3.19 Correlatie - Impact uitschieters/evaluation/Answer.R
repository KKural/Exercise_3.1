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
            "1" = " ❌ Fout. Punten links-onder (lage X, lage Y) versterken juist positieve correlaties. **Impact van uitschieters:** Deze positie volgt de algemene trend, waardoor de correlatie sterker wordt. De formule voor Pearson's r behelst het vermenigvuldigen van afwijkingen van het gemiddelde voor zowel X als Y. Wanneer X onder zijn gemiddelde ligt EN Y onder zijn gemiddelde ligt, is het product positief, wat positief bijdraagt aan de correlatie. De visualisatie toont dit duidelijk — het toevoegen van een laag-laag uitschieter verhoogt r van 0,82 naar 0,94. **Praktische impact:** In criminologisch onderzoek zou dit bijvoorbeeld een wijk met zowel lage sociale cohesie als hoge criminaliteitscijfers vertegenwoordigen - dit versterkt het verband tussen beide variabelen. Deze gevallen bevestigen het verwachte patroon en maken de correlatie sterker, niet zwakker.",
            
            "2" = " ✅ Juist! Een punt in het rechts-onder kwadrant (hoge X, lage Y) vermindert een positieve correlatie maximaal. **Impact van uitschieters:** Deze positie contradiceert de algemene trend en verzwakt de correlatie dramatisch. Deze positie vertegenwoordigt een ernstige schending van het positieve trendpatroon, waarbij X ver boven zijn gemiddelde ligt terwijl Y ver onder zijn gemiddelde ligt. In de correlatieformule creëert dit een grote negatieve productterm die de positieve relatie tegengaat die in de rest van de gegevens wordt gezien. **Kwantitatieve impact:** Zoals getoond in de visualisatie, vermindert deze positie de correlatiecoëfficiënt dramatisch van r = 0,82 naar r = 0,28 - een verlies van ongeveer 65% van de correlatiestrekte! **Praktische betekenis:** In criminologisch onderzoek zou dit bijvoorbeeld een wijk met hoge sociale cohesie maar onverwacht hoge criminaliteit vertegenwoordigen - dit doorbreekt het verwachte verband en suggereert andere verklarende factoren.",
            
            "3" = " ❌ Fout. Een punt rechts-boven (hoge X, hoge Y) versterkt juist een positieve correlatie in plaats van deze te verminderen. **Impact van uitschieters:** Deze positie versterkt de algemene trend en maakt de correlatie sterker. Wanneer X en Y beide boven hun respectievelijke gemiddelden liggen, vermenigvuldigen hun afwijkingen zich tot een positieve bijdrage aan de correlatiecoëfficiënt. **Kwantitatieve impact:** De visualisatie bevestigt dit — het toevoegen van een hoog-hoog uitschieter verhoogt r van 0,82 naar 0,94, een versterking van ongeveer 15%. **Praktische betekenis:** In criminologisch onderzoek zou dit bijvoorbeeld een wijk met zeer hoge sociale cohesie en zeer lage criminaliteit vertegenwoordigen - dit versterkt het verwachte verband. Hoewel deze punten invloedrijk kunnen zijn en onderzoek verdienen (waarom presteren ze zo goed?), ondersteunen ze het correlatiepatroon in plaats van het te ondermijnen.",
            
            "4" = " ❌ Fout. Een punt dat precies op de regressielijn valt heeft bijna geen impact op de correlatiecoëfficiënt. **Impact van uitschieters:** Punten op de lijn hebben minimale tot geen invloed op de correlatiesterkte omdat ze perfect conform zijn aan de lineaire relatie. Deze positie vertegenwoordigt geen uitschieter - het is juist een punt dat het voorspelde patroon perfect volgt. **Kwantitatieve impact:** Dergelijke punten hebben nul of minimale afwijking van het voorspelde model, dus ze veranderen r nauwelijks. **Conceptuele verwarring:** Dit antwoord toont een misverstand over wat constitueert als een 'uitschieter'. Uitschieters zijn per definitie punten die substantial afwijken van het algemene patroon. **Praktische betekenis:** In onderzoek zijn dit de 'voorspelbare' gevallen die exact doen wat het model verwacht - ze bevestigen noch weerleggen de relatie."

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