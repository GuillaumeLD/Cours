package com.capgemini.tp.tp11.model;

import java.util.ArrayList;

public class Ship {
	
	protected int id;
	protected int size;
	protected ArrayList<Box> location = new ArrayList<Box>();
	protected boolean alive;
	
	public Ship() {
		this.alive = true;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSize() {
		return size;
	}
	public void getSize(int taille) {
		this.size = taille;
	}

	public ArrayList<Box> getLocation() {
		return location;
	}

	public void setLocation(ArrayList<Box> location) {
		this.location = location;
	}
	
	public boolean isAlive() {
		boolean isAlive = false;
		for (Box box : this.location) {
			//System.out.println("is Alive ? " + box.getX() + "," + box.getY());
			if (!box.isHit()) {
				isAlive = true;
				break; // sort du for ?
			}
		}
		return isAlive;
	}
	
	public void setAlive(boolean alive) {
		this.alive = alive;
	}
}
