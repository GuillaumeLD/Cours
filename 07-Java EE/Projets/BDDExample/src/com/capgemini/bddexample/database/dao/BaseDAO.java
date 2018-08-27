package com.capgemini.bddexample.database.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.capgemini.bddexample.database.MySQLRequests;
import com.capgemini.bddexample.database.contract.BaseContract;
import com.capgemini.bddexample.model.BaseDAOItem;
import com.capgemini.bddexample.model.User;

public abstract class BaseDAO<T extends BaseDAOItem> {
	
	protected MySQLRequests rq;
	protected BaseContract contract;
	
	public BaseDAO(BaseContract contract) {
		rq = new MySQLRequests();
		this.contract = contract;
	}
	
	public T select(int id) {
		ResultSet rs = this.rq
				.select("SELECT * FROM " + contract.getTableName() 
					+ " WHERE " + contract.getAliasedFields()[0] + " = " + id);

		return resultSetToObject(rs);
	}

	public List<T> select() {
		List<T> users = new ArrayList<T>();
		
		ResultSet rs = this.rq.select("SELECT * FROM " + contract.getTableName());

		return resultSetToObjects(rs);
	}

	public void insert(T item) {
		rq.other("INSERT INTO " + contract.getTableName() 
			+ " VALUES(" 
				+ "null," 
				+ getInsertProperties(item)
			+ ")");
	}
	
	public void insert2(T item) {
		rq.other("INSERT INTO " + contract.getTableName() 
			+ " VALUES(" 
				+ "null," 
				+ getInsertProperties(item)
			+ ")");
	}

	public void update(T item) {
		rq.other("UPDATE " + contract.getTableName() 
			+ " SET " 
				+ getUpdateProperties(item)
				+ " WHERE " + contract.getAliasedFields()[0] + " = " + item.getId());
	}

	public void delete(T item) {
		rq.other("DELETE FROM " + contract.getTableName() 
			+ " WHERE " + contract.getAliasedFields()[0] + " = " + item.getId());
	}

	protected abstract T resultSetToObject(ResultSet rs);
	protected abstract List<T> resultSetToObjects(ResultSet rs);
	protected abstract String getInsertProperties(T item);
	protected abstract String getUpdateProperties(T item);

}
