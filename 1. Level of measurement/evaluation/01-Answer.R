context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) {
          # Parse student answer - expect comma-separated values
          result <- trimws(env$evaluationResult)
          numbers <- as.numeric(unlist(strsplit(gsub(",", ".", result), "[ ,;\n\t]+")))
          numbers[!is.na(numbers)]
        },
        c(6.98, 0.92, 10.66, 3.88, 87.00, 0.56, 55.25, 0.66, 7.52, 20.95),
        comparator = function(generated, expected, ...) {
          if (length(generated) != length(expected)) {
            get_reporter()$add_message("❌ Je hebt niet het juiste aantal antwoorden gegeven. Verwacht: 10 getallen.", type = "markdown")
            return(FALSE)
          }
          
          correct <- all(abs(generated - expected) < 0.01)
          if (correct) {
            get_reporter()$add_message("✅ Goed gedaan! Alle antwoorden zijn correct afgerond op twee decimalen.", type = "markdown")
          } else {
            get_reporter()$add_message("❌ Eén of meer antwoorden zijn niet correct afgerond. Controleer je berekeningen en afrondingen.", type = "markdown")
          }
          
          return(correct)
        }
      )
    }
  )
})

