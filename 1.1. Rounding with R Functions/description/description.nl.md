# Afronden van criminologische data met R-functies

## Situatie

Je hebt een dataset ontvangen van een criminologisch onderzoek naar **aantal misdrijven per 1000 inwoners** in de laatste 10 maanden. De data bevat precisie tot drie decimalen, maar voor rapportage moeten alle waarden afgerond worden tot **twee decimalen**.

Dit zijn dezelfde getallen als in de vorige oefening, maar nu gaan we ze efficiënter afronden met R-functies.

## Opdracht

Je hebt de volgende vector met criminaliteitscijfers (aantal misdrijven per 1000 inwoners) voor de laatste 10 maanden:

```r
criminaliteit <- c(6.978, 0.923, 10.657, 3.878, 87.001, 0.559, 55.248, 0.664, 7.519, 20.954)
```

Deze waarden komen overeen met de maandelijkse cijfers die je handmatig afrondde:
- Maand 1: 6.978 → moet worden 6.98
- Maand 2: 0.923 → moet worden 0.92  
- Maand 3: 10.657 → moet worden 10.66
- Maand 4: 3.878 → moet worden 3.88
- Maand 5: 87.001 → moet worden 87.00
- Maand 6: 0.559 → moet worden 0.56
- Maand 7: 55.248 → moet worden 55.25
- Maand 8: 0.664 → moet worden 0.66
- Maand 9: 7.519 → moet worden 7.52
- Maand 10: 20.954 → moet worden 20.95

Gebruik de `round()` functie om deze vector af te ronden op **twee decimalen** en sla het resultaat op in een variabele genaamd `afgeronde_criminaliteit`.

## De round() functie in R

In R kun je de `round()` functie gebruiken om getallen of hele vectoren automatisch af te ronden:

```r
round(getal_of_vector, aantal_decimalen)
```

**Voorbeelden:**
- `round(6.456, 2)` → **6.46**
- `round(c(6.456, 0.123), 2)` → **c(6.46, 0.12)**

## Opdracht uitwerking

```r
# Gegeven data - criminaliteitscijfers per maand (per 1000 inwoners)
criminaliteit <- c(6.978, 0.923, 10.657, 3.878, 87.001, 0.559, 55.248, 0.664, 7.519, 20.954)

# Rond af op 2 decimalen
afgeronde_criminaliteit <- round(criminaliteit, 2)

# Bekijk het resultaat
print(afgeronde_criminaliteit)
```

**Let op:** 
- R gebruikt "banker's rounding" voor .5 getallen (rondt naar even getal)
- De `round()` functie werkt op hele vectoren tegelijk
- Voor rapportage zijn twee decimalen voldoende nauwkeurig
- Je kunt zowel `<-` als `=` gebruiken voor het toewijzen van waarden