# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

## Verwachte afgeronde criminologische data - criminaliteitscijfers per maand
criminaliteit <- c(6.978, 0.923, 10.657, 3.878, 87.001, 0.559, 55.248, 0.664, 7.519, 20.954)
expected_afgeronde_criminaliteit <- round(criminaliteit, 2)

context({
  testcase(" ", {
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$afgeronde_criminaliteit
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `afgeronde_criminaliteit` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a vector
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `afgeronde_criminaliteit` moet een numerieke vector zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it has 10 elements
          if (length(value) != 10) {
            get_reporter()$add_message(
              paste("❌ `afgeronde_criminaliteit` moet 10 elementen hebben, maar heeft", length(value), "elementen."),
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected values (with tolerance)
          differences <- abs(value - expected_afgeronde_criminaliteit)
          if (all(differences < 0.01)) {
            return(TRUE)
          } else {
            # Find which elements are wrong
            wrong_indices <- which(differences >= 0.01)
            get_reporter()$add_message(
              paste("❌ Element(en)", paste(wrong_indices, collapse = ", "), "zijn niet correct afgerond."),
              type = "error"
            )
            return(FALSE)
          }
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `afgeronde_criminaliteit`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `afgeronde_criminaliteit` moet round(criminaliteit, 2) zijn.",
            type = "error"
          )
          get_reporter()$add_message(
            paste("💡 Verwacht resultaat:", paste(expected_afgeronde_criminaliteit, collapse = ", ")),
            type = "info"
          )
        } else {
          get_reporter()$add_message(
            "✅ `afgeronde_criminaliteit` is correct afgerond! Alle criminaliteitscijfers zijn nu netjes op 2 decimalen.",
            type = "success"
          )
          get_reporter()$add_message(
            paste("📊 Jouw resultaat:", paste(env$afgeronde_criminaliteit, collapse = ", ")),
            type = "success"
          )
        }
        return(got == want)
      }
    )
  })
})