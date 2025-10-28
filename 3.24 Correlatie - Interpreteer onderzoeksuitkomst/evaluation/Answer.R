context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Longitudinaal ontwerp dat social media gebruik meet
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Onvolledig. Dit ontwerp heeft verschillende methodologische zwakheden: (1) De steekproefgrootte (N=100) is relatief klein voor het detecteren van potentieel subtiele effecten in gedragsonderzoek; (2) Simpele zelf-gerapporteerde uren faalt om de complexe, multidimensionale aard van social media gebruik vast te leggen (verschillende platforms, actief vs. passief gebruik, inhoudstypen, etc.); (3) Geen controlevariabelen betekent dat elke waargenomen correlatie te wijten kan zijn aan talloze verstorende factoren (sociaaleconomische status, ouderlijk toezicht, persoonlijkheidskenmerken, etc.); (4) Cross-sectioneel ontwerp voorkomt het vaststellen van temporele voorrang, wat noodzakelijk is voor causale inferentie; (5) Geen validatiematen voor zelf-gerapporteerd antisociaal gedrag verhoogt meetfouten. Een robuuste correlationele studie vereist het aanpakken van deze methodologische uitdagingen.",
            
            "2" = "✅ Juist! Dit uitgebreide ontwerp incorporeert belangrijke methodologische sterktes: (1) Longitudinale meting staat toe veranderingen over tijd te volgen en temporele voorrang vast te stellen (ging social media gebruik vooraf aan gedragsveranderingen?); (2) Het meten van meerdere aspecten van social media gebruik (tijd besteed, platformtypen, inhoudsbetrokkenheid) vangt de complexiteit van digitaal gedrag; (3) Het gebruiken van meerdere gedragsmaten versterkt constructvaliditeit en vermindert meetfouten; (4) Controleren voor belangrijke covariaten zoals leeftijd, sociaaleconomische status en familiefactoren helpt alternatieve verklaringen uit te sluiten; (5) Ethisch toezicht zorgt voor deelnemersbescherming, geïnformeerde toestemming, data privacy en gepaste risicomanagement. Dit ontwerp maximaliseert de validiteit van potentiële correlationele bevindingen terwijl het methodologische zwakheden minimaliseert.",
            
            "3" = "❌ Ongepast. Hoewel experimentele ontwerpen causaliteit definitiever kunnen vaststellen dan correlationele ontwerpen, heeft deze benadering ernstige gebreken: (1) Ethische zorgen met potentieel schadelijke manipulatie — onderzoeksetische principes verbieden het blootstellen van deelnemers, vooral minderjarigen, aan interventies die risico kunnen verhogen voor negatieve uitkomsten; (2) Externe validiteitsproblemen, omdat kunstmatig toegewezen social media gebruik verschilt van natuurlijke, zelf-geselecteerde gebruikspatronen; (3) Ecologische validiteitsproblemen, omdat gecontroleerde experimentele condities de echte wereld social media betrokkenheid slecht vertegenwoordigen; (4) Retentie-uitdagingen bij het handhaven van compliantie met toegewezen condities over betekenisvolle tijdsperioden; (5) De vraag vroeg specifiek om een correlationeel ontwerp, niet een experimenteel. Experimentele ontwerpen hebben hun plaats, maar moeten ethisch en gepast worden geïmplementeerd.",
            
            "4" = "❌ Te simplistisch. Deze benadering heeft meerdere conceptuele en methodologische zwakheden: (1) Totale schermtijd is een te algemene maat, die alles omvat van huiswerk tot videogames, niet specifiek social media gebruik; (2) Politiecontacten vertegenwoordigen alleen de meest extreme en gedetecteerde antisociale gedragingen, waardoor de overgrote meerderheid van minor en ongedetecteerde gedragingen wordt gemist; (3) Beide maten zijn zeer vatbaar voor selectiebias, meetfouten en derde-variabele problemen; (4) Geen overweging van belangrijke modererende factoren (leeftijd, geslacht, sociaaleconomische context) die beide variabelen beïnvloeden; (5) Mist meetvaliditeit voor zowel de onafhankelijke als afhankelijke variabelen. De resulterende correlatie zou moeilijk betekenisvol te interpreteren zijn vanwege deze fundamentele beperkingen."
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