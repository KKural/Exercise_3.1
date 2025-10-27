context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Om ervoor te zorgen dat beide variabelen dezelfde schaal hebben en vergelijkbaar zijn
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Standardisatie gaat niet over computationele snelheid maar over statistische validiteit. De berekening van correlaties is niet significant langzamer zonder standardisatie. Het doel van standardisatie is om ervoor te zorgen dat variabelen met verschillende schalen op een eerlijke manier kunnen worden vergeleken.",
            
            "2" = "✅ **Juist!** Standardisatie is essentieel omdat het variabelen met verschillende eenheden en schalen op dezelfde basis brengt. Zonder standardisatie zou een variabele gemeten in grote eenheden (bijv. inkomen in euro's) een onevenredig grote invloed hebben op de correlatie vergeleken met een variabele in kleine eenheden (bijv. leeftijd in jaren). Door beide variabelen te standardiseren krijgen ze dezelfde schaal en kunnen ze eerlijk worden vergeleken.",
            
            "3" = "❌ **Fout.** Standardisatie heeft geen effect op de richting van correlaties. Negatieve correlaties ontstaan wanneer variabelen in tegengestelde richtingen bewegen, ongeacht hun schaal. Standardisatie behoudt de relatieve richting van relaties maar zorgt voor eerlijke vergelijking tussen variabelen.",
            
            "4" = "❌ **Fout.** Standardisatie verandert de vorm van de verdeling niet - het verschuift en schaalt alleen de waarden. Een scheve verdeling blijft scheef na standardisatie. Het doel is schaalvergelijkbaarheid, niet distributienormalisatie."
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