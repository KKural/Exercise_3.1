context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # the correct choice: strong positive linear relationship
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ Incorrect. Correlation does not imply that 75% of crime is caused by unemployment.
            "1" = "❌ Fout. Een correlatie van 0,75 betekent niet dat 75% van de criminaliteit veroorzaakt wordt door werkloosheid.",
            
            # ✅ Correct! A Pearson correlation of 0.75 indicates a strong positive linear association.
            "2" = "✅ Juist! Een Pearson-correlatie van 0,75 wijst op een sterke positieve lineaire samenhang tussen werkloosheid en eigendomscriminaliteit.

Bijvoorbeeld: stel dat we 10 wijken analyseren. In wijken waar de werkloosheid 5% boven het gemiddelde ligt, zien we vaak dat de eigendomscriminaliteit ongeveer 3,75% hoger is dan gemiddeld (0,75 × 5% = 3,75%). Dit patroon van samen bewegen is wat de correlatie meet.

Belangrijk: correlatie betekent niet dat werkloosheid de criminaliteit veroorzaakt! Beide kunnen door andere factoren worden beïnvloed. [Leer meer over correlatie vs. causaliteit](https://www.numberanalytics.com/blog/correlation-vs-causation-criminology-research)",
            
            # ❌ No. Correlation indicates association, not causation.
            "3" = "❌ Fout. Correlatie betekent samenhang, maar geen causaal verband.",
            
            # ❌ Not correct. A correlation coefficient is not an average or rate per population unit.
            "4" = "❌ Fout. Een correlatie van 0,75 zegt niets over het aantal criminaliteitsgevallen per 1.000 inwoners."
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
