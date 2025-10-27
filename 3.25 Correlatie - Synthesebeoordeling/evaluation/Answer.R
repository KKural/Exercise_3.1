setwd(file.path(getwd(), "description"))
source("description.nl.md")
print(sprintf("Submitted answer: %s", answer))

correct_answer <- 2

if (answer == correct_answer) {
  cat("✓ Uitstekend! Je geeft een professioneel verantwoorde beoordeling.\n\n")
  cat("**Juiste professionele analyse:**\n")
  cat("- Correlationeel onderzoek kan principieel geen causaliteit bewijzen\n")
  cat("- Verstorende variabelen (economische welvaart, politiek systeem) kunnen beide factoren beïnvloeden\n")
  cat("- Sterke correlatie (r = 0,82) toont samenhang maar geen oorzakelijk verband\n")
  cat("- Experimenteel of quasi-experimenteel ontwerp is nodig voor causale claims\n\n")
  cat("**Professionele aanbeveling:**\n")
  cat("Rapporteer correlatie accuraat zonder causale interpretaties toe te voegen.\n")
} else if (answer == 1) {
  cat("✗ Onjuist. Als consulterend statisticus mag je nooit causale claims uit correlaties ondersteunen.\n\n")
  cat("**Professionele fout:**\n")
  cat("- Statistici hebben ethische verantwoordelijkheid voor accurate interpretaties\n")
  cat("- Correlatie bewijst nooit causaliteit, ongeacht sterkte of significantie\n")
  cat("- Beleidsbeslissingen gebaseerd op foutieve causale claims kunnen schadelijk zijn\n")
  cat("- Verstorende variabelen maken causale interpretatie ongeldig\n")
} else if (answer == 3) {
  cat("✗ Onjuist. Replicatie lost het fundamentele causale probleem niet op.\n\n")
  cat("**Waarom niet:**\n")
  cat("- Replicatie van correlaties bewijst nog steeds geen causaliteit\n")
  cat("- Verstorende variabelen kunnen consistent aanwezig zijn in alle studies\n")
  cat("- Systematische factoren (cultuur, economie) beïnvloeden mogelijk alle landen\n")
  cat("- Experimentele controle blijft noodzakelijk voor causale conclusies\n")
} else if (answer == 4) {
  cat("✗ Onjuist. De steekproefgrootte is niet het hoofdprobleem hier.\n\n")
  cat("**Waarom niet het hoofdissue:**\n")
  cat("- 15 landen kan voldoende zijn voor correlationele analyse op macro-niveau\n")
  cat("- Het primaire probleem is de causale interpretatie, niet de steekproefgrootte\n")
  cat("- r = 0,82 met p < 0,01 suggereert voldoende statistische power\n")
  cat("- Meer landen zou correlatie kunnen bevestigen maar causaliteit niet bewijzen\n")
} else {
  cat("Ongeldige invoer. Voer een getal tussen 1 en 4 in.\n")
}