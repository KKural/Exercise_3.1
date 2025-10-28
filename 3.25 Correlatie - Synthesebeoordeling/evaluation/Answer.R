context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Wijken met een hoger werkloosheidspercentage zullen hogere diefstalcijfers per 1000 inwoners hebben
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. **Te vaag en ontoetsbaar.** Deze hypothese mist: (1) Specificatie van variabelen - hoe meet je werkloosheid en criminaliteit? (2) Richting - positief of negatief verband? (3) Analyse-eenheid - individueel, wijk, of stadniveau? (4) Verwachte sterkte. Zonder deze details kan de hypothese niet betekenisvol getest worden.",
            
            "2" = "✅ Juist! **Goed geformuleerde hypothese.** Bevat de essentiële elementen: (1) **Variabelen:** Duidelijk gedefinieerd (werkloosheidspercentage, diefstalcijfers per 1000 inwoners) (2) **Richting:** Positieve relatie voorspeld (hoger werkloosheid → meer diefstal) (3) **Analyse-eenheid:** Wijkniveau (4) **Testbaarheid:** Kan getest worden met correlatie-analyse. Dit is hoe echte onderzoekshypotheses worden geschreven - ze voorspellen relaties tussen variabelen, niet specifieke correlatiecoëfficiënten.",
            
            "3" = "❌ Fout. **Verkeerde analyse-eenheid en te simplistisch.** Deze stelling gaat over individueel gedrag (werkloze mensen), terwijl de vraag wijk-niveau analyse vereist. Ook suggereert het causaliteit in plaats van correlatie, en mist het specificatie van hoe variabelen gemeten worden.",
            
            "4" = "❌ Fout. **Te extreem en wetenschappelijk onhoudbaar.** Deze absolute claim (alle diefstal) is: (1) Onrealistisch - diefstal heeft meerdere oorzaken (2) Ontoetsbaar - zou worden weerlegd door één tegenvoorbeeld (3) Causaal in plaats van correlationeel (4) Mist operationalisatie van variabelen."
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