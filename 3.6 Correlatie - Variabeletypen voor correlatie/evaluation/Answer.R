context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Beide variabelen moeten continu zijn (interval- of rationiveau)
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Er bestaan verschillende correlatiematen voor verschillende meetniveaus.. Pearson-correlatie is specifiek voor de samenhang tussen continue variabelen (metrisch). Andere metingen zijn: Spearman's rho voor gerangschikte gegevens (ordinaal), phi-coëfficiënt voor twee binaire variabelen (nominaal), Cramér's V voor twee categorische variabelen. Het gebruik van een verkeerde maat (dit wil zeggen: niet geschikt voor een gegeven meetniveau) kan leiden tot nietszeggende resultaten of verkeerde interpretaties van relaties in onderzoek.",
            
            "2" = "❌ Fout. Er bestaan verschillende correlatiematen voor verschillende meetniveaus. Pearson-correlatie is specifiek voor de samenhang tussen continue variabelen (metrisch). Andere metingen zijn: Spearman's rho voor gerangschikte gegevens (ordinaal), phi-coëfficiënt voor twee binaire variabelen (nominaal), Cramér's V voor twee categorische variabelen. Het gebruik van een verkeerde maat (dit wil zeggen: niet geschikt voor een gegeven meetniveau) kan leiden tot nietszeggende resultaten of verkeerde interpretaties van relaties in onderzoek. De relatie tussen een categorische en een continue variabele kan onderzocht worden aan de hand van een variantieanalyse (wordt later behandeld).",
            
            "3" = "✅ Juist! Pearson-correlatie vereist dat beide variabelen worden gemeten op interval- of rationiveau - numerieke variabelen waarbij de afstanden tussen waarden zinvol en consistent zijn. In de criminologie zijn voorbeelden: misdaadcijfers (ratio), strafduur in maanden (ratio), leeftijd bij eerste arrestatie (ratio), aantal eerdere veroordelingen (ratio) en schalen die de houding ten opzichte van de politie meten (interval). Deze variabelen maken zinvolle wiskundige bewerkingen mogelijk die nodig zijn voor het berekenen van gemiddelden, standaarddeviaties en covarianties die de basis vormen van de Pearson-correlatie. )",
            
            "4" = "❌ Fout.  Er bestaan verschillende correlatiematen voor verschillende meetniveaus. Pearson-correlatie is specifiek voor de samenhang tussen continue variabelen (metrisch). Andere metingen zijn: Spearman's rho voor gerangschikte gegevens (ordinaal), phi-coëfficiënt voor twee binaire variabelen (nominaal), Cramér's V voor twee categorische variabelen. Het gebruik van een verkeerde maat (dit wil zeggen: niet geschikt voor een gegeven meetniveau) kan leiden tot nietszeggende resultaten of verkeerde interpretaties van relaties in onderzoek."
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