context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # the correct choice: reject the null hypothesis
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Correct! Because 0.03 < 0.05, you reject the null hypothesis - the result is statistically significant.
            "1" = "✅ Juist! Omdat 0,03 < 0,05, verwerp je de nulhypothese — het resultaat is statistisch significant.",
            
            # ❌ Incorrect. You only retain the null hypothesis when p ≥ α; that's not the case here.
            "2" = "❌ Fout. Je behoudt de nulhypothese enkel als p ≥ α; dat is hier niet het geval.",
            
            # ❌ Incorrect. A p-value below 0.05 actually indicates a significant difference.
            "3" = "❌ Fout. Een p-waarde onder 0,05 wijst juist op een significant verschil.",
            
            # ❌ Incorrect. The chance of a Type I error remains at 5%, not 3%. The p-value gives the probability of the observed data under H₀, not the error probability itself.
            "4" = "❌ Fout. De kans op een Type I-fout blijft op 5%, niet 3%. De p-waarde geeft de waarschijnlijkheid van de geobserveerde data onder H₀, niet de foutkans zelf."
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