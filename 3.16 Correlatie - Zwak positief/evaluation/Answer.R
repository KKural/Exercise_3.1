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
            "1" = " Juist! Interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00); Positief (r > 0), Negatief (r < 0). Deze waarde (r = 0,12) valt duidelijk in de categorie 'zwakke positieve correlatie' volgens standaard interpretatierichtlijnen. Deze correlatie betekent dat er een kleine maar meetbare relatie bestaat tussen ouderlijk toezicht en jeugdcriminaliteit. De variabelen delen slechts een klein deel van hun variantie (R = 0,12 = 0,014 = 1,4%), wat betekent dat 98,6% van de variantie in jeugdcriminaliteit niet verklaard wordt door ouderlijk toezicht alleen. In de praktijk zou dit suggereren dat terwijl ouderlijk toezicht wel enige invloed heeft op jeugdcriminaliteit, vele andere factoren (zoals peers, schoolprestaties, buurtfactoren) veel belangrijkere rollen spelen. Bij zwakke correlaties is het essentieel om te overwegen of de relatie statistisch significant en praktisch betekenisvol is.",
            
            "2" = " Fout. Interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00); Positief (r > 0), Negatief (r < 0). Deze waarde (r = 0,56) valt duidelijk in de categorie 'matige correlatie' (0,30-0,70), niet 'zwak'. Een correlatie van 0,56 zou een duidelijk sterkere relatie aangeven tussen ouderlijk toezicht en jeugdcriminaliteit, waarbij ongeveer 31% van de variantie gedeeld wordt (R = 0,56 = 0,31). Dit zou suggereren dat ouderlijk toezicht een substantiële, niet slechts zwakke, voorspeller is van jeugdcriminaliteit. In onderzoekstermen zou je deze relatie beschrijven als 'matig sterk' in plaats van 'zwak', en het zou duiden op een veel meer betekenisvolle praktische relatie dan wat de onderzoeker beschreef.",
            
            "3" = " Fout. Interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00); Positief (r > 0), Negatief (r < 0). Deze waarde heeft twee fundamentele problemen: (1) De richting is negatief, niet positief - een negatieve correlatie zou betekenen dat meer ouderlijk toezicht samengaat met minder jeugdcriminaliteit, wat theoretisch logischer zou zijn; (2) De absolute sterkte (|-0,72| = 0,72) valt in de categorie 'sterk' (>0,70), niet 'zwak'. Een correlatie van -0,72 zou duiden op een sterke omgekeerde relatie waarbij ouderlijk toezicht een krachtige beschermende factor is tegen jeugdcriminaliteit. Dit zou ongeveer 52% gedeelde variantie betekenen (R = 0,72), wat veel sterker is dan de beschreven 'zwakke' relatie.",
            
            "4" = " Fout. Interpretatierichtlijnen: Zwak (|r| = 0,10-0,30), Matig (|r| = 0,30-0,70), Sterk (|r| = 0,70-1,00); Positief (r > 0), Negatief (r < 0). Dit is een extreem sterke positieve correlatie (r = 0,93), ver boven de sterke categorie (>0,70), wat het tegenovergestelde is van 'zwak'. Een correlatie van 0,93 zou betekenen dat ouderlijk toezicht en jeugdcriminaliteit een vrijwel perfecte positieve relatie hebben, waarbij ongeveer 86% van de variantie gedeeld wordt (R = 0,93 = 0,86). In de praktijk zou dit een bijna deterministische relatie betekenen waarbij ouderlijk toezicht de criminaliteit van jongeren vrijwel perfect voorspelt. Zulke extreme correlaties zijn zeer zeldzaam in sociaal wetenschappelijk onderzoek, en zeker niet wat bedoeld wordt met 'zwak positief'."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% " Geef een getal tussen 1 en 4 in."
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})
