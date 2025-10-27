context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Wanneer er een monotone maar niet-lineaire relatie is, of er extreme uitschieters zijn
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Pearson correlatie heeft belangrijke voordelen wanneer aan zijn veronderstellingen wordt voldaan: het is krachtiger, geeft interpreteerbare coëfficiënten voor lineaire relaties, en is de basis voor vele andere statistische procedures. Het blind gebruiken van Spearman voor alle analyses betekent dat je kracht verliest bij echte lineaire relaties.",
            
            "2" = "❌ **Fout.** Steekproefgrootte bepaalt niet direct de keuze tussen Pearson en Spearman. Beide correlatiemethoden kunnen gebruikt worden met kleine steekproeven. De keuze hangt af van de aard van je data (lineair vs monotoon, uitschieters, datatype) niet van de steekproefgrootte.",
            
            "3" = "✅ **Juist!** Spearman's rangcorrelatie is superieur in beide situaties. Bij niet-lineaire maar monotone relaties vangt Spearman de sterke monotone trend beter op dan Pearson omdat het rangnummers gebruikt. Bij extreme uitschieters is Spearman veel robuuster omdat rangnummers de invloed van extreme waarden minimaliseren.",
            
            "4" = "❌ **Fout.** Bij perfecte lineaire relaties is Pearson's r juist superieur aan Spearman's ρ. Pearson correlatie is specifiek ontworpen voor lineaire relaties en zal in dit geval de maximale kracht hebben en de meest nauwkeurige schatting geven."
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