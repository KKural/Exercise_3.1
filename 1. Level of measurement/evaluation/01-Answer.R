# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

context({
  testcase("Afrondingsregels - Rond de gegeven getallen af op twee decimalen", {
    testEqual(
      "",
      function(env) {
        # Get the student's output
        result <- trimws(env$evaluationResult)
        
        # Split by newlines and clean up
        lines <- unlist(strsplit(result, "\n"))
        lines <- trimws(lines)
        lines <- lines[lines != ""]  # Remove empty lines
        
        # Convert commas to periods and parse as numbers
        numbers <- as.numeric(gsub(",", ".", lines))
        
        # Remove any NA values
        numbers <- numbers[!is.na(numbers)]
        
        return(numbers)
      },
      c(6.98, 0.92, 10.66, 3.88, 87.00, 0.56, 55.25, 0.66, 7.52, 20.95),
      comparator = function(got, want, ...) {
        if (length(got) != length(want)) {
          get_reporter()$add_message(
            paste("❌ Je hebt", length(got), "antwoorden gegeven, maar er worden", length(want), "verwacht."),
            type = "error"
          )
          return(FALSE)
        }
        
        # Check if all answers are correct (within 0.01 tolerance)
        correct <- all(abs(got - want) < 0.01)
        
        if (correct) {
          get_reporter()$add_message(
            "✅ Goed gedaan! Alle antwoorden zijn correct afgerond op twee decimalen.",
            type = "success"
          )
        } else {
          # Show which answers are wrong
          wrong_indices <- which(abs(got - want) >= 0.01)
          for (i in wrong_indices) {
            letter <- letters[i]
            get_reporter()$add_message(
              paste("❌ Antwoord", letter, "is incorrect. Je hebt", got[i], "maar het moet", want[i], "zijn."),
              type = "error"
            )
          }
        }
        
        return(correct)
      }
    )
  })
})

