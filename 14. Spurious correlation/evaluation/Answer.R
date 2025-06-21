context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # the correct choice: spurious correlation
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ Incorrect. If unemployment caused youth delinquency, the correlation would remain high after controlling for population density.
            "1" = "❌ Fout. Als werkloosheid jeugdoverlast zou veroorzaken, zou de correlatie hoog blijven na controle voor bevolkingsdichtheid.",
            
            # ✅ Correct! When a correlation drops substantially after controlling for a third variable, it suggests the original correlation was spurious.
            "2" = "✅ Juist! Wanneer een correlatie sterk afneemt na controle voor een derde variabele, wijst dit erop dat de oorspronkelijke correlatie spurieus was - de relatie werd eigenlijk veroorzaakt door die derde variabele (in dit geval bevolkingsdichtheid).",
            
            # ❌ Incorrect. If population density enhanced the effect, the correlation would not drop so dramatically.
            "3" = "❌ Fout. Als bevolkingsdichtheid het effect zou versterken, zou de correlatie niet zo sterk dalen na controle voor deze variabele.",
            
            # ❌ Incorrect. There is still a small correlation (0.1) between unemployment and youth delinquency.
            "4" = "❌ Fout. Er is nog steeds een kleine correlatie (0,1) tussen werkloosheid en jeugdoverlast, dus het is niet juist om te zeggen dat er geen verband is."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # ❌ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})