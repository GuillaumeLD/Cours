var resultat = document.getElementById('resultat');
var plus = document.getElementById('plus');
var moins = document.getElementById('moins');
var fois = document.getElementById('fois');
var divise = document.getElementById('divise');

var total = 0;
resultat.innerHTML = total;

plus.addEventListener('click', function(evt) {
    if (!nombre.value)
        nombre.value = 0;
    console.log("evt",evt);
    console.log(Number.parseInt(nombre.value));
    total += Number.parseInt(nombre.value);
    resultat.innerHTML = total;
})

moins.addEventListener('click', function(evt) {
    total -= Number.parseInt(nombre.value);
    resultat.innerHTML = total;
})


/* 
en objet

var calc = {}


attributs :
resultat
etc

fonctions: 
calc.add()
calc.affiche() 
etc
*/









/* var touches = document.querySelectorAll(".btnCalcul");
touches.forEach(function(touche){
    touches.addEventListener('click', function(evt){
        console.log(evt.target.getAttribute('data-valeur'));
        appuiTouche();
    });
}); */