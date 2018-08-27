/* Javascript pur
appel d'une api */


// Initialisation de la page
nouveauPays();

var page = document.getElementById("page-top");
var listeJoueurUL = document.createElement("ul");   
page.appendChild(listeJoueurUL);

var listejoueurs = new Array();
var ajouterjoueur = document.getElementById('ajouterjoueur');

// Clic sur le bouton "Ajouter Joueur"
ajouterjoueur.addEventListener('click', function(evt){
 
    var nomjoueur = prompt("Entrez un nom de joueur");

    if (listejoueurs.length < 9) {
        var joueur = new Joueur(nomjoueur);
       
        // Création de l'input du joueur
        var newJoueurP = document.createElement("p");
        document.getElementById("listeJoueursDiv").appendChild(newJoueurP);

        var newJoueurLabel = document.createElement("label");
        newJoueurLabel.innerHTML = "Réponse de " + joueur.nom + " : ";

        var newJoueurInput = document.createElement("input");
        newJoueurInput.setAttribute('type',"text");
        newJoueurInput.setAttribute('id',joueur.nom);

        newJoueurInput.addEventListener("change",function(evt){
            joueur.temp = evt.target.value;
        });

       

        newJoueurP.appendChild(newJoueurLabel);
        newJoueurP.appendChild(newJoueurInput);
       
        listejoueurs.push(joueur);

        // Ajout du joueur dans la balise <li>
        var joueurLI = document.createElement("li");
        var idLI = "joueur" + listejoueurs.length;
        joueur.indice = listejoueurs.length;

        joueurLI.setAttribute("id",idLI);
        listeJoueurUL.appendChild(joueurLI);
        joueurLI.innerHTML = joueur.nom;
        joueurLI.innerHTML += " : ";

        var pointsSpan = document.createElement("span");
        joueurLI.appendChild(pointsSpan);
        pointsSpan.setAttribute("class", "points");
        pointsSpan.innerHTML = joueur.points;

        joueurLI.innerHTML += " points.";

        console.log("Joueur" + joueur.nom);

        var newJoueurLabel2 = document.createElement("label");
        newJoueurLabel2.setAttribute("id","joueur" + joueur.indice + "Label2");
        newJoueurP.appendChild(newJoueurLabel2);


        // Une fois que les joueurs sont au complet
        if (listejoueurs.length == 9) {
            console.log("Joueurs au complet !");
            // document.querySelectorAll("label.time").innerHTML = "test time";


            // // Afficher le temps restant de chaque joueur
            // listejoueurs.forEach(function(element) {
            //     var interval = setInterval(decompter, 1000);
            //     var decompte = document.getElementById("joueur" + element.indice + "Label2");
            //     decompte.innerHTML = "   Temps restant : ";
            // })
        }
    }  
    else {
        alert("Maximum de joueurs atteint");
    }
})

var nouveaupays = document.getElementById('nouveaupays');
nouveaupays.addEventListener('click', function(evt){
    nouveauPays();
})

var temp;
var valider = document.getElementById('valider');
var reponse = document.getElementById('reponse');

// Clic sur le bouton Valider
valider.addEventListener('click', function(evt) {  

    console.log("Liste joueurs =",listejoueurs);
    
    let gagnants = plusProche(temp);
    
    // Ligne affichant la liste des gagnants
    var listeGagnants = "Bravo à : ";
    gagnants.forEach(function(element) {
        listeGagnants += element.nom + " ";
    });
    listeGagnants += "!";

    reponse.innerHTML = 
        "Voici la réponse : " + temp + " °C<br />"
        + listeGagnants;
})



/////////////////////////////
/////// FONCTIONS
//////////////////////////////


// Initialise le formulaire pour un nouveau pays
function nouveauPays() {
   
    document.querySelectorAll("input").forEach(function(element){
        element.value = "";
    });

    // API Restcountries
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'https://restcountries.eu/rest/v2/all');
    xhr.onload = function() {
        if (xhr.status === 200) {
    
            let data = JSON.parse(xhr.responseText);
    
            var nombreAleatoire = getRandomInt(0, data.length);
            var image = document.getElementById('image');
            var ville = document.getElementById('ville');
    
            image.src = data[nombreAleatoire].flag;
            ville.innerHTML = 
                data[nombreAleatoire].name + " / " 
                + data[nombreAleatoire].capital + " / "
                + data[nombreAleatoire].region + " / "
                + data[nombreAleatoire].subregion;
            
            // Définir la latitude et longitude
            var latlng = data[nombreAleatoire].latlng;
            var lat = latlng[0];
            var lng = latlng[1];
    
            // API OpenWeatherMap
            var xhr2 = new XMLHttpRequest();
            xhr2.open('GET', 'http://api.openweathermap.org/data/2.5/weather?lat=' 
                + lat + '&lon=' + lng 
                + '&units=metric&APPID=ddf613e6889543e3c505122429eec504');
            xhr2.onload = function() {
                if (xhr2.status === 200) {
                    let data2 = JSON.parse(xhr2.responseText);
                    temp = data2.main.temp;

                    // var duree = 5000;
                    // listejoueurs.forEach(function(joueur,indice) {
                    //     setTimeout(function() { compteur(joueur) }, duree * index)
                    // })
                }
                else {
                    console.log("Erreur xhr2");
                }
            };
            xhr2.send();
        }
        else {
            console.log("Erreur");
        }
    };
    xhr.send();
}



// Retourne un nombre entier aléatoire entre min et max
function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}


// //Permet de verrouiller la zone de réponse des joueurs l'une après l'autre
// function compteur(joueur)
// {
// var secondes = 5;
// let interval = setInterval(function()
// {
// secondes--;
// //console.log(secondes + ' seconde');
// decompte.innerHTML = "Il vous reste " + secondes + " secondes..."
// }, 1000);
// let timeout = setTimeout(function()
// {
// clearInterval(interval);
// //console.log("STOP");
// document.getElementById(joueur).disabled = true;
// }, 5000);
// }


// Détermine les joueurs les plus proches d'une valeur n
function plusProche(n) {

    var gagnants = [];
    var diffMinimum = undefined;

    //définir quel est la différence minimum
    listejoueurs.forEach(function(joueur){

            var diffJoueur = Math.abs(joueur.temp - n);
            if(diffMinimum === undefined) { 
                diffMinimum = diffJoueur;  
            }
            else if(diffJoueur <= diffMinimum) {
                diffMinimum = diffJoueur;
            }
    })



    //chercher tous les joeurs qui ont la différence minumum
    listejoueurs.forEach(function(joueur){

        var diffJoueur = Math.abs(joueur.temp -n);
        if(diffJoueur == diffMinimum)
        {
            joueur.gagnerPoint();
            gagnants.push(joueur);
        }   
    })
    return gagnants;
}