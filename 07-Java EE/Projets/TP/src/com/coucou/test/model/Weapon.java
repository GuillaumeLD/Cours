package com.coucou.test.model;

public class Weapon {

	private String name;
	private int damage;
	private int actionCost;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getDamage() {
		return damage;
	}

	public void setDamage(int damage) {
		this.damage = damage;
	}

	public int getActionCost() {
		return actionCost;
	}

	public void setActionCost(int actionCost) {
		this.actionCost = actionCost;
	}

	public Weapon(String name, int damage, int actionCost) {
		super();
		this.name = name;
		this.damage = damage;
		this.actionCost = actionCost;
	}

	public String toString() {
		return "Weapon [name=" + name + ", damage=" + damage + ", actionCost=" + actionCost + "]";
	}

	
}
