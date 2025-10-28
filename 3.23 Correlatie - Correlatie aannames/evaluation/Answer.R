context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        3,  # Correct answer: Lineariteit, continue variabelen, normale verdeling, geen extreme uitschieters, en gelijke variantie
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ Fout. Hoewel lineariteit en continue variabelen inderdaad belangrijke veronderstellingen zijn, zijn er meer aannames die gecontroleerd moeten worden. Normaliteit is belangrijk voor de interpretatie van statistische significantie en betrouwbaarheidsintervallen. Extreme uitschieters kunnen Pearson correlatie drastisch beïnvloeden omdat het gebaseerd is op werkelijke waarden (niet rangnummers zoals Spearman). Homoscedasticiteit (gelijke variantie) beïnvloedt de betrouwbaarheid van correlatieschattingen. In criminologisch onderzoek kan het negeren van deze aannames leiden tot verkeerde conclusies - bijvoorbeeld, uitschieters in geweldsdata kunnen de correlatie tussen sociaaleconomische factoren en criminaliteit vertekenen. Een grondige controle van alle veronderstellingen zorgt voor betrouwbare resultaten.",
            
            "2" = "❌ Fout. Normale verdeling is belangrijk maar niet de enige vereiste. Zelfs als beide variabelen perfect normaal verdeeld zijn, kan Pearson correlatie nog steeds misleidend zijn als andere veronderstellingen geschonden worden. Bijvoorbeeld, twee normaal verdeelde variabelen kunnen een niet-lineaire relatie hebben (zoals een U-vormige curve) die Pearson correlatie zal onderschatten. Of er kunnen extreme uitschieters zijn die, hoewel technisch onderdeel van een normale verdeling, onevenredige invloed hebben op de correlatie. In criminologisch onderzoek zijn variabelen zoals inkomen of criminaliteitscijfers vaak scheef verdeeld, maar zelfs wanneer ze genormaliseerd worden door transformaties, moeten nog steeds andere aannames zoals lineariteit en afwezigheid van invloedrijke punten gecontroleerd worden.",
            
            "3" = "✅ Juist! Deze vijf veronderstellingen zijn essentieel voor valide Pearson correlatie interpretatie. Lineariteit is fundamenteel omdat Pearson alleen lineaire relaties meet - gebogen relaties kunnen misleidende correlaties opleveren. Continue variabelen zijn vereist omdat Pearson werkt met werkelijke waarden en afstanden tussen waarden. Normale verdeling is belangrijk voor statistische inferentie (p-waarden, betrouwbaarheidsintervallen). Extreme uitschieters kunnen correlaties dramatisch beïnvloeden omdat Pearson gevoelig is voor extreme waarden. Homoscedasticiteit (gelijke variantie) zorgt voor stabiele correlatieschattingen. Zoals getoond in de visualisatie, leiden schendingen van deze aannames tot misleidende of onbetrouwbare correlaties. In criminologisch onderzoek helpt het controleren van deze veronderstellingen onderzoekers te bepalen of Pearson geschikt is of dat alternatieve methoden (zoals Spearman) beter zijn.",
            
            "4" = "❌ Fout. Deze zijn geen statistische veronderstellingen van Pearson correlatie. Hoewel grotere steekproeven (N ≥ 30) statistisch wenselijk zijn voor betrouwbaardere schattingen, is dit geen formele veronderstelling van de correlatiemethode zelf. Pearson correlatie kan berekend worden met kleinere steekproeven, hoewel de resultaten minder stabiel zijn. Positieve waarden zijn ook niet vereist - correlatie werkt perfect met negatieve waarden, gemengde positieve/negatieve waarden, of zelfs gecentreerde data (met gemiddelde nul). In criminologisch onderzoek hebben variabelen vaak negatieve waarden (bijvoorbeeld, gecentreerde scores, temperatuurafwijkingen, of veranderingsscores). De werkelijke veronderstellingen gaan over de vorm van relaties en dataverdelingen, niet over arbitraire numerieke eigenschappen zoals positiviteit."
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