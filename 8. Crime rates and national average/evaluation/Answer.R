context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # correct: District X (85) is the outlier compared to national average of 50
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            # ✅ Juist! District X is a statistical outlier based on standard measures.
            "1" = "✅ Juist! District X heeft een cijfer van 85, wat ver boven het nationale gemiddelde van 50 ligt. 

Om te bepalen of een waarde een uitschieter is, kunnen we deze stappen volgen:
1. Bereken het gemiddelde: (50 + 60 + 45 + 85 + ...)/N = 50
2. Bereken de standaarddeviatie: SD = √[(Σ(x - μ)²)/N] ≈ 15
3. Bereken de z-score: z = (waarde - gemiddelde)/SD
   Voor District X: z = (85 - 50)/15 = 2.33

Aangezien z > 1.5, is District X een statistische uitschieter.

Nota: De drempelwaarde van 1.5 is een veelgebruikte standaard in statistiek. Deze waarde betekent dat ongeveer 87% van de data binnen deze grens valt en 13% erbuiten. Waarden met een z-score groter dan 1.5 worden vaak als uitschieters beschouwd omdat ze significant afwijken van het gemiddelde.",
            
            # ❌ Fout. District Y is above average but not enough to be considered an outlier.
            "2" = "❌ Fout. District Y heeft een waarde van 60, wat boven het gemiddelde ligt maar niet genoeg om als uitschieter te worden beschouwd.

Berekening:
1. Gemiddelde = 50
2. Standaarddeviatie = 15
3. z-score voor District Y = (60 - 50)/15 = 0.67

Deze z-score (0.67) is kleiner dan 1.5, dus District Y is geen statistische uitschieter.

De drempelwaarde 1.5 betekent dat waarden binnen 1.5 standaarddeviaties van het gemiddelde als 'normaal' worden beschouwd. Met een z-score van slechts 0.67 valt District Y duidelijk binnen deze normale spreiding.",
            
            # ❌ Fout. District Z is below average but not enough to be an outlier.
            "3" = "❌ Fout. District Z heeft een waarde van 45, wat onder het gemiddelde ligt maar niet ver genoeg om een uitschieter te zijn.

Berekening:
1. Gemiddelde = 50
2. Standaarddeviatie = 15
3. z-score voor District Z = (45 - 50)/15 = -0.33

Met een z-score van -0.33 (absoluut kleiner dan 1.5) is District Z geen uitschieter.

We gebruiken 1.5 als drempelwaarde omdat dit een balans biedt: een lagere waarde zou teveel datapunten als uitschieters identificeren, terwijl een hogere waarde te weinig punten als uitschieters zou aanmerken.",
            
            # ❌ Fout. District W is exactly average, so definitely not an outlier.
            "4" = "❌ Fout. District W heeft exact de gemiddelde waarde (50), dus per definitie is het geen uitschieter.

Berekening:
1. Gemiddelde = 50
2. Standaarddeviatie = 15
3. z-score voor District W = (50 - 50)/15 = 0

Met een z-score van 0 wijkt District W helemaal niet af van het gemiddelde.

Een uitschieter heeft per definitie een waarde die significant afwijkt van het gemiddelde (typisch |z| > 1.5). District W ligt exact op het gemiddelde, wat het tegendeel is van een uitschieter."
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