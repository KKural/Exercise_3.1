context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # het juiste antwoord: mediaan (85) > gemiddelde (~83.91)
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ Incorrect. Actually, the mean (~83.9) is *less* than the median (85).
            "1" = "❌ Fout. Het gemiddelde (~83,9) is kleiner  dan de mediaan (85).",
            
            # ✅ Correct! The median (85) exceeds the mean (~83.9).
            "2" = "✅ Juist! De mediaan (85) is groter dan het gemiddelde (~83,9).",
            
            # ❌ Nope. The mode (85) equals the median, so it’s not strictly greater than the mean.
            "3" = "❌ Fout. Hoewel de modus (85) groter is dan het gemiddelde (~83,9), is de modus gelijk aan (niet groter dan) de mediaan (85).",
            
            # ❌ Not quite. The mean, median, and mode aren’t all equal—the mean is a bit lower.
            "4" = "❌ Fout. Het gemiddelde, de mediaan en de modus zijn niet allemaal gelijk—het gemiddelde ligt iets lager."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # ❌ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          generated == expected
        }
      )
    }
  )
})
