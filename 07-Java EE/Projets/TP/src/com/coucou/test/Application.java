package com.coucou.test;

import java.util.ArrayList;


import com.coucou.test.manager.Donjon;
import com.coucou.test.model.Armor;
import com.coucou.test.model.Player;
import com.coucou.test.model.Stats;
import com.coucou.test.model.Weapon;

public class Application {

	public static void main(String[] args) {
		
		// ArrayList<Player> players = new ArrayList<Player>();
		// players.add(new Player() {{setName("toto");}});
		
		Stats stats1 = new Stats(9,7);
		Stats stats2 = new Stats(4,12);
		Stats stats3 = new Stats(15,8);

		Armor armor1 = new Armor("Gilet bleu",1);
		Armor armor2 = new Armor("Armure de cuir",2);
		Armor armor3 = new Armor("Armure de plaque",4);
		
		Weapon weapon1 = new Weapon("Concasseur",3,4);
		Weapon weapon2 = new Weapon("Pelle",2,1);
		Weapon weapon3 = new Weapon("Gatling",10,6);
		Weapon weapon4 = new Weapon("Batte de cricket",1,1);
		Weapon weapon5 = new Weapon("Blaster",6,3);
		
		Player player1 = new Player("Riri",stats1,armor1,weapon2);
		Player player2 = new Player("Fifi",stats2,armor2,weapon5);
		Player player3 = new Player("Loulou",stats3,armor3,weapon1);

		
		
		ArrayList<Player> players = new ArrayList<Player>();
		players.add(player1);
		players.add(player2);
		players.add(player3);

		
		
		Donjon donjon = new Donjon(new ArrayList<Player>() {
			{
				add(new Player());
				add(new Player());
				add(new Player());
			}
		});
		donjon.doTheDonjon();
	}

}
