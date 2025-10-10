context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Q6 from your rotation pattern
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ Juist! Beschrijvende statistiek helpt je om overzicht te krijgen van je data. Voorbeelden: 'De gemiddelde leeftijd van arrestanten was 28 jaar', '60% van de diefstallen gebeurde 's avonds', een grafiek van criminaliteitscijfers per maand. [Lees meer](https://statistics.laerd.com/statistical-guides/descriptive-inferential-statistics.php)",
            
            "2" = "❌ Fout. Dit wordt gedaan door inferentiële statistiek. Voorbeeld: op basis van steekproef van 500 mensen voorspellen hoeveel criminaliteit er in een hele stad is. [Lees meer](https://statistics.laerd.com/statistical-guides/descriptive-inferential-statistics.php)",
            
            "3" = "❌ Fout. Dit wordt gedaan door inferentiële statistiek. Voorbeeld: testen of werkloosheid echt zorgt voor meer criminaliteit met p-waarden en significantietests. [Lees meer](https://statistics.laerd.com/statistical-guides/descriptive-inferential-statistics.php)",
            
            "4" = "❌ Fout. Dit wordt gedaan door predictieve analyse. Beschrijvende statistiek kijkt alleen naar de data die je al hebt. [Lees meer](https://statistics.laerd.com/statistical-guides/descriptive-inferential-statistics.php)"
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