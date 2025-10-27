setwd(file.path(getwd(), "description"))
source("description.nl.md")
print(sprintf("Submitted answer: %s", answer))

correct_answer <- 2

if (answer == correct_answer) {
  cat("✓ Uitstekend! Je begrijpt de fundamentele beperking van correlationeel onderzoek.\n\n")
  cat("**Juiste redenering:**\n")
  cat("- Correlationeel onderzoek kan nooit causaliteit bewijzen\n")
  cat("- Sterke correlatie (r = -0,78) toont alleen samenhang\n")
  cat("- Verstorende variabelen kunnen beide factoren beïnvloeden\n")
  cat("- Experimenteel onderzoek is nodig voor causale conclusies\n\n")
  cat("**Methodologische implicatie:**\n")
  cat("Ondanks sterke correlatie en significantie blijft causaliteit onbewezen.\n")
} else if (answer == 1) {
  cat("✗ Onjuist. Sterkte en significantie maken causale conclusies niet geldig.\n\n")
  cat("**Waarom niet:**\n")
  cat("- Correlatie bewijst nooit causaliteit, ongeacht sterkte of significantie\n")
  cat("- p < 0,001 toont alleen dat de correlatie niet op toeval berust\n")
  cat("- Verstorende variabelen kunnen de hele relatie verklaren\n")
  cat("- Sociaal-economische factoren beïnvloeden vaak beide variabelen\n")
} else if (answer == 3) {
  cat("✗ Onjuist. r = -0,78 is een zeer sterke correlatie met grote praktische betekenis.\n\n")
  cat("**Waarom niet:**\n")
  cat("- r = -0,78 verklaart 61% van de variantie (r² = 0,61)\n")
  cat("- Dit is een zeer sterke en praktisch betekenisvolle correlatie\n")
  cat("- Het probleem ligt niet in de sterkte, maar in de causale interpretatie\n")
  cat("- Sterke correlaties kunnen nog steeds door derde variabelen veroorzaakt worden\n")
} else if (answer == 4) {
  cat("✗ Onjuist. Significantie bewijst geen causaliteit.\n\n")
  cat("**Waarom niet:**\n")
  cat("- Statistische significantie toont alleen dat het resultaat niet op toeval berust\n")
  cat("- p < 0,001 betekent zeer lage kans op toevallige correlatie\n")
  cat("- Causaliteit vereist experimentele manipulatie en controle\n")
  cat("- Correlationele studies kunnen nooit causale claims ondersteunen\n")
} else {
  cat("Ongeldige invoer. Voer een getal tussen 1 en 4 in.\n")
}