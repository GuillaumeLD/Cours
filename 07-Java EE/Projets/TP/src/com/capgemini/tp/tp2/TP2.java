package com.capgemini.tp.tp2;

public class TP2 {

	public static void main(String[] args) {

		int panierJasmine = 7;
		System.out.println("Jasmine a " + panierJasmine + " pommes dans son panier.");
		int panierAladin = 5;
		System.out.println("Aladin a " + panierAladin + " pommes dans son panier.");
		int nouveauPanier = panierJasmine + panierAladin;
		System.out.println("Ils regroupent leurs pommes dans un nouveau panier"
				+ " qui a donc " + nouveauPanier + " pommes !");
	}

}
