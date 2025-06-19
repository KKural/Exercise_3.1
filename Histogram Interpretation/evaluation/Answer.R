context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # the correct choice: right-skewed, most months low with a few high peaks
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Correct! Right-skewed means most values are low, with a tail toward higher values.
            "1" = "✅ Juist! De verdeling is *rechts-scheef*: de meeste maanden hebben lage waarden, met een paar uitzonderlijk hoge pieken.",
            
            # ❌ Incorrect. Left-skewed means the opposite—most values are high, with a tail to the left.
            "2" = "❌ Fout. Een *links-scheve* verdeling betekent dat de meeste waarden hoog zijn, wat hier niet het geval is.",
            
            # ❌ No. A symmetric distribution would show a bell shape around the mean, which this does not.
            "3" = "❌ Fout. Een symmetrische verdeling zou een klokvorm rond het gemiddelde tonen, maar dat zien we hier niet.",
            
            # ❌ Not correct. Bimodal distributions have two clear peaks, which are not present in this histogram.
            "4" = "❌ Fout. Een *bimodale* verdeling heeft twee duidelijke pieken, en dat is hier niet te zien."
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
