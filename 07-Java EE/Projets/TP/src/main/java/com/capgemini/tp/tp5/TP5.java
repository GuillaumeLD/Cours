package com.capgemini.tp.tp5;

import java.util.Scanner;

public class TP5 {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		System.out.println("Veuillez saisir un premier entier :");
		int a = sc.nextInt();
		System.out.println("Veuillez saisir un deuxième entier :");
		int b = sc.nextInt();
		
		int resultat;
		if (a == b) {
			resultat = a+b;
		}
		else if (a<0 && b>0) {
			resultat = a*b;
		}
		else if (((a>0 && b>0) || (a<0 && b<0)) && ((a>10 || b>10) || (a<-10 || b<-10))) {
			resultat = a/b;
		}
		else {
			resultat = 0;
		}

		System.out.println("Le résultat est : " + resultat);
		sc.close();
	}

}
