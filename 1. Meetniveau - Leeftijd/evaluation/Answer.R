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
            "2" = "❌ Fout. Als je uitgaat van leeftijd in jaren is het antwoord fout, omdat ordinaal alleen rangorde aangeeft en geen gelijke intervallen. Leeftijd heeft wél gelijke intervallen tussen jaren, dus het oorspronkelijke meetniveau is interval/ratio (ratio, omdat er een natuurlijk nulpunt is). Wel is het mogelijk om van een interval/ratio-variabele een categorische variabele te maken. Bijvoorbeeld door leeftijden in categorieën zoals “0-9”, “4-12”, “13-17” enz. in te delen. In dat geval wordt het meetniveau ordinaal, omdat de categorieën een rangorde hebben, maar de exacte afstanden tussen categorieën niet meer relevant zijn. [Lees meer over meetschalen](https://www.questionpro.com/blog/nominal-ordinal-interval-ratio/)",
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
