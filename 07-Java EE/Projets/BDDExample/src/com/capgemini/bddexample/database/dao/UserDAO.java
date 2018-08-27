package com.capgemini.bddexample.database.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.capgemini.bddexample.database.MySQLRequests;
import com.capgemini.bddexample.database.contract.BaseContract;
import com.capgemini.bddexample.database.contract.UserContract;
import com.capgemini.bddexample.model.User;

public class UserDAO extends BaseDAO<User> {

	public UserDAO() {
		super(new UserContract());
	}

	
	@Override
	protected User resultSetToObject(ResultSet rs) {
		User item = new User();
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

	@Override
	protected List<User> resultSetToObjects(ResultSet rs) {
		List<User> users = new ArrayList<User>();
		
		try {
			while (rs.next()) {
				users.add(
						new User(
								rs.getInt(1),
								rs.getString(2),
								rs.getString(3),
								rs.getString(4)));			
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return users;
	}

	@Override
	protected String getInsertProperties(User item) {
		StringBuilder sb = new StringBuilder();
		sb.append("'" + item.getName() + "',");
		sb.append("'" + item.getLogin() + "',");
		sb.append("'" + item.getPassword() + "'");
		return sb.toString();
	}

	@Override
	protected String getUpdateProperties(User item) {
		StringBuilder sb = new StringBuilder();
		sb.append(contract.getAliasedFields()[1] + " = '" + item.getName() + "',");
		sb.append(contract.getAliasedFields()[2] + " = '" + item.getLogin() + "'," );
		sb.append(contract.getAliasedFields()[3] + " = '" + item.getPassword() + "'");
		return sb.toString();		
	}
	
	// On peut créer ici la fonction de récupération du login et mot de passe d'un utilisateur (par exemple)
}
