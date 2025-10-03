# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

## Verwachte afgeronde getallen (weergegeven als 6,98 maar opgeslagen als 6.98)
a = 6.98
b = 0.92
c = 10.66
d = 3.88
e = 87.00
f = 0.56
g = 55.25
h = 0.66
i = 7.52
j = 20.95

context({
  testcase(" ", {
    testEqual(
      " ",
      function(env) {
        # Check if the variable exists
        tryCatch({
          value <- env$a
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `a` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `a` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 6.98) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `a`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `a` moet 6,98 zijn (6,978 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `a` is correct afgerond.",
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
          value <- env$b
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `b` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `b` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 0.92) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `b`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `b` moet 0,92 zijn (0,923 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `b` is correct afgerond.",
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
          value <- env$c
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `c` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `c` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 10.66) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `c`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `c` moet 10,66 zijn (10,657 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `c` is correct afgerond.",
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
          value <- env$d
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `d` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `d` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 3.88) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `d`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `d` moet 3,88 zijn (3,878 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `d` is correct afgerond.",
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
          value <- env$e
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `e` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `e` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 87.00) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `e`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `e` moet 87,00 zijn (87,001 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `e` is correct afgerond.",
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
          value <- env$f
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `f` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `f` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 0.56) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `f`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `f` moet 0,56 zijn (0,559 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `f` is correct afgerond.",
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
          value <- env$g
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `g` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `g` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 55.25) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `g`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `g` moet 55,25 zijn (55,248 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `g` is correct afgerond.",
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
          value <- env$h
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `h` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `h` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 0.66) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `h`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `h` moet 0,66 zijn (0,664 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `h` is correct afgerond.",
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
          value <- env$i
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `i` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `i` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 7.52) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `i`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `i` moet 7,52 zijn (7,519 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `i` is correct afgerond.",
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
          value <- env$j
          if (is.null(value)) {
            get_reporter()$add_message(
              "❌ De variabele `j` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Check if it's a number
          if (!is.numeric(value)) {
            get_reporter()$add_message(
              "❌ `j` moet een getal zijn.",
              type = "error"
            )
            return(FALSE)
          }
          
          # Compare with expected value
          return(abs(value - 20.95) < 0.01)
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `j`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ `j` moet 20,95 zijn (20,954 afgerond op twee decimalen).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ `j` is correct afgerond.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
  })
})

