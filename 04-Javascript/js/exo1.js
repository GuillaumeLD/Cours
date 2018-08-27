// Objet portefeuille

const portefeuille = {}

portefeuille.total = 0;

// Fonctions portefeuille

portefeuille.afficheMontant = function() {
    console.log("Montant du portefeuille : ",portefeuille.total);
}

portefeuille.ajoute = function(montant) {
    if ( Number.isInteger(montant) ) {
        this.total += montant;
    }
    else if (Array.isArray(montant)) {
        montant.forEach(function(val){
            var nombre = parseFloat(val);
            this.total += nombre;
        }.bind(this));
    }
}

portefeuille.retire = function(montant) {
    this.total -= montant;
}

portefeuille.positif = function() {
    if (this.total > 0) 
        return true;
    else
        return false;
}

portefeuille.retraitPossible = function(montantRetrait) {
    totalTemporaire = this.total - montantRetrait;
    if (totalTemporaire > 0) {
        console.log("Vous pouvez faire un retrait de ", montantRetrait, ". Montant après retrait = ", totalTemporaire);
    }
    else {
        console.log("Vous ne pouvez pas faire ce retrait car vous seriez à découvert. Montant après retrait = ", totalTemporaire);
    }
}

// Utilisation des fonctions

portefeuille.ajoute(100);
portefeuille.retire(20);
portefeuille.ajoute(50);
portefeuille.retire(400);
portefeuille.ajoute(1200);

portefeuille.ajoute(['100', '50','10.50']);

console.log(portefeuille.positif());

portefeuille.afficheMontant();

portefeuille.retraitPossible(500);
portefeuille.retraitPossible(2000);
