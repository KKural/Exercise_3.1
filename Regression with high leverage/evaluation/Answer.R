context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # correct: perform sensitivity analysis with and without the influential case
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # âŒ No. You shouldn't assume it's a measurement error without evidence.
            "1" = "❌ Fout. Zonder duidelijke aanwijzing voor een meetfout mag je een observatie niet zomaar negeren.",
            
            # âŒ InJuist. High leverage *does* influence regression results, especially with large residuals.
            "2" = "❌ Fout. Leverage heeft juist invloed, vooral in combinatie met een groot residu.",
            
            # âœ… Correct! Sensitivity analysis helps assess the impact of the influential point on the model.
            "3" = "✅ Juist! Een sensitiviteitsanalyse met en zonder die wijk laat zien hoeveel invloed deze observatie op het model heeft.",
            
            # âŒ Not Juist. A large residual indicates the point *does not* fit well on the line.
            "4" = "❌ Fout. Een groot residu betekent dat de observatie *ver afwijkt* van de regressielijn en dus niet goed past."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # âŒ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})
