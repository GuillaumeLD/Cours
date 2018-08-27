package com.coucou.test.model;

public class Stats {
	private int lifePoint;
	private int actionPoint;
	private int currentLifePoint;
	private int currentActionPoint;

	public int getLifePoint() {
		return lifePoint;
	}

	public void setLifePoint(int lifePoint) {
		this.lifePoint = lifePoint;
	}

	public int getActionPoint() {
		return actionPoint;
	}

	public void setActionPoint(int actionPoint) {
		this.actionPoint = actionPoint;
	}

	public int getCurrentLifePoint() {
		return currentLifePoint;
	}

	public void setCurrentLifePoint(int currentLifePoint) {
		this.currentLifePoint = currentLifePoint;
	}

	public int getCurrentActionPoint() {
		return currentActionPoint;
	}

	public void setCurrentActionPoint(int currentActionPoint) {
		this.currentActionPoint = currentActionPoint;
	}

	public Stats(int lifePoint, int actionPoint) {
		this.lifePoint = this.currentLifePoint = lifePoint;
		this.actionPoint = this.currentActionPoint = actionPoint;
	}

	public String toString() {
		return "Stats [lifePoint=" + lifePoint + ", actionPoint=" + actionPoint + ", currentLifePoint="
				+ currentLifePoint + ", currentActionPoint=" + currentActionPoint + "]";
	}

}
