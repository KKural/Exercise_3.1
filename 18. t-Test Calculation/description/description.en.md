Een stad implementeert een nieuwe criminaliteitspreventie-interventie. Om de effectiviteit te evalueren, verzamelt een onderzoeker data over het aantal inbraken per maand voor en na de interventie.

## Data

**Voor interventie (groep 1):**
`[15, 18, 22, 19, 21, 17]` (n₁ = 6)

**Na interventie (groep 2):** 
`[12, 10, 14, 11, 9, 13]` (n₂ = 6)

## Opdracht

Bereken de **t-statistiek** voor een onafhankelijke steekproeven t-toets om te bepalen of de interventie significant effectief was. Rond je antwoord af op **twee decimalen**.

## Hypotheses

- H₀: μ₁ = μ₂ (geen verschil in gemiddeld aantal inbraken)
- H₁: μ₁ > μ₂ (interventie vermindert inbraken, eenzijdige toets)

## Formule

**Onafhankelijke steekproeven t-toets:**

$$t = \frac{\bar{x}_1 - \bar{x}_2}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}$$

**Gepoolde standaarddeviatie:**

$$s_p = \sqrt{\frac{(n_1-1)s_1^2 + (n_2-1)s_2^2}{n_1 + n_2 - 2}}$$

## Stappen voor berekening

1. **Bereken de gemiddelden:**
   - x̄₁ en x̄₂

2. **Bereken de standaarddeviaties:**
   - s₁ en s₂ (steekproef-standaarddeviaties)

3. **Bereken de gepoolde standaarddeviatie:**
   - s_p

4. **Bereken de standaardfout:**
   - SE = s_p × √(1/n₁ + 1/n₂)

5. **Bereken de t-statistiek:**
   - t = (x̄₁ - x̄₂) / SE

## Hint

- Gebruik de steekproef-standaarddeviatie (delen door n-1)
- Verwacht een positieve t-waarde (x̄₁ > x̄₂)
- Vrijheidsgraden: df = n₁ + n₂ - 2 = 10

Typ je antwoord als één enkel getal, afgerond op twee decimalen (bijvoorbeeld: 2.34).
