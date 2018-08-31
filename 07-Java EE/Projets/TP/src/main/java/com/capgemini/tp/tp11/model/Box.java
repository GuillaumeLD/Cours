package com.capgemini.tp.tp11.model;

public class Box {

	private int x;
	private int y;
	boolean hit;
	
	public Box(int x, int y) {
		this.x = x;
		this.y = y;
		this.hit = false;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public boolean isHit() {
		return hit;
	}

	public void setHit(boolean hit) {
		this.hit = hit;
	}
}
