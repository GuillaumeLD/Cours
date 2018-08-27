package com.capgemini.bddexample.database.contract;

public abstract class BaseContract {
	
	private String tableName;
	private String primaryKey;
	private Class<?> klazz;
	
	public BaseContract(String tableName, String primaryKey, Class<?> klazz) {
		this.tableName = tableName;
		this.primaryKey = primaryKey;
		this.klazz = klazz;
	}
	
	public String createTable() {
		StringBuilder sb = new StringBuilder();
		sb.append("CREATE TABLE IF NOT EXISTS " + tableName);
        sb.append("(");
        sb.append(getChildrenCreateFields());
        sb.append(")");
		return sb.toString();
	}
	
	public String[] fields() {
		return getFields();
	}
	
	public String selectableFields() {
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < this.fields().length -1; i++) {
			sb.append(this.fields()[i]+",");
		}
		sb.append(this.fields().length -1);
		return sb.toString();

	}
	
	public String[] getAliasedFields() {
		String[] result = new String[fields().length];
		for (int i = 0; i < fields().length; i++) {
			result[i] = tableName + "." + fields()[i];
		}
		return result;
	}
	
	public abstract String getChildrenCreateFields();
	public abstract String[] getFields();

	public String getTableName() {
		return tableName;
	}

	public String getPrimaryKey() {
		return primaryKey;
	}
	
	public Class<?> getKlazz() {
		return klazz;
	}
	
	
	
}
