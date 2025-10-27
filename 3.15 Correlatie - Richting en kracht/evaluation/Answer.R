context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Sterk positief
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ **Juist!** Een strakke wolk van punten die dicht geclusterd zijn rond een opwaarts hellende lijn is de visuele kenmerk van een sterke positieve correlatie (typisch r > 0,7). Dit patroon geeft zowel de richting van de relatie aan (positief) als de sterkte ervan (sterk). De visualisatie toont minimale afwijking van de trendlijn, wat suggereert een zeer voorspelbare relatie waarbij het kennen van de sociale binding-score nauwkeurige voorspelling van delinquent gedrag mogelijk maakt.",
            
            "2" = "❌ **Fout.** Het beschreven patroon is veel strakker dan 'matig' zou suggereren. Bij een matige positieve correlatie zou je meer spreiding rond de trendlijn zien, met punten die verder van de lijn afliggen. De beschrijving van 'strak geclusterde punten met minimale spreiding' duidt op een veel sterkere relatie.",
            
            "3" = "❌ **Fout.** Het patroon wordt beschreven als 'omhoog hellend', wat een positieve relatie aangeeft, niet negatief. Een negatieve correlatie zou worden gekenmerkt door een neerwaarts hellende trendlijn. Bovendien suggereert de strakke clustering een sterke, niet zwakke relatie.",
            
            "4" = "❌ **Fout.** Hoewel de beschrijving van 'strak geclusterd' wel een sterke relatie zou aangeven, wordt de trendlijn beschreven als 'omhoog hellend', wat positief is, niet negatief. Een sterke negatieve correlatie zou gekenmerkt worden door een neerwaarts hellende lijn met strak geclusterde punten."
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