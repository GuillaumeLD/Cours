package com.capgemini.tp.tp3;

import java.util.Scanner;

public class TP3 {

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);
		
		System.out.println("Combien de pommes dans le panier de Jasmine ?");
		int panierJasmine = sc.nextInt();
		System.out.println("Jasmine a " + panierJasmine + " pommes dans son panier.");
		System.out.println("Combien de pommes dans le panier d'Aladin ?");
		int panierAladin = sc.nextInt();
		System.out.println("Aladin a " + panierAladin + " pommes dans son panier.");
		int nouveauPanier = panierJasmine + panierAladin;
		System.out.println("Ils regroupent leurs pommes dans un nouveau panier"
				+ " qui a donc " + nouveauPanier + " pommes !");
	}

}
