var monChampTexte = document.getElementById('texte');
var monInput = document.getElementById('input');
var monBouton = document.getElementById('bouton');

monChampTexte.innerHTML = "26 + 3 ?";

monBouton.addEventListener('click', function(evt) {
    console.log("evt",evt.offsetX);
    monChampTexte.innerHTML = monInput.value;
    nombre = document.getElementById('input').value;
    console.log("Nombre =",nombre);
    if (nombre == 29) {
        monChampTexte.innerHTML = "C'est bon";
    }
    else {
        monChampTexte.innerHTML = "26 + 3 ?" + "<br />Erreur";
        monChampTexte.setAttribute("style","color: red;")
    }

})
