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
            "1" = "✅ **Juist!** Deze waarde (r = 0,12) valt duidelijk in de categorie 'zwakke positieve correlatie' volgens standaard interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00); Positief (r > 0), Negatief (r < 0). Deze correlatie betekent dat er een kleine maar meetbare relatie bestaat tussen ouderlijk toezicht en jeugdcriminaliteit. De variabelen delen slechts een klein deel van hun variantie (R² = 0,12² = 0,014 = 1,4%), wat betekent dat 98,6% van de variantie in jeugdcriminaliteit niet verklaard wordt door ouderlijk toezicht alleen.",
            
            "2" = "❌ **Fout.** Deze waarde (r = 0,56) valt duidelijk in de categorie 'matige correlatie' (0,30-0,70), niet 'zwak' volgens de standaard interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00). Een correlatie van 0,56 zou een duidelijk sterkere relatie aangeven tussen ouderlijk toezicht en jeugdcriminaliteit, waarbij ongeveer 31% van de variantie gedeeld wordt (R² = 0,56² = 0,31).",
            
            "3" = "❌ **Fout.** Deze waarde heeft twee fundamentele problemen volgens de interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00); Positief (r > 0), Negatief (r < 0). (1) De richting is negatief, niet positief - een negatieve correlatie zou betekenen dat meer ouderlijk toezicht samengaat met minder jeugdcriminaliteit; (2) De absolute sterkte (|-0,72| = 0,72) valt in de categorie 'sterk' (>0,70), niet 'zwak'.",
            
            "4" = "❌ **Fout.** Dit is een extreem sterke positieve correlatie (r = 0,93), ver boven de sterke categorie volgens de interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00). Een correlatie van 0,93 zou betekenen dat ouderlijk toezicht en jeugdcriminaliteit een vrijwel perfecte positieve relatie hebben, wat het tegenovergestelde is van 'zwak'."
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