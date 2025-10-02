# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

context({
  testcase("Afrondingsregels - Rond de gegeven getallen af op twee decimalen", {
    testEqual(
      "{6.98; 0.92; 10.66; 3.88; 87.00; 0.56; 55.25; 0.66; 7.52; 20.95}",
      function(env) {
        # Get student's text output
        result <- trimws(env$evaluationResult)
        
        # Replace any placeholder text with empty strings
        result <- gsub("antwoord a:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord b:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord c:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord d:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord e:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord f:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord g:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord h:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord i:", "", result, fixed = TRUE, ignore.case = TRUE)
        result <- gsub("antwoord j:", "", result, fixed = TRUE, ignore.case = TRUE)
        
        # Split by any common separator (newlines, commas, semicolons)
        lines <- unlist(strsplit(result, "[\n\r\t ,;]+"))
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

