package com.coucou.test.model;

public class Player {

	private String name;
	private Stats stats;
	private Armor armor;
	private Weapon weapon;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Stats getStats() {
		return stats;
	}

	public void setStats(Stats stats) {
		this.stats = stats;
	}

	public Armor getArmor() {
		return armor;
	}

	public void setArmor(Armor armor) {
		this.armor = armor;
	}

	public Weapon getWeapon() {
		return weapon;
	}

	public Player setWeapon(Weapon weapon) {
		this.weapon = weapon;
		return this;
	}

	public Player(String name, Stats stats, Armor armor, Weapon weapon) {
		this.name = name;
		this.stats = stats;
		this.armor = armor;
		this.weapon = weapon;
	}

	public Player() {
		// TODO Auto-generated constructor stub
	}

	public String toString() {
		return "Player [name=" + name + ", stats=" + stats + ", armor=" + armor + ", weapon=" + weapon + "]";
	}
}
