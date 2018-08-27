package com.capgemini.bddexample;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.capgemini.bddexample.database.MySQLOpenHelper;
import com.capgemini.bddexample.database.MySQLRequests;
import com.capgemini.bddexample.database.contract.UserContract;
import com.capgemini.bddexample.database.dao.BaseDAO;
import com.capgemini.bddexample.database.dao.UserDAO;
import com.capgemini.bddexample.model.User;

public class Application {

	public static void main(String[] args) {
		
		MySQLRequests req = new MySQLRequests();
		req.other(UserContract.CREATE_TABLE());
		
		req.other("DELETE FROM user");
		req.other("ALTER TABLE user AUTO_INCREMENT = 1");
		
		User jeanMi = new User(0,"jean mi","jean mimi","eljeanmi");
		
		BaseDAO<User> crud = new UserDAO();
		
		crud.insert(jeanMi);
		
		User isJeanMi = crud.select(1);
		jeanMi.setId(isJeanMi.getId());
		System.out.println(isJeanMi.getName());
		
		jeanMi.setName("jeanRaoul");
		crud.update(jeanMi);
		
		User isJeanMi2 = crud.select(1);
		System.out.println(isJeanMi2.getName());
		
		crud.delete(jeanMi);
		for (User user : crud.select()) {
			System.out.println("YOLOOOOOOOOOOOOOOOOOOOOOOO");
		}
		
		MySQLOpenHelper.getInstance().closeConnection();
	}
}
