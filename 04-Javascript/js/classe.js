const Joueur = function(n) {
    this.nom = n;
    this.points = 0;

    if (nom == "toto") this.points = 10;
}

Joueur.prototype.gagnerPoint = function() {
    this.points++;
}

var joueur1 = new Joueur("toto");
var joueur2 = new Joueur("tata");
joueur2.gagnerPoint();

