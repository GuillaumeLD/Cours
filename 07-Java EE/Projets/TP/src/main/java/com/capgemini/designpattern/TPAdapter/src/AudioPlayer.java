package com.capgemini.designpattern.TPAdapter.src;


import java.util.*;

/**
 * 
 */
public class AudioPlayer implements MediaPlayer {

	
    /**
     * Default constructor
     */
    public AudioPlayer() {
    }
    
    public void play(String format, String file) {
    	switch (format) {
    	case "mp3": System.out.println("Playing " + format + " file. Name: " + file); 
    	break;
    	case "mp4": System.out.println("Playing " + format + " file. Name: " + file);
    	break;
    	case "vlc": System.out.println("Playing " + format + " file. Name: " + file); 
    	break;
    	default: System.out.println("Invalid media. " + format + " format not supported");
    	}
    	
    }

}