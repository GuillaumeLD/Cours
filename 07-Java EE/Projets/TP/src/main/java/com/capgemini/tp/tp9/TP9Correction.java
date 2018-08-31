package com.capgemini.tp.tp9;

public class TP9Correction {

	  public static final int PV = 0; // point de vie
	    public static final int PA = 1; // point action
	    public static final int VA = 2; // valeur attaque
	    public static final int CA = 3; // coût attaque
	    public static final int VD = 4; // valeur défense
	    
	    public static void main(String[] args) {
	        int game[][] = {//PV,PA,VA,CA,VD
	                {9,7,2,1,1},
	                {4,12,6,3,2},
	                {15,8,3,4,4}
	        };
	        while(!gameOver(game)) {
	            turn(game);
	        }
	    }
	    
	    public static boolean gameOver(int game[][]) {
	        boolean result = false;
	        int alive = 0;
	        for (int i = 0; i < game.length; i++) {
	            if(game[i][PV] > 0) {
	            	alive ++;
	            }
	        }
	        if (alive <= 1) {
	        	result = true;
	        }
	        return result;
	    }
	    
	    public static void turn(int game[][]) {
	        for (int i = 0; i < game.length; i++) {
	            if(game[i][PV]>0) { // si joueur i en vie
	                int defender = findDefender(game, i);
	                if(defender!=-1) { // if defender found
	                    attack(game, i, defender);
	                }
	            }
	        }
	    }
	    
	    public static int findDefender(int game[][], int attacker) {
	        int result=-1;
	        for (int i = attacker+1; i!=attacker; i++) {
	            if (i==game.length) { // if last perso in table
	                i=0;
	            }
	            if (game[i][PV]>0) { //if defender alive
	                result = i;
	                break;
	            }
	        }
	        return result;
	    }
	    
	    public static void attack(int game[][], int attacker, int defender) {
	        int actionPoint = game[attacker][PA];
	        actionPoint--; // decrement action point because weapon using
	        while (actionPoint>=game[attacker][CA]) { // while attacker can attack
	            actionPoint-=game[attacker][CA]; // decrement attacker action point
	            int dammage = game[defender][VD]-game[attacker][VA]; // calculate damage
	            if(dammage<0) { // if damage possible
	                game[defender][PV]+=dammage; // apply damage
	            }
	        }
	    }
	
}
