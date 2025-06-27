context({
  testcase(
    "Evaluatie Onderzoeksopzet",
    {
      testEqual(
        "Beoordeling van de volledigheid van het onderzoeksontwerp",
        function(env) env$evaluationResult,
        "PLACEHOLDER_FOR_MANUAL_REVIEW",  # Deze oefening vereist manuele beoordeling
        comparator = function(generated, expected, ...) {
          # Dit is een sjabloon voor open vragen die manueel beoordeeld worden
          # Automatische scoring is niet van toepassing voor deze creatieve vraag
          
          # Geef feedback over wat een sterk antwoord inhoudt
          feedback <- paste(
            "✅ Je antwoord is ingediend voor beoordeling. Een sterk antwoord bevat:",
            "",
            "1. **Onderzoeksopzet**: Een duidelijk omschreven onderzoeksopzet die causaliteit kan vaststellen",
            "   - Bijvoorbeeld: Quasi-experimenteel ontwerp met difference-in-differences analyse",
            "   - Bijvoorbeeld: Interrupted time-series met niet-equivalente controlegroep",
            "",
            "2. **Steekproefstrategie**: Een goed onderbouwde steekproefaanpak met geschikte vergelijkingsgroepen",
            "   - Moet ingaan op de selectie van buurten en methoden om vergelijkbaarheid te waarborgen",
            "",
            "3. **Belangrijkste variabelen**: Identificatie van afhankelijke, onafhankelijke en controlevariabelen",
            "   - Inclusief operationele definities en meetmethoden",
            "",
            "4. **Statistische methoden**: Passende statistische technieken voor het voorgestelde ontwerp",
            "   - Kan regressiemodellen, tijdreeksanalyse, propensity score matching, enz. omvatten",
            "   - Moet aansluiten bij de datastructuur en onderzoeksvragen",
            "",
            "5. **Validiteitsoverwegingen**: Strategieën om bedreigingen voor interne en externe validiteit aan te pakken",
            "   - Bespreking van confounders en hoe deze worden gecontroleerd",
            "",
            "De docent beoordeelt in hoeverre je ontwerp statistische principes integreert en methodologisch sterk is.",
            sep = "\n"
          )
          
          get_reporter()$add_message(feedback, type = "markdown")
          
          # Altijd TRUE retourneren want dit wordt manueel nagekeken
          return(TRUE)
        }
      )
    }
  )
})
