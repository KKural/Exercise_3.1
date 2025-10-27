context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Correlatie is eenheidsvrij en altijd tussen −1 en +1
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Een belangrijk onderscheid tussen deze maatstaven is dat **covariantie** afhangt van **meetschaal** terwijl **correlatie** dat niet doet. Als je **eenheden** verandert (bijv. van meters naar centimeters), zal de covariantie proportioneel veranderen, maar correlatie blijft **onveranderd**. Dit is waarom correlatie de voorkeur heeft voor **vergelijkende analyse** - het biedt een **gestandaardiseerde maatstaf** die niet wordt beïnvloed door willekeurige keuzes in **meeteenheden**. Het meten van **temperatuur** in Celsius versus Fahrenheit zou bijvoorbeeld verschillende **covariantiewaarden** opleveren, maar identieke **correlatiecoëfficiënten** bij het onderzoeken van relaties met andere variabelen.",
            
            "2" = "❌ **Fout.** Je hebt **covariantie** verward met **correlatie**. Covariantie is **NIET eenheidsvrij** en is **NIET begrensd** tussen -1 en +1. **Covariantiewaarden** hangen af van de **meeteenheden** (bijv. euro's, kilogrammen, jaren) en kunnen variëren van **negatief oneindig** tot **positief oneindig**. Bijvoorbeeld, de covariantie tussen **inkomen** (gemeten in duizenden euro's) en **onderwijs** (gemeten in jaren) kan **4,5** zijn, maar als inkomen in euro's werd gemeten, zou de covariantie **4.500** zijn - een heel ander getal dat dezelfde **relatiesterkte** vertegenwoordigt.",
            
            "3" = "✅ **Juist!** **Correlatie (r)** standaardiseert de relatie door **covariantie** te delen door het product van **standaarddeviaties**, waardoor een **eenheidsvrije maatstaf** ontstaat die altijd tussen **-1 en +1** valt. Deze **standaardisatie** is waarom we correlatiewaarden zinvol kunnen vergelijken tussen verschillende **variabelenparen** ongeacht hun oorspronkelijke **meetschalen**. Bijvoorbeeld, **r = 0,7** vertegenwoordigt dezelfde **relatiesterkte** of we nu lengte met gewicht correleren of testscores met studietijd. Deze **begrensde**, **gestandaardiseerde** aard maakt correlatie de **voorkeursmaat** voor het vergelijken van **relatiesterkte** tussen verschillende variabelenparen.",
            
            "4" = "❌ **Fout.** Hoewel **covariantie** inderdaad **onbegrensd** is (variërend van **negatief oneindig** tot **positief oneindig**), is **correlatie** specifiek ontworpen om **begrensd** te zijn tussen **-1 en +1**. Dit is een **fundamenteel verschil** tussen deze twee maatstaven. De **begrensde aard** van correlatie komt voort uit het **normalisatieproces**, waarbij covariantie wordt gedeeld door het product van standaarddeviaties. Deze **wiskundige transformatie** zorgt ervoor dat, ongeacht hoe groot de covariantie mogelijk is, de correlatiecoëfficiënt altijd binnen het **gestandaardiseerde bereik** van -1 tot +1 valt, waardoor het gemakkelijker te **interpreteren** en **vergelijken** is tussen verschillende analyses."
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