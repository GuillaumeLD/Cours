package com.capgemini.tp.tp11.manager;

import java.util.ArrayList;
import java.util.Random;

import com.capgemini.tp.tp11.model.Ship;
import com.capgemini.tp.tp11.model.Box;
import com.capgemini.tp.tp11.model.Corvette;
import com.capgemini.tp.tp11.model.Cruiser;
import com.capgemini.tp.tp11.model.Destroyer;
import com.capgemini.tp.tp11.model.Player;
import com.capgemini.tp.tp11.model.AircraftCarrier;

public class Game {

	private static final int CORVETTE_COUNT = 1;
	private static final int DESTROYER_COUNT = 2;
	private static final int CRUISER_COUNT = 2;
	private static final int AIRCRAFT_CARRIER_COUNT = 1;

	private int playerCount;
	private int mapSizeX;
	private int mapSizeY;
	private ArrayList<Player> playerList = new ArrayList<Player>();

	public Game(int playerCount, int mapSizeX, int mapSizeY) {
		this.playerCount = playerCount;
		this.mapSizeX = mapSizeX;
		this.mapSizeY = mapSizeY;
	}

	// Initialise le jeu
	public void init() {
		
		for (int i = 0; i < playerCount; i++) {
			ArrayList<Ship> fleet = new ArrayList<Ship>();
			for (int j = 0; j < CORVETTE_COUNT; j++) {
				fleet.add(new Corvette());
			}
			for (int j = 0; j < DESTROYER_COUNT; j++) {
				fleet.add(new Destroyer());
			}
			for (int j = 0; j < CRUISER_COUNT; j++) {
				fleet.add(new Cruiser());
			}
			for (int j = 0; j < AIRCRAFT_CARRIER_COUNT; j++) {
				fleet.add(new AircraftCarrier());
			}
			Player player = new Player("Player" + (i + 1), fleet);
			playerList.add(player);
			putFleet(player);
			displayMap(player);
		}
	}

	// Affiche la carte
	private void displayMap(Player player) {
		
		System.out.println("\nMap de " + player.getName() + " :");
		for (int y = 0; y < mapSizeY; y++) {
			for (int x = 0; x < mapSizeX; x++) {
				String displayBox = ".";
				for (Ship ship : player.getFleet()) {
					for (Box shipBox : ship.getLocation()) {
						if (x == shipBox.getX() && y == shipBox.getY()) {
							if (shipBox.isHit()) {
								displayBox = "x";
							} else {
								displayBox = Integer.toString(ship.getId());
							}
						}
					}
				}
				System.out.print(displayBox);
			}
			System.out.println();
		}
	}

	// place la flotte du joueur
	private void putFleet(Player player) {
		
		for (Ship ship : player.getFleet()) {
			tryPut(ship, player);
		}
	}

	// Essaye de placer un bateau
	private void tryPut(Ship ship, Player player) {
		
		Random random = new Random();
		int randomX = random.nextInt(mapSizeX);
		int randomY = random.nextInt(mapSizeY);
		int direction = random.nextInt(2);
		if (isSuitable(ship, player, randomX, randomY, direction)) {
			put(ship, player, randomX, randomY, direction);
		} else {
			tryPut(ship, player);
		}
	}

	// Place un bateau
	private void put(Ship ship, Player player, int randomX, int randomY, int direction) {

		switch (direction) {
		case 0:
			for (int i = 0; i < ship.getSize(); i++) {
				ship.getLocation().add(new Box(randomX + i, randomY));
			}
			break;
		case 1:
			for (int i = 0; i < ship.getSize(); i++) {
				ship.getLocation().add(new Box(randomX, randomY + i));
			}
			break;
		}
	}

	// Teste si un bateau peut être placé à un endroit donné
	private boolean isSuitable(Ship ship, Player player, int randomX, int randomY, int direction) {

		boolean isSuitable = true;
		for (Ship otherShip : player.getFleet()) {
			for (Box otherShipBox : otherShip.getLocation()) {
				if (direction == 0) {
					for (int i = randomX; i < (randomX + ship.getSize()); i++) {
						if ((otherShipBox.getX() == i && otherShipBox.getY() == randomY) || (i >= mapSizeX)) {
							isSuitable = false;
							return isSuitable;
						}
					}
				}
				else {
					for (int i = randomY; i < (randomY + ship.getSize()); i++) {
						if ((otherShipBox.getX() == randomX && otherShipBox.getY() == i) || (i >= mapSizeY)) {
							isSuitable = false;
							return isSuitable;
						}
					}
				}
			}
		}
		return isSuitable;
	}

	// Lance la partie, une fois le jeu initialisé
	public void launch() {
		System.out.println("\nBASTON !\n");
		do {
			for (int i = 0; i < playerList.size(); i++) {
				int targetIndex = searchTargetIndex(i);
				shootTarget(playerList.get(i), playerList.get(targetIndex));
			}
		} while (playerList.size() > 1);
		System.out.println("\nJoueur vainqueur : " + playerList.get(0).getName());
		System.out.println(
				"Liste des cases touchées du joueur gagnant : (" + playerList.get(0).getMap().size() + " cases)");
		for (Box box : playerList.get(0).getMap()) {
			System.out.print("(" + box.getX() + "," + box.getY() + ") ");
		}
	}

	// Cherche un joueur à cibler
	private int searchTargetIndex(int attackerIndex) {

		int targetIndex = -1;
		for (int i = attackerIndex + 1; i != attackerIndex; i++) {
			if (i == playerList.size()) { 
				i = 0;
			}
			if (playerList.get(i).isAlive()) { 
				targetIndex = i;
				break;
			}
		}
		return targetIndex;
	}

	// Tire sur le joueur ciblé
	private void shootTarget(Player attacker, Player target) {
		
		// Vise une case au hasard du joueur ciblé

		// Cherche une case qui n'a pas déjà été touchée
		
		Random random = new Random();
		int randomX = -1;
		int randomY = -1;
		do {
			randomX = random.nextInt(mapSizeX);
			randomY = random.nextInt(mapSizeY);
		} while (isAlreadyShot(target, randomX, randomY));
		target.getMap().add(new Box(randomX, randomY));
		System.out.println(
				attacker.getName() + " tire sur " + target.getName() + " en (" + randomX + "," + randomY + ")");
		
		// Vérifie si un bateau du joueur ciblé est sur cette case
		for (int i = 0; i < target.getFleet().size(); i++) {
			Ship ship = target.getFleet().get(i);
			for (Box box : ship.getLocation()) {
				// Bateau touché
				if (randomX == box.getX() && randomY == box.getY()) {
					System.out.println("Bateau de longueur " + ship.getSize() + " touché !");
					box.setHit(true);
					displayMap(target);
					System.out.println();
					// Bateau coulé
					if (!ship.isAlive()) {
						System.out.println("Bateau de longueur " + ship.getSize() + " COULE !");
						ship.setAlive(false);
						target.getFleet().remove(ship);
						// Joueur mort
						if (!target.isAlive()) {
							target.setAlive(false);
							playerList.remove(target);
							System.out.println(target.getName() + " EST MORT !");
						}
					}
				}
			}
		}
	}

	// Vérifie si une case d'un joueur ciblé a déjà été touchée
	private boolean isAlreadyShot(Player target, int randomX, int randomY) {

		boolean alreadyShot = false;
		for (Box box : target.getMap()) {
			if (randomX == box.getX() && randomY == box.getY()) {
				alreadyShot = true;
				break;
			}
		}
		return alreadyShot;
	}
}
