context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # updated correct answer: option 3
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ Incorrect. This includes C's influence, which is exactly what partial correlation removes.
            "1" = "❌ Fout. Dit houdt het effect van C juist in stand, terwijl een partiële correlatie dat net *controleert*.",
            
            # ❌ Incorrect. This is about explained variance, not about correlation between A and B.
            "2" = "❌ Fout. Dit gaat over verklaarde variantie in A door C, en niet over de samenhang tussen A en B.",
            
            # ✅ Correct! Partial correlation isolates the linear relationship between A and B, *controlling for* C.
            "3" = "✅ Juist! Een partiële correlatie meet de lineaire relatie tussen A en B, nadat het effect van C is verwijderd.",
            
            # ❌ Incorrect. Partial correlation is not about averaging correlations across three variables.
            "4" = "❌ Fout. Dit beschrijft een gemiddelde correlatie, geen partiële correlatie tussen twee variabelen met controle."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})