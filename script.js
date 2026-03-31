// Script JavaScript pour le site Safe
console.log("Bienvenue sur le site de Safe !");

// Exemple d'interactivité simple
document.addEventListener('DOMContentLoaded', function() {
    const sections = document.querySelectorAll('section');
    sections.forEach(section => {
        section.addEventListener('click', function() {
            alert('Vous avez cliqué sur ' + section.id);
        });
    });
});