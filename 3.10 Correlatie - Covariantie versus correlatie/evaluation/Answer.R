context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Covariantie hangt af van meeteenheden, correlatie is eenheidsvrij
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Beide maatstaven kunnen zowel **positief** als **negatief** zijn, afhankelijk van de **richting** van de relatie tussen variabelen. **Covariantie** kan variëren van **negatief oneindig** tot **positief oneindig**, terwijl **correlatie** varieert van **-1 tot +1**. Bijvoorbeeld, de relatie tussen **politie-aanwezigheid** en **criminaliteitscijfers** zou zowel een **negatieve covariantie** als een **negatieve correlatie** kunnen tonen, wat aangeeft dat meer politie-aanwezigheid geassocieerd is met **lagere criminaliteitscijfers**. De **richting** (positief of negatief) hangt af van de onderliggende relatie tussen de variabelen, niet van welke maatstaf je gebruikt.",
            
            "2" = "✅ **Juist!** Dit is het **fundamentele onderscheid**. **Covariantie** verandert wanneer je de **schaal** van variabelen wijzigt - als je **inkomen** meet in euro's versus duizenden euro's, krijg je verschillende **covariantiewaarden** voor dezelfde relatie. **Correlatie** blijft daarentegen **constant** ongeacht de **meeteenheden** omdat het een **gestandaardiseerde maatstaf** is. Bijvoorbeeld: de correlatie tussen **buurtinkomen** en **criminaliteit** blijft **r = -0,45** of je inkomen meet in euro's, duizenden euro's, of dollars. Deze **eenheidsvrije eigenschap** maakt correlatie veel praktischer voor **vergelijkende analyses** en interpretatie, terwijl covariantie afhankelijk is van willekeurige keuzes in **meeteenheden**.",
            
            "3" = "❌ **Fout.** **Correlatie** kan waarden aannemen tussen **-1 en +1**, niet alleen tussen **0 en 1**. Het bereik van **-1 tot +1** omvat zowel **negatieve** als **positieve** relaties. Een correlatie van **-1** betekent een **perfecte negatieve relatie** (als de ene variabele toeneemt, neemt de andere perfect voorspelbaar af), **0** betekent **geen lineaire relatie**, en **+1** betekent een **perfecte positieve relatie**. In criminologisch onderzoek zie je bijvoorbeeld vaak **negatieve correlaties** tussen **sociaaleconomische status** en **criminaliteitscijfers** (**r = -0,60**), wat aangeeft dat hogere sociaaleconomische status geassocieerd is met **lagere criminaliteitscijfers**.",
            
            "4" = "❌ **Fout.** Hoewel beide de **richting** van een relatie aangeven, hebben ze zeer verschillende **interpretatiekaders**. **Covariantiewaarden** hebben geen **gestandaardiseerd bereik** en zijn moeilijk te interpreteren zonder context van de oorspronkelijke variabelen - een covariantie van **500** kan sterk of zwak zijn afhankelijk van de **schalen** van de variabelen. **Correlatie** heeft daarentegen een **vast interpretatiekader**: waarden rond **±0,10** zijn zwak, rond **±0,30** zijn matig, rond **±0,50** zijn sterk, en boven **±0,70** zijn zeer sterk. Deze **gestandaardiseerde interpretatie** maakt correlatie veel praktischer voor **onderzoekscommunicatie** en **vergelijkende analyses**."
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