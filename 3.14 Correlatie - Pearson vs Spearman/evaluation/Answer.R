context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # Correct answer: Spearman correlatie omdat het monotone relaties kan meten
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Pearson en Spearman meten verschillende soorten relaties en geven daarom verschillende resultaten bij niet-lineaire (gebogen) patronen. Pearson correlatie veronderstelt een lineaire relatie en onderschat de werkelijke sterkte van de monotone relatie. Spearman correlatie vangt de consistente rangorde-relatie beter op.",
            
            "2" = "❌ **Fout.** Spearman correlatie is juist specifiek ontworpen voor monotone (altijd dezelfde richting) maar niet-lineaire (gebogen) relaties zoals deze. Hoewel Pearson inderdaad minder geschikt is, biedt Spearman een uitstekende oplossing door rangorden te gebruiken in plaats van de werkelijke waarden.",
            
            "3" = "❌ **Fout.** Pearson correlatie is inderdaad de meest gebruikte, maar dat maakt het niet automatisch geschikt voor alle situaties. Pearson meet specifiek lineaire associaties en zal het gebogen maar monotone patroon onderschatten. Het automatisch gebruiken van Pearson kan leiden tot het missen van belangrijke patronen in data.",
            
            "4" = "✅ **Juist!** Spearman correlatie is specifiek ontworpen voor monotone relaties, ongeacht of ze lineair zijn of niet. Het werkt door variabelen om te zetten naar rangorden en vervolgens de correlatie tussen deze rangorden te berekenen. Hierdoor kan het gebogen patronen vastleggen zolang ze maar consistent in één richting gaan. In criminologische context zijn monotone maar niet-lineaire relaties veel voorkomend."
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