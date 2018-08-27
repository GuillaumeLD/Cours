// Peut etre supprimé

// Tous les CRUD sont généralisés dans le DAO

package com.capgemini.bddexample.database.crud;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.capgemini.bddexample.database.MySQLRequests;
import com.capgemini.bddexample.database.contract.UserContract;
import com.capgemini.bddexample.model.User;

public class UserCRUD {

	private MySQLRequests rq;

	public UserCRUD() {
		super();
		rq = new MySQLRequests();
	}

	public User select(int id) {
		User item = new User();

		ResultSet rs = this.rq.select(
				"SELECT * FROM " + UserContract.TABLE_NAME 
				+ " WHERE " + UserContract.ALIASED_ID + " = " + id);
		
		try {
			while (rs.next()) {
				item.setId(rs.getInt(1));
				item.setName(rs.getString(2));
				item.setLogin(rs.getString(3));
				item.setPassword(rs.getString(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return item;
	}

	public List<User> select() {
		List<User> users = new ArrayList<User>();
		User item = new User();

		ResultSet rs = this.rq.select("SELECT * FROM " + UserContract.TABLE_NAME);
		
		try {
			while (rs.next()) {
				users.add(
						new User(
								rs.getInt(1),
								rs.getString(2),
								rs.getString(3),
								rs.getString(4)
								));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return users;
	}
	
	public void insert(User item) {
		rq.other("INSERT INTO " + UserContract.TABLE_NAME 
				+ " VALUES(null,"
					+ "'" + item.getName() + "',"
					+ "'" + item.getLogin() + "',"
					+ "'" + item.getPassword() + "'"
				+ ")");

	}

	public void update(User item) {
		 rq.other("UPDATE " + UserContract.TABLE_NAME 
	                + " SET " 
	                    + UserContract.ALIASED_NAME + " = '" + item.getName() +"'," 
	                    + UserContract.ALIASED_LOGIN + " = '" + item.getLogin() +"',"
	                    + UserContract.ALIASED_PASSWORD + " = '" + item.getPassword() +"'"
	                + " WHERE " + UserContract.ALIASED_ID + " = " + item.getId());

	}

	public void delete(User item) {
		rq.other("DELETE FROM " + UserContract.TABLE_NAME
				+ " WHERE " + UserContract.ALIASED_ID + " = " + item.getId());

	}

}
