context({
  testcase(" ", {
    testEqual(
      "",
      function(env) {
        result <- trimws(env$evaluationResult)
        numbers <- as.numeric(unlist(strsplit(gsub(",", ".", result), "[ ,;\n\t]+")))
        if (length(numbers) == 0 || all(is.na(numbers))) {
          get_reporter()$add_message("❌ Je antwoord kon niet worden gelezen als getallen. Vul 10 afgeronde getallen in.", type = "error")
          return(rep(NA_real_, 10))
        }
        numbers[!is.na(numbers)]
      },
      c(6.98, 0.92, 10.66, 3.88, 87.00, 0.56, 55.25, 0.66, 7.52, 20.95),
      comparator = function(got, want, ...) {
        if (length(got) != length(want)) {
          get_reporter()$add_message("❌ Je hebt niet het juiste aantal antwoorden gegeven. Verwacht: 10 getallen.", type = "error")
          return(FALSE)
        }
        correct <- all(abs(got - want) < 0.01)
        if (correct) {
          get_reporter()$add_message("✅ Goed gedaan! Alle antwoorden zijn correct afgerond op twee decimalen.", type = "success")
        } else {
          get_reporter()$add_message("❌ Eén of meer antwoorden zijn niet correct afgerond. Controleer je berekeningen en afrondingen.", type = "error")
        }
        correct
      }
    )
  })
})

