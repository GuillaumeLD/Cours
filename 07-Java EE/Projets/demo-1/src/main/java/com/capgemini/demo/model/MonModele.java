package com.capgemini.demo.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class MonModele {

	private Long key;
	private String truc;
	private String bidule;
	private Integer monInt;
	private Boolean maBoule;
	private String[] tabs;
	
	public MonModele() {
		
	}
	
	public MonModele(String truc, 
					String bidule, 
					Integer monInt, 
					Boolean maBoule, 
					String[] tabs) {
		super();
		this.truc = truc;
		this.bidule = bidule;
		this.monInt = monInt;
		this.maBoule = maBoule;
		this.tabs = tabs;
	}
	
	public MonModele(Long key,
			String truc, 
			String bidule, 
			Integer monInt, 
			Boolean maBoule, 
			String[] tabs) {
super();
this.key = key;
this.truc = truc;
this.bidule = bidule;
this.monInt = monInt;
this.maBoule = maBoule;
this.tabs = tabs;
}

	public Long getKey() {
		return key;
	}

	public void setKey(Long key) {
		this.key = key;
	}	
	
	public String getTruc() {
		return truc;
	}

	public void setTruc(String truc) {
		this.truc = truc;
	}

	public String getBidule() {
		return bidule;
	}

	public void setBidule(String bidule) {
		this.bidule = bidule;
	}

	public int getMonInt() {
		return monInt;
	}

	public void setMonInt(Integer monInt) {
		this.monInt = monInt;
	}

	public boolean isMaBoule() {
		return maBoule;
	}

	public void setMaBoule(Boolean maBoule) {
		this.maBoule = maBoule;
	}

	public String[] getTabs() {
		return tabs;
	}

	public void setTabs(String[] tabs) {
		this.tabs = tabs;
	}

}