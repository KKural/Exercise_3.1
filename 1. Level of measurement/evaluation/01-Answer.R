context({
  testcase("Afrondingsregels - Rond de gegeven getallen af op twee decimalen", {
    testEqual(
      "6.98
0.92
10.66
3.88
87.00
0.56
55.25
0.66
7.52
20.95",
      function(env) {
        result <- trimws(env$evaluationResult)
        numbers <- as.numeric(unlist(strsplit(gsub(",", ".", result), "[\n\r\t ,;]+")))
        numbers <- numbers[!is.na(numbers)]
        return(numbers)
      },
      c(6.98, 0.92, 10.66, 3.88, 87.00, 0.56, 55.25, 0.66, 7.52, 20.95),
      comparator = function(got, want, ...) {
        if (length(got) != length(want)) {
          get_reporter()$add_message(paste("Je hebt", length(got), "antwoorden gegeven, maar er worden", length(want), "verwacht."), type = "error")
          return(FALSE)
        }
        correct <- all(abs(got - want) < 0.01)
        if (correct) {
          get_reporter()$add_message("Goed gedaan! Alle antwoorden zijn correct afgerond.", type = "success")
        } else {
          get_reporter()$add_message("Een of meer antwoorden zijn niet correct afgerond.", type = "error")
        }
        return(correct)
      }
    )
  })
})

