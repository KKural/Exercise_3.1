context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Q10 from your rotation pattern
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Data verzamelen zonder plan is zoals een huis bouwen zonder tekening - mogelijk, maar niet effectief. (refer Deel 1 boek page 8)",
            
            "2" = "❌ Fout. Je hebt eerst data nodig voordat je statistieken kunt berekenen. (refer Deel 1 boek page 8)",
            
            "3" = "✅ Juist! Observatie en nieuwsgierigheid zijn de eerste stappen die vaak over het hoofd worden gezien. Je moet eerst kijken wat er gebeurt en specifieke vragen formuleren voordat je data gaat verzamelen. (refer Deel 1 boek page 8)",
            
            "4" = "❌ Fout. Conclusies komen aan het einde van het onderzoeksproces, niet aan het begin. (refer Deel 1 boek page 8)"
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