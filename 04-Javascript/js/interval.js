var c = 3;

var interval = setInterval(decompter, 1000);
compteur = document.getElementById('compteur');

function decompter() {
    compteur.innerHTML = "Il vous reste " + c + " secondes...";
    c--;
}

var timeout = setTimeout(arreterCompteur,4000); 

function arreterCompteur() {
    clearInterval(interval);
    compteur.innerHTML = "Trop tard !";
}