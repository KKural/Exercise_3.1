setwd(file.path(getwd(), "description"))
source("description.nl.md")
print(sprintf("Submitted answer: %s", answer))

correct_answer <- 3

if (answer == correct_answer) {
  cat("✓ Uitstekend! Deze vijf veronderstellingen zijn essentieel voor valide Pearson correlatie interpretatie.\n\n")
  cat("**Juiste redenering:**\n")
  cat("- **Lineariteit** is fundamenteel omdat Pearson alleen lineaire relaties meet\n")
  cat("- **Continue variabelen** zijn vereist omdat Pearson werkt met werkelijke waarden\n")
  cat("- **Normale verdeling** is belangrijk voor statistische inferentie (p-waarden, betrouwbaarheidsintervallen)\n")
  cat("- **Geen extreme uitschieters** omdat Pearson gevoelig is voor extreme waarden\n")
  cat("- **Homoscedasticiteit** (gelijke variantie) zorgt voor stabiele correlatieschattingen\n\n")
  cat("**Praktische toepassing:**\n")
  cat("Het controleren van deze veronderstellingen helpt onderzoekers bepalen of Pearson geschikt is of dat alternatieve methoden (zoals Spearman) beter zijn.\n")
} else if (answer == 1) {
  cat("✗ Onjuist. Hoewel lineariteit en continue variabelen inderdaad belangrijke veronderstellingen zijn, zijn er meer aannames die gecontroleerd moeten worden.\n\n")
  cat("**Waarom onvolledig:**\n")
  cat("- Normaliteit is belangrijk voor de interpretatie van statistische significantie en betrouwbaarheidsintervallen\n")
  cat("- Extreme uitschieters kunnen Pearson correlatie drastisch beïnvloeden\n")
  cat("- Homoscedasticiteit (gelijke variantie) beïnvloedt de betrouwbaarheid van correlatieschattingen\n")
  cat("- In criminologisch onderzoek kan het negeren van deze aannames leiden tot verkeerde conclusies\n")
} else if (answer == 2) {
  cat("✗ Onjuist. Normale verdeling is belangrijk maar niet de enige vereiste.\n\n")
  cat("**Waarom onvolledig:**\n")
  cat("- Zelfs als beide variabelen perfect normaal verdeeld zijn, kan Pearson correlatie nog steeds misleidend zijn\n")
  cat("- Twee normaal verdeelde variabelen kunnen een niet-lineaire relatie hebben\n")
  cat("- Extreme uitschieters kunnen onevenredige invloed hebben op de correlatie\n")
  cat("- Andere aannames zoals lineariteit en afwezigheid van invloedrijke punten moeten ook gecontroleerd worden\n")
} else if (answer == 4) {
  cat("✗ Onjuist. Deze zijn geen statistische veronderstellingen van Pearson correlatie.\n\n")
  cat("**Waarom niet relevant:**\n")
  cat("- Hoewel grotere steekproeven (N ≥ 30) statistisch wenselijk zijn, is dit geen formele veronderstelling\n")
  cat("- Pearson correlatie kan berekend worden met kleinere steekproeven\n")
  cat("- Positieve waarden zijn ook niet vereist - correlatie werkt met negatieve waarden\n")
  cat("- De werkelijke veronderstellingen gaan over de vorm van relaties en dataverdelingen\n")
} else {
  cat("Ongeldige invoer. Voer een getal tussen 1 en 4 in.\n")
}