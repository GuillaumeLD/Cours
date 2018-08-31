package com.capgemini.designpattern.TPObserver.src;


import java.util.*;


public class Subject {

	private int state;

    public Subject() {
    	
    }

    public void attach() {

    }

    public void detach() {
    }
    
    public void notif() {
    	update(this);
    }
    
    private void update(Subject subject) {
		// TODO Auto-generated method stub
		
	}

	public void setState(int value) {
    	
    }

}