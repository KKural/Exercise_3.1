# Image Format Configuration Summary

## Current Setup Overview

Your RMD file has been configured to handle both PNG (for Word document rendering) and SVG (for Dodona platform) formats correctly.

## Configuration Details

### 1. RMD Output Settings
```yaml
output:
  officedown::rdocx_document:
    fig_caption: true
    toc: false
    reference_docx: "template_clean.docx"
```

### 2. Knitr Chunk Settings
```r
knitr::opts_chunk$set(
  echo = FALSE, 
  message = FALSE, 
  warning = FALSE, 
  fig.show = 'asis', 
  results = 'hide', 
  dev = 'png',     # PNG for Word document rendering
  dpi = 300        # High quality for Word documents
)
```

### 3. Image Saving Function
The `save_dodona_image()` function now:
- ✅ Saves SVG files for Dodona platform (scalable vector graphics)
- ✅ Saves PNG files for backup/compatibility (300 DPI raster graphics)
- ✅ Creates proper directory structure automatically
- ✅ Uses consistent naming convention

## How It Works

### When You Render the RMD:
1. **Word Document**: Images appear as PNG (300 DPI, high quality)
2. **Inline Display**: Plots are displayed in the document

### When Plots Are Saved for Dodona:
1. **SVG Format**: Saved to `description/media/` folders for each exercise
2. **PNG Format**: Also saved as backup/compatibility option
3. **File Structure**: 
   ```
   3.X Exercise Name/
   ├── description/
   │   ├── description.nl.md
   │   └── media/
   │       ├── correlation_plot_X.svg  ← Used by Dodona
   │       └── correlation_plot_X.png  ← Backup
   └── ...
   ```

## Dodona Integration

Your Dodona exercises correctly reference SVG files:
```markdown
![Visualisatie](media/correlation_plot_3.svg)
```

## Benefits of This Setup

### SVG for Dodona Platform:
- ✅ Perfect scalability (vector graphics)
- ✅ Crisp text rendering at any zoom level
- ✅ Smaller file sizes for simple graphics
- ✅ Web-optimized format

### PNG for Word Documents:
- ✅ Universal compatibility with Word
- ✅ High resolution (300 DPI)
- ✅ Predictable rendering
- ✅ Professional print quality

## Exercise Coverage

The following exercises have image generation configured:
- Q3: 3.3 Correlatie - Belangrijkste maatregelen
- Q8: 3.8 Correlatie - Interpreteer correlatie
- Q9: 3.9 Correlatie - Wat correlatie vertelt
- Q11: 3.11 Correlatie - Visualisatie belang
- Q12: 3.12 Correlatie - Covariantie verschillen
- Q14: 3.14 Correlatie - Pearson vs Spearman
- Q15: 3.15 Correlatie - Richting en kracht
- Q18: 3.18 Correlatie - Wanneer welke correlatie
- Q19: 3.19 Correlatie - Impact uitschieters
- Q21: 3.21 Correlatie - Correlatie interpretatie
- Q23: 3.23 Correlatie - Correlatie aannames

## Next Steps

1. **Render your RMD**: Word document will use PNG images
2. **Check Exercises**: SVG files are automatically saved to correct locations
3. **Upload to Dodona**: SVG files will display perfectly in the web interface

## Troubleshooting

If you need to regenerate images:
1. Run your RMD file - images are automatically saved during rendering
2. Check the `description/media/` folders for both SVG and PNG files
3. Dodona descriptions already point to SVG files correctly

Your setup is now optimized for both Word document generation and Dodona platform compatibility!