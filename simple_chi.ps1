# Simple script to calculate chi-square value for the given matrix
$observed = @(@(25, 15), @(18, 22), @(12, 28))

# Row sums
$row_sums = @(40, 40, 40)

# Column sums
$col_sums = @(55, 65)

# Total
$total = 120

# Expected values
$expected = @(
    @(($row_sums[0] * $col_sums[0]) / $total, ($row_sums[0] * $col_sums[1]) / $total),
    @(($row_sums[1] * $col_sums[0]) / $total, ($row_sums[1] * $col_sums[1]) / $total),
    @(($row_sums[2] * $col_sums[0]) / $total, ($row_sums[2] * $col_sums[1]) / $total)
)

# Chi-square components
$chi_square = 0
for ($i = 0; $i -lt 3; $i++) {
    for ($j = 0; $j -lt 2; $j++) {
        $chi_square += [Math]::Pow($observed[$i][$j] - $expected[$i][$j], 2) / $expected[$i][$j]
    }
}

$result = [Math]::Round($chi_square, 2)
Write-Output "Chi-square value: $result"
