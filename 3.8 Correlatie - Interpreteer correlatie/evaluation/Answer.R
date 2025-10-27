context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Sterke positieve relatie
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Deze interpretatie heeft twee grote fouten: (1) **r = 0,75** is **positief**, niet **negatief** — de waarde ligt boven nul, wat aangeeft dat variabelen in **dezelfde richting** bewegen; (2) **0,75** is **sterk** maar **niet perfect** — een perfecte correlatie zou r = ±1,00 zijn. Een **perfecte negatieve correlatie** (r = -1,00) betekent dat wanneer **sociale cohesie** toeneemt, **preventie effectiviteit** in exact dezelfde verhouding afneemt, zonder uitzonderingen. In de criminologie zijn **perfecte correlaties** vrijwel onmogelijk vanwege de complexiteit van sociale fenomenen en meetfouten.",
            
            "2" = "✅ **Juist!** Waarden rond **0,7-0,8** geven **sterke positieve associaties** aan in sociaalwetenschappelijk onderzoek. Een **r = 0,75** betekent dat wanneer **sociale cohesie** toeneemt, de **effectiviteit van preventie programma's** substantieel toeneemt in een voorspelbaar patroon. In de Nederlandse criminologie context kan dit de **empirische basis** bieden voor investeringen in **gemeenschapsopbouw** als onderdeel van **misdaadpreventie strategieën**. De relatie is **sterk genoeg** om praktisch betekenisvol te zijn voor beleid en voorspelling, waarbij sociale cohesie ongeveer **56% van de variantie** in preventie effectiviteit verklaart. Dit suggereert dat gemeenten met **sterkere sociale bindingen** waarschijnlijk meer succesvol zijn met hun **veiligheidsprogramma's**.",
            
            "3" = "❌ **Fout.** Een **r = 0,75** vertegenwoordigt een **sterke relatie**, **niet zwak**. In criminologisch onderzoek worden correlaties rond **0,75** als behoorlijk substantieel beschouwd. Ter vergelijking: de correlatie tussen **lengte en gewicht** bij volwassenen is typisch rond 0,70-0,80. Als je **r = 0,75** vond tussen buurt **sociale cohesie** en **misdaadpreventie effectiviteit**, zou dit wijzen op een **sterk positief verband** — als sociale cohesie toeneemt, neigen preventie programma's aanzienlijk effectiever te worden. Dit correlatieniveau suggereert dat de variabelen ongeveer **56% van hun variantie delen** (0,75² = 0,56), wat aanzienlijk is in sociaalwetenschappelijk onderzoek en **belangrijke beleidsimplicaties** heeft.",
            
            "4" = "❌ Fout. Een r = 0,75 geeft een sterke en betekenisvolle relatie aan, niet de afwezigheid ervan of statistische ruis. 'Geen relatie' zou worden aangegeven door r ≈ 0,00. Om r = 0,75 in perspectief te plaatsen: veel belangrijke relaties in de criminologie zijn zwakker dan dit — bijvoorbeeld, de correlatie tussen individuele risicofactoren en daadwerkelijk crimineel gedrag kan r = 0,30-0,50 zijn. Het vinden van r = 0,75 tussen sociale cohesie en preventie effectiviteit zou worden beschouwd als een substantiële en praktisch belangrijke associatie die verdere investering in gemeenschapsgerichte preventie strategieën rechtvaardigt."
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