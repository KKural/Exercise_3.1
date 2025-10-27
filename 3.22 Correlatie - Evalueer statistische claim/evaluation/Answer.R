setwd(file.path(getwd(), "description"))
source("description.nl.md")
print(sprintf("Submitted answer: %s", answer))

correct_answer <- 1

if (answer == correct_answer) {
  cat("✓ Uitstekend! Je begrijpt dat correlatie geen oorzakelijk verband bewijst.\n\n")
  cat("**Juiste redenering:**\n")
  cat("- Correlatie (zelfs sterke r = 0,65) bewijst nooit causaliteit\n")
  cat("- Verstorende variabelen kunnen beide factoren beïnvloeden\n")
  cat("- Sociaal-economische buurtkenmerken kunnen zowel buurtwaakprogramma's als lagere inbraken verklaren\n")
  cat("- Voor causaliteit heb je experimenteel onderzoek nodig\n\n")
  cat("**Methodologische overweging:**\n")
  cat("Statistische claims vereisen kritische evaluatie van onderzoeksontwerp.\n")
} else if (answer == 2) {
  cat("✗ Onjuist. Correlatie bewijst nooit causaliteit, ongeacht de sterkte.\n\n")
  cat("**Waarom niet:**\n")
  cat("- Een sterke correlatie kan veroorzaakt worden door verstorende variabelen\n")
  cat("- Rijk buurten hebben vaak zowel meer waakprogramma's als minder criminaliteit\n")
  cat("- Omgekeerde causaliteit is mogelijk: lagere criminaliteit leidt tot meer participatie\n")
  cat("- Experimenteel bewijs is nodig voor causale conclusies\n")
} else if (answer == 3) {
  cat("✗ Onjuist. r = 0,65 is een sterke correlatie, maar dat is niet het probleem.\n\n")
  cat("**Het werkelijke probleem:**\n")
  cat("- De sterkte van correlatie is niet het issue\n")
  cat("- Het probleem is de causale interpretatie\n")
  cat("- Correlatie bewijst geen oorzakelijk verband, ongeacht de sterkte\n")
  cat("- r = 0,65 verklaart 42% van de variantie (r²), wat substantieel is\n")
} else if (answer == 4) {
  cat("✗ Onjuist. Steekproefgrootte lost het causale probleem niet op.\n\n")
  cat("**Waarom niet:**\n")
  cat("- Steekproefgrootte beïnvloedt statistische power, niet causaliteit\n")
  cat("- Zelfs met miljoen observaties bewijst correlatie geen causaliteit\n")
  cat("- Verstorende variabelen blijven een probleem ongeacht steekproefgrootte\n")
  cat("- Randomisatie en controle zijn nodig voor causale conclusies\n")
} else {
  cat("Ongeldige invoer. Voer een getal tussen 1 en 4 in.\n")
}