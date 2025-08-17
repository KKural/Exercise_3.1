Een onderzoeker neemt een steekproef van 9 districten om het gemiddelde aantal autodiefstallen per maand te schatten. De volgende data wordt verzameld:

**Dataset:** `[24, 28, 32, 26, 30, 22, 35, 29, 27]` (n = 9)

## Opdracht

Bereken het **95% betrouwbaarheidsinterval** voor het populatiegemiddelde aantal autodiefstallen per maand. Rond beide grenzen af op **twee decimalen**.

Voer je antwoord in als: **ondergrens,bovengrens** (bijvoorbeeld: 25.67,31.23)

## Formule

**95% Betrouwbaarheidsinterval:**

$$CI = \bar{x} \pm t_{\alpha/2,df} \times \frac{s}{\sqrt{n}}$$

Waarbij:
- x̄ = steekproefgemiddelde
- t₀.₀₂₅,₈ = kritieke t-waarde (95% CI, df = 8) ≈ 2.306
- s = steekproef-standaarddeviatie
- n = steekproefgrootte

## Stappen voor berekening

1. **Bereken het steekproefgemiddelde:**
   - x̄ = Σx / n

2. **Bereken de steekproef-standaarddeviatie:**
   - s = √[Σ(x - x̄)² / (n-1)]

3. **Bereken de standaardfout:**
   - SE = s / √n

4. **Bereken de foutmarge:**
   - ME = t₀.₀₂₅,₈ × SE
   - t₀.₀₂₅,₈ = 2.306 (uit t-tabel)

5. **Bereken het betrouwbaarheidsinterval:**
   - Ondergrens = x̄ - ME
   - Bovengrens = x̄ + ME

## Hint

- Gebruik de steekproef-standaarddeviatie (n-1 in de noemer)
- Voor 95% CI met df = 8: t = 2.306
- Het interval geeft de range waarin we verwachten dat μ ligt

Voer je antwoord in als: **ondergrens,bovengrens** (bijvoorbeeld: 25.67,31.23)
