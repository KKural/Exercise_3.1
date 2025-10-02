context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) {
          # Parse the student's answer
          result <- env$evaluationResult
          if (is.character(result)) {
            # Split by various separators and convert to numeric
            numbers <- as.numeric(unlist(strsplit(gsub(",", ".", result), "[ ,;\n\t]+")))
            # Remove any NA values
            numbers <- numbers[!is.na(numbers)]
            return(numbers)
          }
          return(as.numeric(result))
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
            get_reporter()$add_message("❌ Eén of meer antwoorden zijn niet correct afgerond. Controleer je berekeningen en afrondingen. Verwachte antwoorden: 6,98; 0,92; 10,66; 3,88; 87,00; 0,56; 55,25; 0,66; 7,52; 20,95", type = "markdown")
          }
          
          return(correct)
        }
      )
    }
  )
})

