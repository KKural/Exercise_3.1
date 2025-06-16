context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # the correct choice: population means comparison
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Correct! Population means are always used in null hypotheses.
            "1" = "✅ Correct! De nulhypothese vergelijkt de populatiegemiddelden: er is geen verschil tussen de twee omstandigheden.",
            
            # ❌ Directional hypothesis – this is an alternative, not a null.
            "2" = "❌ Nee. Dit is een alternatieve hypothese in één richting, niet de nulhypothese.",
            
            # ❌ Sample means – null hypotheses are about population parameters, not sample statistics.
            "3" = "❌ Fout. De nulhypothese gaat over populatiegemiddelden (μ), niet over steekproefgemiddelden (x̄).",
            
            # ❌ Specific population value – unrelated to the two-group comparison in this study.
            "4" = "❌ Niet juist. μ = 300 vergelijkt geen twee groepen en is dus niet relevant hier."
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
