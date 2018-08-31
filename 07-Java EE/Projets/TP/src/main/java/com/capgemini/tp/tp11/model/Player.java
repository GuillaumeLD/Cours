package com.capgemini.tp.tp11.model;

import java.util.ArrayList;

public class Player {

	private String name;
	private ArrayList<Ship> fleet;
	@SuppressWarnings("unused")
	private boolean alive;
	private ArrayList<Box> map;
	 
	public Player(String name, ArrayList<Ship> fleet) {
		this.name = name;
		this.fleet = fleet;
		this.alive = true;
		this.map = new ArrayList<Box>();
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public ArrayList<Ship> getFleet() {
		return fleet;
	}


	public void setFleet(ArrayList<Ship> fleet) {
		this.fleet = fleet;
	}
	
	// Check if the player is alive
	public boolean isAlive() {
		boolean isAlive = true;
		if (this.getFleet().isEmpty()) {
			isAlive = false;
		}
		return isAlive;
	}
		
	public void setAlive(boolean alive) {
		this.alive = alive;
	}
	
	public ArrayList<Box> getMap() {
		return map;
	}
	
	public void setMap(ArrayList<Box> map) {
		this.map = map;
	}
}
