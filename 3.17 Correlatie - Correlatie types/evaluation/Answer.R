context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Pearson, Spearman, en Kendall
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ **Juist!** Deze drie correlatiecoëfficiënten zijn inderdaad de belangrijkste en elk heeft specifieke toepassingen. Pearson's r is de meest gebruikte voor continue data met lineaire relaties. Spearman's ρ gebruikt rangnummers, waardoor het robuust is voor uitschieters en geschikt voor ordinale data of niet-lineaire maar monotone relaties. Kendall's τ werkt bijzonder goed met kleine steekproeven of data met veel gelijke waarden.",
            
            "2" = "❌ **Fout.** Kendall's τ is een belangrijke derde optie met specifieke voordelen. Kendall's correlatie is bijzonder waardevol in situaties met kleine steekproeven, data met veel gelijke waarden, of wanneer je een interpretatie wilt in termen van waarschijnlijkheid van concordantie.",
            
            "3" = "❌ **Fout.** Dit antwoord verwarrt correlatie-richtingen (positief, negatief, geen) met correlatie-types (rekenmethoden). Positief, negatief, en geen correlatie beschrijven de richting en sterkte van relaties, niet de statistische methoden die gebruikt worden om ze te berekenen.",
            
            "4" = "❌ **Fout.** Er zijn inderdaad verschillende types correlatiecoëfficiënten met fundamenteel verschillende berekeningsmethoden en toepassingsgebieden. Pearson berekent met werkelijke waarden, Spearman gebruikt rangnummers, en Kendall werkt met concordante paren."
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