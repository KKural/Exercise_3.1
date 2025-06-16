context({
  testcase(
    "",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Correct! Null hypotheses are always about population parameters (μ), not sample means.
            "1" = "✅ Correct! De nulhypothese vergelijkt de populatiegemiddelden: er is geen verschil tussen de twee omstandigheden.",
            
            # ❌ No. This is a directional (one-tailed) hypothesis, not the null hypothesis used in dit onderzoek.
            "2" = "❌ Nee. Dit is een alternatieve hypothese in één richting, en hoort niet bij een tweezijdige nulhypothese.",
            
            # ❌ Incorrect. The null hypothesis compares population parameters (μ), not sample means (\u0304x).
            "3" = "❌ Fout. De nulhypothese gaat over populatiegemiddelden, niet over de steekproefgemiddelden.",
            
            # ❌ Not correct. μ = 300 is een specifieke waarde, maar niet relevant in deze context van twee groepen.
            "4" = "❌ Niet juist. μ = 300 stelt een waarde in plaats van een vergelijking tussen groepen."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Kies een getal tussen 1 en 4."
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})
