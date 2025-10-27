context({
  testcase(
    " ",
    {
      testEqual(
        "",
        function(env) as.numeric(env$evaluationResult),
        2,  # Correct answer: Visuele dataverkenning is essentieel voor betrouwbare analyse
        comparator = function(generated, expected, ...) {
          feedbacks <- list(
            "1" = "❌ **Fout.** Deze vier datasets tonen krachtig aan dat alleen **correlatiecoëfficiënten** diep **misleidend** kunnen zijn. Alle vier studies delen dezelfde identieke correlatie (**r = 0,82**), maar ze vertegenwoordigen **fundamenteel verschillende relaties**: Studie A toont een juiste **lineaire relatie**, Studie B onthult een **gebogen (niet-lineair) patroon**, Studie C bevat een **invloedrijke uitschieter** die de correlatie vertekent, en Studie D toont een **kunstmatige associatie** door één extreme datapunt. In onderzoek zou het vertrouwen op alleen correlatiecoëfficiënten leiden tot totaal **verkeerde interpretaties** van de onderliggende relaties.",
            
            "2" = "✅ **Juist!** Deze demonstratie toont waarom onderzoekers hun **gegevens altijd moeten plotten** voordat ze conclusies trekken. Alleen door de **spreidingsdiagrammen** te bekijken kunt u onderscheiden tussen een echte **lineaire relatie**, **niet-lineaire patronen**, **invloedrijke uitschieters** en **kunstmatige associaties**. In onderzoek kan dit het verschil betekenen tussen het identificeren van een echte trend (zoals de relatie tussen **werkloosheid** en **eigendomscriminaliteit**) versus het verkeerd interpreteren van **gegevensartefacten**. **Visuele inspectie** helpt onderzoekers de **juiste analysemethode** te kiezen en **potentiële problemen** met hun data te identificeren.",
            
            "3" = "❌ **Fout.** Dit is precies de **mythe** die deze demonstratie ontkracht. Hoewel **correlatiecoëfficiënten** en andere samenvattingen **waardevolle informatie** bieden, kunnen ze **identiek** zijn voor **fundamenteel verschillende datapatronen**. Zonder **visuele inspectie** kunt u een **gebogen relatie** missen die een ander type analyse vereist, een **uitschieter** negeren die uw resultaten vertekent, of een **hefboompunt** over het hoofd zien dat een **schijnbare correlatie** creëert. In criminologie kunnen dergelijke missers leiden tot **verkeerde beleidsaanbevelingen**.",
            
            "4" = "❌ **Fout.** Dit **misverstand** ligt aan de basis van waarom deze demonstratie zo'n krachtig **onderwijsinstrument** is. Dezelfde correlatie kan ontstaan uit **volkomen verschillende onderliggende patronen**. In onderzoek zou dit betekenen dat verschillende mechanismen (**lineaire trends**, **drempeleffecten**, **invloedrijke casussen**, **meetartefacten**) allemaal dezelfde **samengevatte correlatie** kunnen produceren, maar totaal verschillende **beleidsimplicaties** hebben. Daarom is het cruciaal om altijd de **ruwe data** te visualiseren voordat **interpretaties** worden gemaakt."
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