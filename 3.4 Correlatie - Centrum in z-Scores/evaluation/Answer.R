context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Er is geen lineaire relatie tussen de variabelen
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Een **perfecte positieve relatie** wordt aangegeven door **r = +1,00**, niet r = 0. Bij **r = +1** betekent dit dat wanneer de ene variabele toeneemt, de andere variabele altijd in **dezelfde verhouding** toeneemt. Bijvoorbeeld, als er een perfecte positieve correlatie zou zijn tussen het aantal **politieagenten** en **veiligheid** (wat in de praktijk nooit voorkomt), zou elke toename van **politieaanwezigheid** precies evenredig samengaan met **verhoogde veiligheid**.",
            
            "2" = "❌ **Fout.** Een **perfecte negatieve relatie** wordt aangegeven door **r = -1,00**, niet r = 0. Bij **r = -1** betekent dit dat wanneer de ene variabele toeneemt, de andere variabele altijd in precies **dezelfde verhouding afneemt**. Bijvoorbeeld, als er een perfecte negatieve correlatie zou zijn tussen **politieaanwezigheid** en **criminaliteit**, zou elke toename van politie exact evenredig samengaan met **afname van misdaad**.",
            
            "3" = "✅ **Juist!** Een correlatie van **r = 0** betekent dat er **geen lineaire relatie** bestaat tussen de twee variabelen. De variabelen bewegen **niet systematisch samen** - wanneer de ene variabele toeneemt, is er **geen voorspelbaar patroon** in de andere variabele. Bijvoorbeeld, er kan een correlatie van **r ≈ 0** zijn tussen **schoengrootte** van politieagenten en hun **effectiviteit** in misdaadpreventie - deze variabelen zijn **onafhankelijk** van elkaar. Let op: **r = 0** sluit wel andere soorten relaties uit (zoals **kromme verbanden**).",
            
            "4" = "❌ **Fout.** Een correlatie van **nul** duidt niet op **meetfouten**, maar op het ontbreken van een **lineaire relatie**. Veel variabelen in de criminologie hebben legitiem **geen verband** met elkaar. Bijvoorbeeld, de correlatie tussen de **kleur van politieauto's** en **misdaadpreventie-effectiviteit** zou logischerwijs **r ≈ 0** zijn - dit zijn gewoon **onafhankelijke variabelen**. Een correlatie van nul is een **zinvolle bevinding** die aantoont dat de bestudeerde factoren **niet lineair samenhangen**."
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