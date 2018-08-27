package com.capgemini.bddexample.database.contract;

import com.capgemini.bddexample.model.User;

public class UserContract extends BaseContract {

	public static final String TABLE_NAME = "user";
	
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String LOGIN = "login";
	public static final String PASSWORD = "password";
	
	public static final String ALIASED_ID = TABLE_NAME + "." + ID;
	public static final String ALIASED_NAME = TABLE_NAME + "." + NAME;
	public static final String ALIASED_LOGIN = TABLE_NAME + "." + LOGIN;
	public static final String ALIASED_PASSWORD = TABLE_NAME + "." + PASSWORD;
	
	public static String CREATE_TABLE() {
		StringBuilder sb = new StringBuilder();
		sb.append("CREATE TABLE IF NOT EXISTS " + TABLE_NAME);
        sb.append("(");
        sb.append(ID +" INT AUTO_INCREMENT PRIMARY KEY NOT NULL,");
        sb.append(NAME +" VARCHAR(255) NOT NULL,");
        sb.append(LOGIN + " VARCHAR(255) NOT NULL,");
        sb.append(PASSWORD +" VARCHAR(255) NOT NULL");
        sb.append(")");
		return sb.toString();
	}
	
	public static String[] FIELDS() {
		String[] result = new String[4];
		
		result[0] = ID;
		result[1] = NAME;
		result[2] = LOGIN;
		result[3] = PASSWORD;
		
		return result;
	}
	
	public static String SELECTABLE_FIELDS() {
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < FIELDS().length -1; i++) {
			sb.append(FIELDS()[i]+",");
		}
		sb.append(FIELDS().length -1);
		return sb.toString();
	}
	
	public UserContract() {
		super(TABLE_NAME, ID, User.class);
	}
	
	@Override
	public String getChildrenCreateFields() {
		StringBuilder sb = new StringBuilder();
        sb.append(ID +" INT AUTO_INCREMENT PRIMARY KEY NOT NULL,");
        sb.append(NAME +" VARCHAR(255) NOT NULL,");
        sb.append(LOGIN + " VARCHAR(255) NOT NULL,");
        sb.append(PASSWORD +" VARCHAR(255) NOT NULL");
		return sb.toString();
	}
	
	@Override
	public String[] getFields() {
		return FIELDS();
	}
}