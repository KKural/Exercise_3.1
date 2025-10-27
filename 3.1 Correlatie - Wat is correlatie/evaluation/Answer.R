context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Een statistische maat voor de sterkte en richting
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ **Juist!** Correlatie **kwantificeert** hoe **sterk** en in welke **richting** twee kwantitatieve variabelen met elkaar in verband staan. Een **positieve correlatie** (bijv. r = +0,68 tussen **werkloosheid** en **vermogenscriminaliteit**) betekent dat hogere werkloosheid gepaard gaat met hogere criminaliteit, terwijl een **negatieve correlatie** (bijv. r = –0,55 tussen **zichtbaarheid van de politie** en **wanorde**) betekent dat naarmate de ene toeneemt, de andere afneemt.",
            
            "2" = "❌ **Fout.** Dit is een veel voorkomende **misvatting** in onderzoek. Correlatie laat zien dat twee variabelen **samen veranderen**, maar het **bewijst niet** dat de ene de andere **veroorzaakt**. Buurten met een hoge werkloosheid hebben bijvoorbeeld vaak hogere misdaadcijfers, maar dit kan het gevolg zijn van een **derde factor**, zoals armoede, sociale desorganisatie of zwakke informele controle.",
            
            "3" = "❌ **Fout.** Het nemen van een **verschil** (Y - X) meet alleen een kloof, **niet** of de variabelen **samen variëren**. Het verschil tussen diefstal- en mishandelingspercentages zegt bijvoorbeeld niets over de vraag of deze misdaden samen stijgen of dalen. Correlatie onderzoekt **co-variatie** - hoeveel beide variabelen afwijken van hun gemiddelden in dezelfde of tegengestelde richting.",
            
            "4" = "❌ **Fout.** Dat is **regressieanalyse**, **geen correlatie**. Regressie stelt criminologen in staat om bijvoorbeeld het verwachte misdaadcijfer voor een bepaald werkloosheidsniveau te **voorspellen**. Correlatie vat alleen samen hoe twee variabelen op een bepaald moment in de tijd met elkaar in verband staan - het kan **geen voorspellingen** doen of **oorzakelijk verband** bewijzen."
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