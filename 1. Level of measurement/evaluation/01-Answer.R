context({
  testcase(
    "Afrondingsregels: controleer de antwoorden",
    {
      testEqual(
        "",
        function(env) {
          # Verwacht een vector van afgeronde getallen als antwoord
          result <- env$evaluationResult
          if (is.character(result)) {
            # Split by various separators and convert to numeric
            numbers <- as.numeric(unlist(strsplit(gsub(",", ".", result), "[ ,;\n\t]+")))
            # Remove any NA values
            numbers <- numbers[!is.na(numbers)]
            return(numbers)
          }
          return(result)
        },
        c(6.98, 0.92, 10.66, 3.88, 87.00, 0.56, 55.25, 0.66, 7.52, 20.95),
        comparator = function(generated, expected, ...) {
          if (length(generated) != length(expected)) {
            cat("❌ Je hebt niet het juiste aantal antwoorden gegeven.\n")
            return(FALSE)
          }
          correct <- all(abs(generated - expected) < 0.01)
          if (correct) {
            cat("✅ Goed gedaan! Alle antwoorden zijn correct afgerond op twee decimalen.\n")
          } else {
            cat("❌ Eén of meer antwoorden zijn niet correct afgerond. Controleer je berekeningen en afrondingen.\n")
          }
          return(correct)
        }
      )
    }
  )
})

