context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        4,  # Correct answer: Interval/Ratio
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Nominaal betekent categorieën zonder rangorde. Voorbeeld: haarkleur (blond, bruin, zwart) is nominaal. Leeftijd heeft wel numerieke waarden en rangorde. [Lees meer over meetschalen](https://www.questionpro.com/blog/nominal-ordinal-interval-ratio/)",
            
            "2" = "❌ Fout. Ordinaal heeft rangorde maar geen gelijke intervallen. Voorbeeld: opleidingsniveau (laag, midden, hoog) is ordinaal. Leeftijd heeft gelijke intervallen tussen jaren. [Lees meer over meetschalen](https://www.questionpro.com/blog/nominal-ordinal-interval-ratio/)",
            
            "3" = "❌ Fout. Dichotoom betekent slechts twee categorieën. Voorbeeld: geslacht (man/vrouw) of ja/nee vragen. Leeftijd heeft een oneindig aantal mogelijke waarden. [Lees meer over meetschalen](https://www.questionpro.com/blog/nominal-ordinal-interval-ratio/)",
            
            "4" = "✅ Juist! Leeftijd is interval/ratio omdat het numerieke waarden heeft, gelijke intervallen, en een absoluut nulpunt (0 jaar = geen leeftijd). Voorbeeld: leeftijd in jaren: 18, 19, 20, ... [Lees meer over meetschalen](https://www.questionpro.com/blog/nominal-ordinal-interval-ratio/)"
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