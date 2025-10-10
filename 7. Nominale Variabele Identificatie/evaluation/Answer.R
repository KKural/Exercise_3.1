context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Q7 from your rotation pattern
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ Juist! Type misdrijf bestaat uit categorieën zonder natuurlijke rangorde - je kunt niet zeggen dat diefstal 'meer' of 'minder' is dan geweld.",
            
            "2" = "❌ Fout. Temperatuur heeft numerieke waarden en een natuurlijke rangorde (warmer/kouder).",
            
            "3" = "❌ Fout. Dit is ordinaal omdat er een duidelijke rangorde is van laag naar hoog.",
            
            "4" = "❌ Fout. Leeftijd is ratio omdat het numerieke waarden heeft met een absoluut nulpunt."
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