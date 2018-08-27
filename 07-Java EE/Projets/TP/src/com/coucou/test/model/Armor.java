package com.coucou.test.model;

public class Armor {

	private String name;
	private int defence;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getDefence() {
		return defence;
	}

	public void setDefence(int defence) {
		this.defence = defence;
	}

	public Armor(String name, int defence) {
		super();
		this.name = name;
		this.defence = defence;
	}

	public String toString() {
		return "Armor [name=" + name + ", defence=" + defence + "]";
	}

	
}
