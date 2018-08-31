package com.capgemini.designpattern.TPAdapter.src;


import java.util.*;

/**
 * 
 */
public class MediaAdapter implements MediaPlayer {

	String format;
	
    /**
     * Default constructor
     */
    public MediaAdapter() {
    }
    
    public MediaAdapter(String format) {
    	this.format = format;
    }
    
    public void play(String format, String file) {
    	
    	AudioPlayer audioPlayer = new AudioPlayer();
    	audioPlayer.play(format, file);
    	
    }

}