context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Een matige positieve relatie waarbij SES en criminaliteit 16% gedeelde variantie hebben
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Deze interpretatie maakt twee fouten. Ten eerste is r = 0,40 een matige (niet sterke) correlatie. Ten tweede verklaart SES niet 40% van criminaliteit - de verklaarde variantie wordt berekend als R² = r², dus R² = 0,40² = 0,16 (16%). Een r van 0,40 duidt op een nuttige maar beperkte relatie waarbij vele andere factoren de overige 84% van de variantie verklaren.",
            
            "2" = "✅ **Juist!** Een correlatie van r = 0,40 wordt geclassificeerd als matig sterk en verklaart R² = 0,16 (16%) van de variantie. Dit betekent dat variaties in sociaaleconomische status ongeveer 16% van de waargenomen variatie in criminaliteitscijfers kunnen verklaren, terwijl andere factoren de resterende 84% verklaren. Een matige correlatie biedt nuttige voorspellende waarde voor beleid maar moet worden aangevuld met andere risicofactoren.",
            
            "3" = "❌ **Fout.** Een correlatie van r = 0,40 is niet zwak - het valt in de matige categorie volgens Cohen's richtlijnen. Bovendien impliceert de vraag geen informatie over statistische significantie, dus we kunnen geen uitspraak doen over statistische betekenis.",
            
            "4" = "❌ **Fout.** Een correlatie van r = 0,40 is verre van perfect (perfect zou r = 1,00 zijn) en correlatie bewijst nooit causaliteit, ongeacht sterkte. Deze interpretatie maakt fundamentale statistische fouten."
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