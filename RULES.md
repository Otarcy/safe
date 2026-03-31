# Règles de Navigation pour le Site Safe

## Règles Définies

1. **Structure des Catégories** :
   - L'accueil affiche les catégories principales (Boutique, Troc, Abris, Bibliothèque) en grille avec icônes SVG.

2. **Navigation dans la Bibliothèque** :
   - Chaque catégorie principale a une page index.html listant ses sous-catégories en grille.
   - Les sous-catégories utilisent les images du dossier (JPG ou autre) comme couverture dans les cartes.

3. **Règle pour les Liens** :
   - Si un dossier contient un seul fichier HTML, le lien pointe directement vers ce fichier HTML.
   - Si un dossier contient plusieurs fichiers ou sous-dossiers, le lien pointe vers le dossier (avec index.html pour grille).

4. **Affichage des Sous-Dossiers** :
   - Les sous-dossiers sont affichés comme des items dans la grille, sauf lorsque le dossier contient un fichier HTML, auquel cas on affiche directement le HTML.

4. **Affichage en Grille** :
   - Utiliser une grille responsive avec cartes larges (min 250px).
   - Chaque carte contient une image (couverture), un titre, et un lien.
   - Images avec object-fit: cover pour un aspect uniforme.

5. **Application du CSS** :
   - Tous les fichiers HTML incluent le lien vers style.css avec le bon chemin relatif.
   - Thème sombre avec variables CSS pour cohérence.

6. **Navigation Hiérarchique** :
   - Breadcrumb dans le header pour revenir en arrière.
   - Liens directs pour éviter les étapes inutiles.

7. **Gestion des Images** :
   - Utiliser les images présentes dans les dossiers (icon.jpg, *_IMAGE.JPG, etc.).
   - Fallback vers une icône SVG par défaut si image manquante.

## Implémentation

- Pages index.html créées pour chaque niveau avec grille.
- Liens ajustés selon la règle (direct vers HTML ou vers dossier).
- CSS appliqué globalement avec corrections de chemins.

## Maintenance

- Pour ajouter une nouvelle catégorie : créer le dossier, ajouter index.html avec grille, lier depuis l'accueil.
- Pour sous-catégories : suivre la règle de lien direct ou dossier.