context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        1,  # Correct answer: Ongeldig - correlatie bewijst geen oorzakelijk verband
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "✅ Juist! Verstorende factoren zoals sociaaleconomische status kunnen zowel programmaanwezigheid als misdaadcijfers beïnvloeden. Dit is een klassiek voorbeeld van potentiële verstoring in criminologisch onderzoek. Rijkere buurten hebben vaak zowel meer middelen om waakprogramma's op te zetten ALS lagere basislijn misdaadcijfers. Andere mogelijke verstorende factoren zijn: bevolkingsdichtheid, residentiële stabiliteit, politieaanwezigheid, of architecturale kenmerken. Zonder controle voor deze variabelen met methoden zoals meervoudige regressie of propensity score matching, kunnen we misdaadvermindering niet toeschrijven aan de waakprogramma's. Bovendien zou de richting van causaliteit omgekeerd kunnen zijn — buurten met lagere misdaadcijfers hebben misschien meer bewoners bereid om deel te nemen aan waakprogramma's, in plaats van dat de programma's de lagere criminaliteit veroorzaken.",
            
            "2" = "❌ Fout. Correlatie alleen kan causale effectiviteit niet vaststellen. Zelfs een sterke correlatiecoëfficiënt (r = 0,65) vertelt ons alleen dat de variabelen geassocieerd zijn, niet dat de ene de andere veroorzaakt. Bijvoorbeeld, buurten met sterkere gemeenschapscohesie kunnen onafhankelijk zowel meer buurtwacht participatie ALS lagere misdaadcijfers hebben vanwege informele sociale controle. In de criminologie vereisen beleidsaanbevelingen sterker causaal bewijs dan louter correlatie, typisch uit experimentele of quasi-experimentele ontwerpen (zoals gerandomiseerde gecontroleerde trials of regressie discontinuïteit). Het nieuwsartikel maakt een fundamentele fout in statistische interpretatie die zou kunnen leiden tot verkeerd toegewezen misdaadpreventie middelen.",
            
            "3" = "❌ Fout. De correlatiesterkte is niet het hoofdprobleem; causaliteit vs. correlatie wel. In feite zou r = 0,65 over het algemeen als een sterke correlatie worden beschouwd in criminologisch onderzoek. Het fundamentele probleem met de claim van het nieuwsartikel is niet dat de correlatie te zwak is, maar dat correlatie — ongeacht sterkte — geen causaliteit kan vaststellen. Zelfs een perfecte correlatie (r = 1,00) zou niet bewijzen dat buurtwachtprogramma's misdaadvermindering veroorzaken. Evidence-based criminologie vereist onderscheid maken tussen correlatie en causaliteit door middel van geschikte onderzoeksmethodologie, inclusief gerandomiseerde trials, natuurlijke experimenten, instrumentele variabelen, of statistische controles voor potentiële verstorende factoren.",
            
            "4" = "❌ Fout. Steekproefgrootte lost het causaliteitsprobleem niet op. Een grotere steekproef zou statistische power verhogen en meer precieze correlatieschattingen leveren, maar het kan een correlationele bevinding niet transformeren in een causale. De logische denkfout in de claim van het nieuwsartikel — dat correlatie causaliteit impliceert — blijft bestaan ongeacht steekproefgrootte. In criminologisch onderzoek is steekproefgrootte belangrijk voor betrouwbaarheid en generaliseerbaarheid, maar het onderzoeksontwerp bepaalt of causale claims gerechtvaardigd zijn. Zonder geschikte ontwerpkenmerken zoals randomisatie, tijd-volgorde vaststelling, of controle voor verstorende variabelen, kunnen zelfs studies met enorme steekproeven geen causale conclusies ondersteunen over programma-effectiviteit."
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