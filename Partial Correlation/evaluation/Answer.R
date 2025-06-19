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
            # âŒ No. This includes Câ€™s influence, which is exactly what partial correlation removes.
            "1" = "❌ Fout. Dit houdt het effect van C juist in stand, terwijl een partiÃ«le correlatie dat net *controleert*.",
            
            # âŒ InJuist. This is about explained variance, not about correlation between A and B.
            "2" = "❌ Fout. Dit gaat over verklaarde variantie in A door C, en niet over de samenhang tussen A en B.",
            
            # âœ… Correct! Partial correlation isolates the linear relationship between A and B, *controlling for* C.
            "3" = "✅ Juist! Een partiÃ«le correlatie meet de lineaire relatie tussen A en B, nadat het effect van C is verwijderd.",
            
            # âŒ Not Juist. Partial correlation is not about averaging correlations across three variables.
            "4" = "❌ Fout. Dit beschrijft een gemiddelde correlatie, geen partiÃ«le correlatie tussen twee variabelen met controle."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # âŒ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})

