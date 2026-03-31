$articlesPath = "c:\Users\xxx\Desktop\SVG OTARCY\SAFE 2025\SITE INTERNET\Bibliotheque\articles"

$dirs = Get-ChildItem $articlesPath -Directory -Recurse | Where-Object { Test-Path "$($_.FullName)\index.html" }
$nonConform = 0
$missingImage = 0

$dirs | ForEach-Object {
    $dir = $_.FullName
    $indexContent = Get-Content "$dir\index.html" -Raw

    $hasGrid = $indexContent -match '<div class="category-grid">'
    $hasDirectLink = $indexContent -match 'href="[^"]*\.html"'
    $hasFolderLink = $indexContent -match 'href="[^"]*/"' -and $indexContent -notmatch 'href="[^"]*\.html"'
    $hasMessage = $indexContent -match 'Contenu à venir'

    $htmlFiles = Get-ChildItem $dir -Filter *.html | Where-Object { $_.Name -ne 'index.html' }
    $subDirs = Get-ChildItem $dir -Directory

    $imageCheck = $true
    if ($hasGrid) {
        $links = [regex]::Matches($indexContent, 'href="([^"]*)"')
        foreach ($link in $links) {
            $href = $link.Groups[1].Value
            if ($href -match '\.html$') {
                $imgMatch = [regex]::Match($indexContent, 'src="([^"]*)"', [regex]::RightToLeft)
                if ($imgMatch) {
                    $img = $imgMatch.Groups[1].Value
                    if (!(Test-Path "$dir\$img")) {
                        $imageCheck = $false
                    }
                }
            }
        }
    }

    $conform = $false
    if ($htmlFiles -and !$subDirs) {
        $conform = $hasGrid -and $hasDirectLink -and !$hasFolderLink
    } elseif ($subDirs) {
        $conform = $hasGrid -and $hasFolderLink -and !$hasDirectLink
    } elseif (!$htmlFiles -and !$subDirs) {
        $conform = $hasMessage
    }

    if (!$conform) { $nonConform++ }
    if (!$imageCheck) { $missingImage++ }
}

Write-Host "Total dossiers vérifiés: $($dirs.Count)"
Write-Host "Non conformes: $nonConform"
Write-Host "Images manquantes: $missingImage"
