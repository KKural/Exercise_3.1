context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Een score die aangeeft hoeveel standaarddeviaties een waarde is ten opzichte van het gemiddelde
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Dit geeft u een **afwijkingsscore**, die aangeeft hoe ver boven of onder het **gemiddelde** een waarde is, maar geen rekening houdt met de **variabiliteit** in uw gegevens. Als het gemiddelde **misdaadcijfer** bijvoorbeeld 50 per 1.000 is en een stad 60 per 1.000 heeft, is de afwijking +10. Maar we kunnen niet beoordelen of dit **'veel'** is zonder te weten of misdaadcijfers doorgaans variëren met **±2 of ±20** rond het gemiddelde. De **z-score** standaardiseert dit door te delen door de **standaarddeviatie**.",
            
            "2" = "❌ **Fout.** **Z-scores** worden uitgedrukt in **standaarddeviatie-eenheden**, niet in **percentages**. Z-scores kunnen echter worden geconverteerd naar **percentielen** met behulp van de **normale verdeling**. **z = +1,0** komt bijvoorbeeld overeen met ongeveer het **84e percentiel** (wat betekent dat 84% van de waarden onder dit punt valt), maar de z-score zelf is **geen percentage**. In de criminologie is dit onderscheid van belang bij het interpreteren van **risicobeoordelingen** of het vergelijken van **misdaadstatistieken** in verschillende rechtsgebieden.",
            
            "3" = "✅ **Juist!** **Z-scores** standaardiseren waarden met behulp van de formule **z = (X - μ)/σ**, waardoor zinvolle vergelijkingen tussen verschillende variabelen of tijdsperioden mogelijk zijn. Als het **geweldsmisdrijfcijfer** van een stad bijvoorbeeld **z = +2,1** heeft, betekent dit dat het **2,1 standaarddeviaties** boven het gemiddelde voor alle steden ligt - een **ongewoon hoog** percentage. Met Z-scores kunnen we vergelijken **'hoe ongebruikelijk'** verschillende soorten criminaliteit zijn: een **inbraakcijfer** met z = +1,5 en een **mishandelingspercentage** met z = +0,8 duiden beide op **bovengemiddelde criminaliteit**, maar inbraak is **extreem hoog**.",
            
            "4" = "❌ **Fout.** Het **kwadrateren** van een score zou de schaal drastisch veranderen en informatie verliezen over de vraag of de oorspronkelijke waarde **boven of onder het gemiddelde** lag. **Z-scores** behouden de **relatieve positie** terwijl ze de schaal standaardiseren. Als we de **misdaadcijfers** in het kwadraat zouden brengen, zou een stad met 100 misdaden per 1.000 **10.000** worden - waardoor de betekenis volledig zou veranderen en **vergelijkingen onmogelijk** zouden worden."
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