context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # correct: District X (85) is the outlier compared to national average of 50
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Juist! District X is a statistical outlier based on standard measures.
            "1" = "✅ Juist! District X heeft een cijfer van 85, wat 2.33 standaarddeviaties boven het nationale gemiddelde van 50 ligt (SD = 15). Waarden die meer dan 1.5 SD van het gemiddelde liggen worden typisch als uitschieters beschouwd. Met z = (85-50)/15 = 2.33 is District X duidelijk een statistische uitschieter.",
            
            # ❌ Fout. District Y is above average but not enough to be considered an outlier.
            "2" = "❌ Fout. District Y zit met een waarde van 60 slechts 0.67 standaarddeviaties boven het gemiddelde (z = (60-50)/15 = 0.67). Aangezien deze waarde binnen 1.5 SD van het gemiddelde valt, wordt dit niet als een statistische uitschieter beschouwd.",
            
            # ❌ Fout. District Z is below average but not enough to be an outlier.
            "3" = "❌ Fout. District Z ligt met een waarde van 45 slechts 0.33 standaarddeviaties onder het gemiddelde (z = (45-50)/15 = -0.33). Dit valt ruim binnen de normale spreiding en wordt niet als statistische uitschieter gezien.",
            
            # ❌ Fout. District W is exactly average, so definitely not an outlier.
            "4" = "❌ Fout. District W zit exact op het nationale gemiddelde (z = (50-50)/15 = 0) en wijkt dus helemaal niet af van de norm. Een uitschieter moet statistisch significant afwijken van het gemiddelde, typisch meer dan 1.5 SD."
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
