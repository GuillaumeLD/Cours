package com.capgemini.tp.tp1;

import java.util.Scanner;

public class TP1 {

	public static void main(String[] args) {
		
		// Définition des variables
		int[] code = new int[] {2,3,1,4}; // code du cadenas
		boolean[] bonCode = new boolean[] {false, false, false, false}; // Vérification du code
		int curseur = 0; // position du curseur
		String saisie; // + ou - (pour gauche ou droite)
		
		
		System.out.println("Curseur = " + curseur);

		// Pour chaque verrou du code
		for (int i=0; i < code.length; i++ ) {
			
			int verrou = code[i];
			// On bouge le curseur jusqu'au verrou i
			do {
				Scanner sc = new Scanner(System.in);
				saisie = sc.nextLine();
				curseur = positionnerCurseur(curseur, saisie);
				
				
				System.out.println("Curseur = " + curseur);
				//System.out.println("Code[i] = " + code[i]);
				System.out.println("Saisie = " + saisie);
				
				if (curseur == code[i]) {
					System.out.println("Verrou n°" + (i+1) + " débloqué !");
					bonCode[i] = true;
					System.out.println("Bon Code = " + bonCode[0] + bonCode[1] + bonCode[2] + bonCode[3]);
					
				}
				if (!bonSens(curseur, code[i], saisie)) {
					System.out.println("Mauvais sens !");
					i=-1;
					curseur =0; 
				}
				// sc.close();
			}
			while (i!=-1 && curseur != verrou && bonSens(curseur, verrou, saisie));
			if (bonCode[bonCode.length-1] == true) {
				System.out.println("Cadenas déverrouillé !");
			}
		}	
	}
	
	// Positionne le curseur : à gauche si "-", à droite si "+"
	public static int positionnerCurseur(int curseur, String saisie) {
		
		if (saisie.equals("+")) {
			curseur++;
		}
		else if (saisie.equals("-")) {
			curseur--;
		}
		return curseur;
	}
	
	// Vérifie si on tourne la molette dans le bon sens
	public static Boolean bonSens(int curseur, int verrou, String saisie) {
		
		boolean bonSens;
		if ( (curseur <= verrou && saisie.equals("+")) || (curseur >= verrou && saisie.equals("-")) ) {
			bonSens = true;
		}
		else {
			bonSens = false;
		}
		return bonSens;
	}
}
