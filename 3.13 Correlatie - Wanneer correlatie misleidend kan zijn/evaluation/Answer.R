context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Wanneer er uitbijters (outliers) in de data zitten
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ **Juist!** Uitbijters kunnen correlatiecoëfficiënten drastisch beïnvloeden en misleidende resultaten geven. Een enkele extreme waarde kan een zwakke correlatie sterk doen lijken, of omgekeerd een sterke relatie verzwakken. Bijvoorbeeld, als je de relatie onderzoekt tussen leeftijd en criminaliteit, kan één zeer jonge verdachte met extreem veel arrestaties de hele correlatie vertekenen. Het is daarom essentieel om altijd spreidingsdiagrammen te maken en uitbijters te identificeren voordat je correlaties interpreteert.",
            
            "2" = "❌ **Fout.** Hoewel kleine steekproeven minder betrouwbare correlaties opleveren, maken ze de correlatie niet per se misleidend - ze maken het alleen moeilijker om statistisch significante resultaten te krijgen. Een correlatie van r = 0,6 in een kleine steekproef (n=10) kan wel accuraat zijn, maar gewoon niet statistisch significant. Het probleem is gebrek aan power, niet misleiding.",
            
            "3" = "❌ **Fout.** Normale verdelingen maken correlatie juist betrouwbaarder, niet misleidender. Pearson-correlatie werkt het best wanneer beide variabelen normaal verdeeld zijn. Het probleem ontstaat juist wanneer variabelen NIET normaal verdeeld zijn - bijvoorbeeld bij sterk scheve verdelingen of ordinale data.",
            
            "4" = "❌ **Fout.** Statistische significantie betekent dat de waargenomen correlatie waarschijnlijk niet door toeval ontstaan is - dit maakt het juist betrouwbaarder, niet misleidender. Echter, statistische significantie zegt niets over praktische significantie. In zeer grote steekproeven kunnen zelfs zeer kleine correlaties (bijv. r = 0,05) statistisch significant zijn maar praktisch betekenisloos."
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