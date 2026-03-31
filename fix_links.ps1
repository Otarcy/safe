$articlesPath = "c:\Users\xxx\Desktop\SVG OTARCY\SAFE 2025\SITE INTERNET\Bibliotheque\articles"

Get-ChildItem $articlesPath -Directory | ForEach-Object {
    $categoryDir = $_.FullName
    $indexFile = "$categoryDir\index.html"
    if (!(Test-Path $indexFile)) { return }

    $indexContent = Get-Content $indexFile -Raw

    $links = [regex]::Matches($indexContent, 'href="([^"]*/)"')

    foreach ($link in $links) {
        $folder = $link.Groups[1].Value.TrimEnd('/')
        $folderPath = "$categoryDir\$folder"
        if (Test-Path $folderPath) {
            $htmlFiles = Get-ChildItem $folderPath -Filter *.html | Where-Object { $_.Name -ne 'index.html' }
            $subDirs = Get-ChildItem $folderPath -Directory
            if ($htmlFiles -and !$subDirs) {
                $htmlFile = $htmlFiles[0].Name
                $newHref = "$folder/$htmlFile"
                $indexContent = $indexContent -replace [regex]::Escape($link.Value), "href=`"$newHref`""
            }
        }
    }

    $indexContent | Set-Content $indexFile -Encoding UTF8
}