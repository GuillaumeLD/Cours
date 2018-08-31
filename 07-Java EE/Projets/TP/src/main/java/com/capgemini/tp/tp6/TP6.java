package com.capgemini.tp.tp6;

import java.util.Random;

public class TP6 {

	public static void main(String[] args) {

		Random rand = new Random();
		int indiceCuisson = 0;
				
		do {
			indiceCuisson = rand.nextInt(5) % 5 +1;
			System.out.println(indiceCuisson);
			if (indiceCuisson < 4) {
				System.out.println("Laisser le repas cuire");
			}
		} while (indiceCuisson < 4);
		
		if (indiceCuisson == 5) {
			System.out.println("Le repas est brûlé !");
		}
		else {
			System.out.println("Le repas est à point !");
		}
	}
}
