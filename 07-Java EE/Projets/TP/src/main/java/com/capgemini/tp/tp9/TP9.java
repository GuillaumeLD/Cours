package com.capgemini.tp.tp9;

public class TP9 {

	public static void main(String[] args) {

		// personnage = {a,b,c,d}
		// a = points d'attaque
		// b = armure
		// c = points de vie
		// d = points d'action
		// e = points d'action de l'arme
		int[][] personnages = { { 2,1,9,7,1 } , { 6,2,4,12,3 } , { 3,4,15,8,4 } };
		
		while ( nombrePersonnagesMorts(personnages) > 1 ) {
				
			for (int i=0; i< personnages.length ; i++) {
				
				personnages[i][3]--; // Le perso s'équipe d'une arme : -1 Action
				int tourPA = personnages[i][3];

				System.out.println("Le personnage n°" + (i+1) + " s'équipe de son arme et passe à " + tourPA + " PA" );	
				
				while (tourPA > 0) {
					
					tourPA -= personnages[i][4];
					
					System.out.println("Personnage n°" + (i+1) + " essaye d'attaquer");
					System.out.println("Personnage n°" + (i+1) + " passe à " + tourPA + " points d'action");

					
					// Si le personnage avait suffisamment de points d'action pour attaquer
					if (tourPA >= 0) {
						
						System.out.println("Personnage n°" + (i+1) + " lance son attaque");
						// Si c'est le dernier perso
						if (i == personnages.length-1) {
							// il attaque le 1er perso
							personnages[0][2] -= personnages[i][0] - personnages[0][1];
							System.out.println("Personnage n°1 a maintenant " + personnages[0][2] + " PV");
						}
						// Sinon
						else {
							// il attaque le perso suivant
							personnages[i+1][2] -= personnages[i][0] - personnages[i+1][1];
							System.out.println("Personnage n°" + (i+2) + " a maintenant " + personnages[i+1][2] + " PV");
						}
					}
					else {
						System.out.println("Le personnage n°" + (i+1) + " ne peut plus attaquer");
					}
					System.out.println("------------------");
				}
				System.out.println("===================");
			}
		}
 	}
	
	public static int nombrePersonnagesMorts(int personnages[][]) {
		
		int result = 0;
		for (int i=0; i<personnages.length; i++) {
			System.out.println("vivant");

			if (personnages[i][2] <= 0) {
				System.out.println("mort");
				result++;
			}
		}
		return result;
	}
	
}
