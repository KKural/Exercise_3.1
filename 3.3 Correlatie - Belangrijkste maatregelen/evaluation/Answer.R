setwd(file.path(getwd(), "description"))
source("description.nl.md")
print(sprintf("Submitted answer: %s", answer))

correct_answer <- 4

if (answer == correct_answer) {
  cat("✓ Juist! Deze drie geven volledige informatie over de relatie.\n\n")
  cat("**Juiste redenering:**\n")
  cat("- De correlatiecoëfficiënt (r) geeft de sterkte en richting aan (-1 tot +1)\n")
  cat("- R² geeft het verklaarde variantiepercentage aan (r² × 100%)\n")
  cat("- De steekproefomvang (n) geeft betrouwbaarheid aan\n\n")
  cat("**Praktisch voorbeeld:**\n")
  cat("'De zichtbaarheid en wanorde van de politie vertoonden een matige negatieve correlatie (r = -0,45, R² = 0,20, n = 150 buurten), wat aangeeft dat 20% van de variatie in wanorde kan worden verklaard door de aanwezigheid van de politie.' Dit geeft lezers alle informatie die nodig is om de bevinding te evalueren.\n")
} else if (answer == 1) {
  cat("✗ Fout. Helling en snijpunt zijn regressieparameters, geen correlatiematen.\n\n")
  cat("**Waarom niet:**\n")
  cat("- Hoewel regressie en correlatie gerelateerd zijn (helling = r × sy/sx), dienen ze verschillende doelen\n")
  cat("- Correlatie vat de kracht van associatie samen; Regressie biedt voorspellingsvergelijkingen\n")
  cat("- In de criminologie zou je correlatie kunnen rapporteren bij het bestuderen of twee soorten criminaliteit de neiging hebben om samen voor te komen\n")
  cat("- Maar regressie bij het voorspellen van toekomstige misdaadcijfers op basis van demografische factoren\n")
} else if (answer == 2) {
  cat("✗ Fout. Gemiddelden en standaarddeviaties beschrijven individuele variabelen, maar geven niet de relatie tussen twee variabelen weer.\n\n")
  cat("**Waarom onvoldoende:**\n")
  cat("- Je zou identieke gemiddelden en standaarddeviaties kunnen hebben voor werkloosheids- en misdaadcijfers in twee verschillende onderzoeken\n")
  cat("- Maar totaal verschillende correlaties (r = +0,80 vs. r = -0,20)\n")
  cat("- Correlatieanalyse onderzoekt specifiek hoe variabelen samen variëren\n")
  cat("- Dit vereist andere statistieken dan eenvoudige beschrijvende metingen\n")
} else if (answer == 3) {
  cat("✗ Fout. Hoewel r de primaire maatstaf is, levert het rapporteren van alleen r onvolledige informatie op voor onderzoek.\n\n")
  cat("**Waarom onvolledig:**\n")
  cat("- U moet ook weten hoeveel variantie wordt verklaard (R²)\n")
  cat("- En of uw steekproefomvang (n) groot genoeg is om het resultaat te vertrouwen\n")
  cat("- R = 0,40 tussen aanwezigheid van de politie en misdaadvermindering lijkt bijvoorbeeld zinvol\n")
  cat("- Maar als n = 8 steden, is het resultaat onbetrouwbaar\n")
  cat("- Professioneel onderzoek vereist het rapporteren van alle drie de statistieken\n")
} else {
  cat("Ongeldige invoer. Voer een getal tussen 1 en 4 in.\n")
}