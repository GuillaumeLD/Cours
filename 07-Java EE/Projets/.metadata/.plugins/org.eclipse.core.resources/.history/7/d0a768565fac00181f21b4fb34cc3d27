package com.capgemini.tp.tp11;
import java.util.Scanner;

import com.capgemini.tp.tp11.manager.Game;

public class Main {

	public static void main(String[] args) {

		Scanner scan = new Scanner(System.in);
		
		// Choisir le nombre de joueurs
		int playerCount = 0;
		do {
			System.out.println("Combien de joueur ? (entre 2 et 100)");
			try {
				playerCount = Integer.parseInt(scan.next());
			}
			catch(NumberFormatException e) {
				System.out.println("Vous devez entrer un nombre.");
			}
		} while (!(playerCount >= 2 && playerCount <= 100));

		// Choisir le nombre de cases en X
		int mapSizeX = 0;
		do {
			System.out.println("Combien de cases en X ? (entre 8 et 50)");
			try {
				mapSizeX = Integer.parseInt(scan.next());
			}
			catch(NumberFormatException e) {
				System.out.println("Vous devez entrer un nombre.");
			}
		} while (!(mapSizeX >= 8 && mapSizeX <= 50));
		
		// Choisir le nombre de cases en Y
		int mapSizeY = 0;
		do {
			System.out.println("Combien de cases en Y ? (entre 8 et 50)");
			try {
				mapSizeY = Integer.parseInt(scan.next());
			}
			catch(NumberFormatException e) {
				System.out.println("Vous devez entrer un nombre.");
			}
		} while (!(mapSizeY >= 8 && mapSizeY <= 50));
		
		// Crée, initialise et lance la partie
		Game game = new Game(playerCount,mapSizeX,mapSizeY);
		game.init();
		game.launch();
		scan.close();

	}
}
