context({
  testcase(" ", {
    testEqual(
      "",
      function(env) {
        result <- trimws(env$evaluationResult)
        # Split by newlines and various separators, convert commas to periods
        numbers <- as.numeric(unlist(strsplit(gsub(",", ".", result), "[\n\r\t ,;]+")))
        # Remove any NA values
        numbers <- numbers[!is.na(numbers)]
        return(numbers)
      },
      c(6.98, 0.92, 10.66, 3.88, 87.00, 0.56, 55.25, 0.66, 7.52, 20.95),
      comparator = function(got, want, ...) {
        if (length(got) != length(want)) {
          get_reporter()$add_message(paste("❌ Je hebt", length(got), "antwoorden gegeven, maar er worden", length(want), "verwacht."), type = "error")
          return(FALSE)
        }
        correct <- all(abs(got - want) < 0.01)
        if (correct) {
          get_reporter()$add_message("✅ Goed gedaan! Alle antwoorden zijn correct afgerond op twee decimalen.", type = "success")
        } else {
          get_reporter()$add_message("❌ Eén of meer antwoorden zijn niet correct afgerond. Controleer je berekeningen en afrondingen.", type = "error")
        }
        return(correct)
      }
    )
  })
})

