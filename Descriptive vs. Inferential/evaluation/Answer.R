context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # the correct choice: Descriptive statistics summarize past crime data and characteristics
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ❌ InJuist. This refers to inferential or predictive statistics, not descriptive statistics.
            "1" = "❌ Fout. Dit gaat over inferentiële of voorspellende statistiek, niet over beschrijvende statistiek.",
            
            # ✅ Juist! Descriptive statistics aim to summarize past crime data and their characteristics clearly.
            "2" = "✅ Juist! Beschrijvende statistiek heeft als doel het aantal misdrijven en hun kenmerken uit het verleden samen te vatten. [Learn more about Descriptive and Inferential statisitics interpretation](https://www.simplilearn.com/difference-between-descriptive-inferential-statistics-article)",
            
            # ❌ No. Hypothesis testing is part of inferential statistics, not descriptive.
            "3" = "❌ Fout. Het toetsen van hypotheses hoort bij inferentiële statistiek, niet bij beschrijvende statistiek.",
            
            # ❌ Not Juist. Causal modeling involves complex statistical inference, not mere description.
            "4" = "❌ Fout. Het modelleren van causale effecten valt onder geavanceerde inferentiële statistiek, niet onder beschrijving."
          )
          
          key <- as.character(generated)
          msg <- feedbacks[[key]] %||% "❌ Geef een getal tussen 1 en 4 in."  # ❌ Please enter a number between 1 and 4.
          
          get_reporter()$add_message(msg, type = "markdown")
          
          generated == expected
        }
      )
    }
  )
})