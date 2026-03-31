$articlesPath = "c:\Users\xxx\Desktop\SVG OTARCY\SAFE 2025\SITE INTERNET\Bibliotheque\articles"

Get-ChildItem $articlesPath -Directory -Recurse | ForEach-Object {
    $dir = $_.FullName
    if (Test-Path "$dir\index.html") { return }

    $htmlFiles = Get-ChildItem $dir -Filter *.html
    $subDirs = Get-ChildItem $dir -Directory
    $level = ($dir -split '\\').Count - 9
    $rel = '../' * $level
    $parentRel = '../' * ($level - 1)
    $title = $_.Name -replace '^(\d+)_', ''
    $parentName = Split-Path (Split-Path $dir -Parent) -Leaf -replace '^(\d+)_', ''

    if ($htmlFiles) {
        $html = $htmlFiles[0]
        $image = $html.Name -replace '\.html$', '_IMAGE.jpg'
        if (!(Test-Path "$dir\$image")) { $image = 'icon.jpg' }
        $content = @"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title - Bibliothèque - Safe</title>
    <link rel="stylesheet" href="$($rel)style.css">
</head>
<body>
    <header>
        <h1>$title</h1>
        <nav>
            <ul>
                <li><a href="$rel index.html">Accueil</a></li>
                <li><a href="$parentRel index.html">Bibliothèque</a></li>
                
            </ul>
        </nav>
    </header>
    <main>
        <section id="articles">
            <h2>Articles</h2>
            <div class="category-grid">
                <div class="category">
                    <a href="$($html.Name)">
                        <img src="$image" alt="Image $title" onerror="this.src="$rel images/bibliotheque-icon.svg"">
                        <h3>$title</h3>
                    </a>
                </div>
            </div>
        </section>
    </main>
    <footer>
        <p>&copy; 2025 Safe. Tous droits réservés.</p>
    </footer>
    <script src="$($rel)script.js"></script>
</body>
</html>
"@
    } elseif ($subDirs) {
        $grid = ''
        foreach ($sub in $subDirs) {
            $name = $sub.Name -replace '^(\d+)_', ''
            $grid += @"
                <div class="category">
                    <a href="$($sub.Name)/">
                        <img src="$($sub.Name)/icon.jpg" alt="Icône $name" onerror="this.src="$rel images/bibliotheque-icon.svg"">
                        <h3>$name</h3>
                    </a>
                </div>
"@
        }
        $content = @"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title - Bibliothèque - Safe</title>
    <link rel="stylesheet" href="$($rel)style.css">
</head>
<body>
    <header>
        <h1>$title</h1>
        <nav>
            <ul>
                <li><a href="$rel index.html">Accueil</a></li>
                <li><a href="$parentRel index.html">Bibliothèque</a></li>
                
            </ul>
        </nav>
    </header>
    <main>
        <section id="subcategories">
            <h2>Sous-catégories</h2>
            <div class="category-grid">
$grid
            </div>
        </section>
    </main>
    <footer>
        <p>&copy; 2025 Safe. Tous droits réservés.</p>
    </footer>
    <script src="$($rel)script.js"></script>
</body>
</html>
"@
    } else {
        $content = @"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title - Bibliothèque - Safe</title>
    <link rel="stylesheet" href="$($rel)style.css">
</head>
<body>
    <header>
        <h1>$title</h1>
        <nav>
            <ul>
                <li><a href="$rel index.html">Accueil</a></li>
                <li><a href="$parentRel index.html">Bibliothèque</a></li>
                
            </ul>
        </nav>
    </header>
    <main>
        <p>Contenu à venir.</p>
    </main>
    <footer>
        <p>&copy; 2025 Safe. Tous droits réservés.</p>
    </footer>
    <script src="$($rel)script.js"></script>
</body>
</html>
"@
    }
    $content | Out-File "$dir\index.html" -Encoding UTF8
}
