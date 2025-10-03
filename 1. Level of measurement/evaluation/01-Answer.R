# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

context({
  testcase("Afrondingsregels - Rond de gegeven getallen af op twee decimalen", {
    testEqual(
      "",
      function(env) {
        # Get student's text output
        result <- env$evaluationResult
        
        # Make sure we're working with a single string
        if (is.list(result) || is.vector(result) && !is.character(result)) {
          result <- paste(result, collapse = "\n")
        }
        
        # Clean up the text
        result <- trimws(result)
        
        # Remove any brackets, braces, or parentheses
        result <- gsub("[\\[\\]{}()]", "", result)
        
        # Replace any labels with empty strings
        for (letter in letters[1:10]) {
          pattern <- paste0(letter, "[\\)\\.]?\\s*")
          result <- gsub(pattern, "", result, ignore.case = TRUE)
        }
        
        # Split by any common separator (newlines, commas, semicolons, spaces)
        lines <- unlist(strsplit(result, "[\n\r\t ,;]+"))
        
        # Filter out empty strings
        lines <- lines[lines != ""]
        
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
        correct_answers <- abs(got - want) < 0.01
        all_correct <- all(correct_answers)
        
        if (all_correct) {
          get_reporter()$add_message(
            "✅ Goed gedaan! Alle antwoorden zijn correct afgerond op twee decimalen.",
            type = "success"
          )
        } else {
          # Get the letters for the questions (a through j)
          letters_q <- letters[1:10]
          
          # Show which answers are wrong
          wrong_indices <- which(!correct_answers)
          for (i in wrong_indices) {
            letter <- letters_q[i]
            get_reporter()$add_message(
              paste("❌ Antwoord", letter, "is incorrect. Je hebt", got[i], "maar het moet", want[i], "zijn."),
              type = "error"
            )
          }
        }
        
        return(all_correct)
      }
    )
  })
})

