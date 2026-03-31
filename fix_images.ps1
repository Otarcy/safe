$articlesPath = "c:\Users\xxx\Desktop\SVG OTARCY\SAFE 2025\SITE INTERNET\Bibliotheque\articles"

Get-ChildItem $articlesPath -Directory -Recurse | Where-Object { Test-Path "$($_.FullName)\index.html" } | ForEach-Object {
    $dir = $_.FullName
    $indexFile = "$dir\index.html"
    $content = Get-Content $indexFile -Raw

    # Find all src="..." in the content
    $srcMatches = [regex]::Matches($content, 'src="([^"]*)"')
    foreach ($match in $srcMatches) {
        $src = $match.Groups[1].Value
        $fullSrc = Join-Path $dir $src
        if (!(Test-Path $fullSrc)) {
            # Try the other extension
            if ($src -like "*.jpg") {
                $altSrc = $src -replace '\.jpg$', '.JPG'
                $fullAlt = Join-Path $dir $altSrc
                if (Test-Path $fullAlt) {
                    $content = $content -replace [regex]::Escape($match.Value), 'src="' + $altSrc + '"'
                }
            } elseif ($src -like "*.JPG") {
                $altSrc = $src -replace '\.JPG$', '.jpg'
                $fullAlt = Join-Path $dir $altSrc
                if (Test-Path $fullAlt) {
                    $content = $content -replace [regex]::Escape($match.Value), 'src="' + $altSrc + '"'
                }
            }
        }
    }

    # Save the content
    [System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
}