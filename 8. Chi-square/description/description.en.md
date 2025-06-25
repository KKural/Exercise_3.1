Stel je onderzoekt of er een verband bestaat tussen opleidingsniveau (laag/midden/hoog) en het type misdrijf (geweld/diefstal) in een dataset van 120 misdrijven. 

Je observeert de volgende frequenties:

|                | Geweldsmisdrijven | Diefstal | Totaal |
|----------------|------------------:|--------:|-------:|
| Laag opgeleid  | 25                | 15      | 40     |
| Midden opgeleid| 18                | 22      | 40     |
| Hoog opgeleid  | 12                | 28      | 40     |
| Totaal         | 55                | 65      | 120    |

## Opdracht

Bereken de chi-kwadraat significantie test statistiek (χ²) voor deze gegevens om te bepalen of er een statistisch significant verband bestaat tussen opleidingsniveau en type misdrijf.

Rond je antwoord af op twee decimalen.

## Formule

De chi-kwadraat toetsstatistiek wordt berekend met de volgende formule:

$$\chi^2 = \sum\frac{(O_{ij} - E_{ij})^2}{E_{ij}}$$

Waarbij:
- O_{ij} = geobserveerde frequentie in cel (i,j)
- E_{ij} = verwachte frequentie in cel (i,j) onder de nulhypothese van onafhankelijkheid
- De verwachte frequentie wordt berekend als: E_{ij} = (rijtotaal_i × kolomtotaal_j) / totaal

**Hint:** De chi-kwadraat toets vergelijkt geobserveerde frequenties met verwachte frequenties om te testen of variabelen onafhankelijk zijn. Voor elke cel: bereken eerst de verwachte frequentie E = (rijtotaal × kolomtotaal)/totaal, en dan de chi-kwadraat component (O-E)²/E.

Typ je antwoord als één enkel getal (afgerond op twee decimalen).