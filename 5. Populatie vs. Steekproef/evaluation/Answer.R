context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # Correct answer: Q5 from your rotation pattern
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Er is wel degelijk een verschil tussen populatie en steekproef in termen van omvang en representatie.",
            
            "2" = "❌ Fout. Dit is andersom. De steekproef is een deel van de populatie, niet omgekeerd.",
            
            "3" = "❌ Fout. De grootte van een populatie hangt af van wat je onderzoekt, niet van een vast getal.",
            
            "4" = "✅ Juist! Een populatie bestaat uit alle eenheden waarin je geïnteresseerd bent, een steekproef is een subset daarvan. Als je de hele populatie onderzoekt, heet dat een census. Meestal bestudeer je echter een steekproef, omdat het vaak te duur of onpraktisch is om iedereen te onderzoeken."
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