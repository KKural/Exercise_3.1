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
            # ✅ Correct! District X has a crime rate of 85, far above the national average of 50.
            "1" = "✅ Juist! District X heeft een cijfer van 85, wat duidelijk boven het nationale gemiddelde van 50 ligt en dus een uitschieter is.",
            
            # ❌ Incorrect. 52 is slightly above average, but not an outlier.
            "2" = "❌ Fout. District Y zit maar net boven het gemiddelde en valt niet echt op als uitschieter.",
            
            # ❌ No. 48 is slightly below average, but still close to 50.
            "3" = "❌ Fout. District Z ligt iets onder het gemiddelde, maar is geen opvallende afwijking.",
            
            # ❌ Not correct. District W is exactly at the national average of 50.
            "4" = "❌ Fout. District W zit exact op het nationale gemiddelde en is dus geen uitschieter."
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
