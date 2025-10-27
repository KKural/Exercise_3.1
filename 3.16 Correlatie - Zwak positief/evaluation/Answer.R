context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: r = 0,12
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ **Juist!** Interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00). Deze waarde (r = 0,12) valt duidelijk in de categorie 'zwakke positieve correlatie' volgens standaard interpretatierichtlijnen. Deze correlatie betekent dat er een kleine maar meetbare relatie bestaat tussen ouderlijk toezicht en jeugdcriminaliteit, waarbij slechts 1,4% van de variantie gedeeld wordt.",
            
            "2" = "❌ **Fout.** Deze waarde (r = 0,56) valt duidelijk in de categorie 'matige correlatie' (0,30-0,70), niet 'zwak'. Een correlatie van 0,56 zou een duidelijk sterkere relatie aangeven tussen ouderlijk toezicht en jeugdcriminaliteit, waarbij ongeveer 31% van de variantie gedeeld wordt.",
            
            "3" = "❌ **Fout.** Deze waarde heeft twee problemen: (1) De richting is negatief, niet positief; (2) De absolute sterkte (|-0,72| = 0,72) valt in de categorie 'sterk' (>0,70), niet 'zwak'. Een correlatie van -0,72 zou duiden op een sterke omgekeerde relatie.",
            
            "4" = "❌ **Fout.** Dit is een extreem sterke positieve correlatie (r = 0,93), ver boven de sterke categorie (>0,70), wat het tegenovergestelde is van 'zwak'. Een correlatie van 0,93 zou betekenen dat ouderlijk toezicht en jeugdcriminaliteit een vrijwel perfecte positieve relatie hebben."
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