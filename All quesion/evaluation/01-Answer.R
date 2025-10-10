# bloom_level: Remember & Understand
# scaffolding_level: Full support
# primm_phase: Run

## Verwachte antwoorden voor basisbegrippen statistiek
expected_vraag1 = "C"  # Leeftijd is interval/ratio
expected_vraag2 = "B"  # Ernst is ordinaal
expected_vraag3 = "A"  # Geslacht is nominaal
expected_vraag4 = "B"  # Definitie populatie/steekproef
expected_vraag5 = "B"  # Mediaan voor ordinale data
expected_vraag6 = "B"  # Doel beschrijvende statistiek
expected_vraag7 = "C"  # Rekenkundige bewerkingen bij interval/ratio
expected_vraag8 = "B"  # Representativiteit van steekproef

context({
  testcase(" ", {
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag1", envir = env)) {
            value <- get("vraag1", envir = env)
            if (!is.character(value)) {
              get_reporter()$add_message(
                "❌ `vraag1` moet een letter zijn (A, B, of C).",
                type = "error"
              )
              return(FALSE)
            }
            return(toupper(value) == expected_vraag1)
          } else {
            get_reporter()$add_message(
              "❌ De variabele `vraag1` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
        }, error = function(e) {
          get_reporter()$add_message(
            "❌ Er is een fout opgetreden bij het controleren van `vraag1`.",
            type = "error"
          )
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 1: Leeftijd is een interval/ratio variabele (antwoord C).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 1: Correct! Leeftijd is inderdaad interval/ratio.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag2", envir = env)) {
            value <- get("vraag2", envir = env)
            return(toupper(value) == expected_vraag2)
          } else {
            get_reporter()$add_message(
              "❌ De variabele `vraag2` is niet gedefinieerd.",
              type = "error"
            )
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 2: Ernst van misdrijf (licht, matig, zwaar) is ordinaal (antwoord B).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 2: Correct! Ernst heeft een natuurlijke rangorde.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag3", envir = env)) {
            value <- get("vraag3", envir = env)
            return(toupper(value) == expected_vraag3)
          } else {
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 3: Geslacht is een nominale variabele (antwoord A).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 3: Correct! Geslacht heeft geen natuurlijke rangorde.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag4", envir = env)) {
            value <- get("vraag4", envir = env)
            return(toupper(value) == expected_vraag4)
          } else {
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 4: Populatie = alle eenheden, Steekproef = deel van populatie (antwoord B).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 4: Correct! Je begrijpt het verschil tussen populatie en steekproef.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag5", envir = env)) {
            value <- get("vraag5", envir = env)
            return(toupper(value) == expected_vraag5)
          } else {
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 5: Voor ordinale data is de mediaan de beste maat voor centrale tendentie (antwoord B).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 5: Correct! Mediaan is geschikt voor ordinale data.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag6", envir = env)) {
            value <- get("vraag6", envir = env)
            return(toupper(value) == expected_vraag6)
          } else {
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 6: Beschrijvende statistiek samenvat en beschrijft data (antwoord B).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 6: Correct! Beschrijvende statistiek organiseert en samenvat gegevens.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag7", envir = env)) {
            value <- get("vraag7", envir = env)
            return(toupper(value) == expected_vraag7)
          } else {
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 7: Alleen bij interval/ratio schalen kun je zinvol rekenen (antwoord C).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 7: Correct! Interval/ratio data ondersteunt alle rekenkundige bewerkingen.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
    
    testEqual(
      " ",
      function(env) {
        tryCatch({
          if (exists("vraag8", envir = env)) {
            value <- get("vraag8", envir = env)
            return(toupper(value) == expected_vraag8)
          } else {
            return(FALSE)
          }
        }, error = function(e) {
          return(FALSE)
        })
      },
      TRUE,
      comparator = function(got, want, ...) {
        if (!got) {
          get_reporter()$add_message(
            "❌ Vraag 8: Een goede steekproef is representatief voor de populatie (antwoord B).",
            type = "error"
          )
        } else {
          get_reporter()$add_message(
            "✅ Vraag 8: Correct! Representativiteit is cruciaal voor goede steekproeven.",
            type = "success"
          )
        }
        return(got == want)
      }
    )
  })
})