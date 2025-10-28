context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: r blijft precies hetzelfde
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. De correlatiecoëfficiënt is een gestandaardiseerde maat en dus schaalonafhankelijk. Dit is een cruciale eigenschap voor onderzoek waarbij variabelen vaak verschillende schalen gebruiken. De correlatie tussen ‘jaren onderwijs’ en ‘arrestaties per 1.000 inwoners’ zou bijvoorbeeld hetzelfde zijn als de correlatie tussen ‘jaren onderwijs’ en ‘arrestaties per 100.000 inwoners’. De schaalverandering verandert niets aan de onderliggende relatiesterkte. Als veranderende eenheden de correlatie zouden beïnvloeden, zou vergelijkend onderzoek in landen met verschillende meetsystemen onmogelijk zijn.",
            
            "2" = "❌ Fout. Nogmaals, correlatie is schaalonafhankelijk.. Ofje nu de reactietijd van patrouillewagens meet in seconden, minuten of uren, de correlatie met de opruimingspercentages van misdrijven blijft identiek. Deze eigenschap maakt correlatie bijzonder waardevol voor internationale criminologische vergelijkingen - onderzoekers kunnen gegevens gebruiken die in verschillende eenheden zijn gemeten zonder wiskundige aanpassingen. De relatiesterkte tussen twee variabelen is onafhankelijk van hoe die variabelen worden geschaald.",
            
            "3" = "✅ Juist! . De correlatiecoëfficiënt is een gestandaardiseerde maat en dus schaalonafhankelijk. In de criminologie betekent dit dat je correlaties kunt vergelijken tussen onderzoeken die verschillende meetschalen gebruiken. Studies die bijvoorbeeld misdaadcijfers per hoofd van de bevolking versus per vierkante kilometer meten, kunnen nog steeds vergelijkbare correlatiecoëfficiënten hebben met demografische factoren. ",
            
            "4" = "❌ Fout. Veranderingen in eenheden kunnen de richting van een relatie niet omdraaien. Als een verhoogde aanwezigheid van de politie gepaard gaat met een verminderde criminaliteit (negatieve correlatie), blijft de richting van de samenhang hetzelfde, of je nu de aanwezigheid van agenten per blok, per vierkante kilometer of per 1.000 inwoners meet. Alleen de schaal verandert, niet het fundamentele patroon. "
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