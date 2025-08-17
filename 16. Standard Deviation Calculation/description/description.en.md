Een politieanalyst heeft de volgende dataset met het aantal geweldsmisdrijven per week in een district over 8 weken geobserveerd:

**Dataset:** `[12, 15, 18, 22, 25, 28, 32, 35]`

## Opdracht

Bereken de **standaarddeviatie** van deze dataset stap voor stap. Rond je eindantwoord af op **twee decimalen**.

## Stappen voor berekening

1. **Bereken het gemiddelde (μ):**
   μ = (Σx) / n

2. **Bereken de afwijkingen van het gemiddelde:**
   Voor elke waarde: (x - μ)

3. **Kwadrateer de afwijkingen:**
   Voor elke waarde: (x - μ)²

4. **Bereken de variantie (σ²):**
   σ² = Σ(x - μ)² / n

5. **Bereken de standaarddeviatie (σ):**
   σ = √(σ²)

## Formules

**Populatie standaarddeviatie:**
$$\sigma = \sqrt{\frac{\sum_{i=1}^{n}(x_i - \mu)^2}{n}}$$

**Variantie:**
$$\sigma^2 = \frac{\sum_{i=1}^{n}(x_i - \mu)^2}{n}$$

## Hint

- Bereken eerst het gemiddelde: (12+15+18+22+25+28+32+35)/8
- Gebruik dit gemiddelde om de afwijkingen te berekenen
- Kwadrateer alle afwijkingen en tel ze op
- Deel door het aantal observaties (n=8)
- Neem de wortel van het resultaat

**Belangrijk:** We gebruiken hier de populatie-formule (delen door n), niet de steekproef-formule (delen door n-1).

Typ je antwoord als één enkel getal, afgerond op twee decimalen (bijvoorbeeld: 8.54).
