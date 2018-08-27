const Joueur = function(nom) {
    this.nom = nom;
    this.points = 0;

    // if (nom == "toto") this.points = 10;
}

Joueur.prototype.gagnerPoint = function() {
    this.points++;

    document.querySelector("li#joueur"+this.indice +" span.points").innerHTML = this.points;

}

// const listeJoueurs = function() {

// }

// var joueur1 = new Joueur("toto");
// var joueur2 = new Joueur("tata");
// joueur2.gagnerPoint();

