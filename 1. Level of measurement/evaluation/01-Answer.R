# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

## Verwachte afgeronde getallen
antwoord_a <- 6.98
antwoord_b <- 0.92
antwoord_c <- 10.66
antwoord_d <- 3.88
antwoord_e <- 87.00
antwoord_f <- 0.56
antwoord_g <- 55.25
antwoord_h <- 0.66
antwoord_i <- 7.52
antwoord_j <- 20.95

context({
  testcase(" ", {
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_a
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_a` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_a` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 6.98) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_a`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_a` moet 6,98 zijn (6,978 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_a` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_b
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_b` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_b` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 0.92) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_b`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_b` moet 0,92 zijn (0,923 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_b` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_c
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_c` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_c` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 10.66) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_c`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_c` moet 10,66 zijn (10,657 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_c` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_d
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_d` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_d` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 3.88) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_d`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_d` moet 3,88 zijn (3,878 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_d` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_e
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_e` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_e` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 87.00) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_e`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_e` moet 87,00 zijn (87,001 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_e` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_f
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_f` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_f` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 0.56) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_f`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_f` moet 0,56 zijn (0,559 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_f` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_g
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_g` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_g` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 55.25) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_g`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_g` moet 55,25 zijn (55,248 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_g` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_h
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_h` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_h` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 0.66) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_h`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_h` moet 0,66 zijn (0,664 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_h` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_i
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_i` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_i` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 7.52) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_i`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_i` moet 7,52 zijn (7,519 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_i` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$antwoord_j
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `antwoord_j` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `antwoord_j` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 20.95) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `antwoord_j`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `antwoord_j` moet 20,95 zijn (20,954 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `antwoord_j` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
  })
})

