function Calculate-ChiSquare {
    # Observed values
    $observed = @(
        @(25, 15),  # Laag opgeleid: geweld, diefstal
        @(18, 22),  # Midden opgeleid: geweld, diefstal
        @(12, 28)   # Hoog opgeleid: geweld, diefstal
    )
    
    # Calculate row sums
    $row_sums = @(
        ($observed[0][0] + $observed[0][1]),
        ($observed[1][0] + $observed[1][1]),
        ($observed[2][0] + $observed[2][1])
    )
    
    # Calculate column sums
    $col_sums = @(
        ($observed[0][0] + $observed[1][0] + $observed[2][0]),
        ($observed[0][1] + $observed[1][1] + $observed[2][1])
    )
    
    # Calculate total
    $total = $row_sums[0] + $row_sums[1] + $row_sums[2]
    
    Write-Host "Row sums: $row_sums"
    Write-Host "Column sums: $col_sums"
    Write-Host "Total: $total"
    
    # Calculate expected values and chi-square components
    $chi_square = 0
    
    for ($i = 0; $i -lt 3; $i++) {
        for ($j = 0; $j -lt 2; $j++) {
            $expected = ($row_sums[$i] * $col_sums[$j]) / $total
            $component = [Math]::Pow($observed[$i][$j] - $expected, 2) / $expected
            $chi_square += $component
            
            Write-Host "Cell ($i,$j): Observed = $($observed[$i][$j]), Expected = $([Math]::Round($expected, 2)), Component = $([Math]::Round($component, 2))"
        }
    }
    
    return [Math]::Round($chi_square, 2)
}

$result = Calculate-ChiSquare
Write-Host "Chi-square value: $result"
