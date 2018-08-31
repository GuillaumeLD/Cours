package com.capgemini.tp.tp4;

import java.util.Scanner;

public class TP4 {

	public static void main(String[] args) {

		
		Scanner sc = new Scanner(System.in);
		System.out.println("Veuillez saisir un premier entier :");
		int a = sc.nextInt();
		System.out.println("Veuillez saisir un deuxième entier :");
		int b = sc.nextInt();
		
		int resultat = 0;
		if (a == b) {
			resultat = a+b;
		}
		if (a<0 && b>0) {
			resultat = a*b;
		}
		if (((a>0 && b>0) || (a<0 && b<0)) && ((a>10 || b>10) || (a<-10 || b<-10))) {
			resultat = a/b;
		}

		System.out.println("Le résultat est : " + resultat);
		sc.close();
	}
}
