context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # correct: burglary (inbraak) has the highest median and contains outliers
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ No. The box for inbraak is highest, indicating a high median, not the lowest.
            "1" = "❌ Fout. De box voor ‘Inbraak’ ligt juist het hoogst, dus de mediaan is het hoogste, niet het laagste.",
            
            # ❌ Incorrect. The widest box or whiskers would indicate greatest spread—check the image.
            "2" = "❌ Fout. De spreiding is visueel het grootst bij ‘Inbraak’, niet bij ‘Autokraken’.",
            
            # ✅ Correct! The box for ‘Inbraak’ is highest, showing a high median and has outliers beyond the whisker.
            "3" = "✅ Juist! ‘Inbraak’ heeft de hoogste mediaan én enkele uitschieters boven de bovenste whisker.",
            
            # ❌ Not correct. Mishandeling does show a box and whiskers, meaning there is variation.
            "4" = "❌ Fout. ‘Mishandeling’ toont wel degelijk spreiding; het heeft een box en whiskers in de plot."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # ❌ Please enter a number between 1 en 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})
