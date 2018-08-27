package com.capgemini.bddexample.database;

import java.sql.Connection;
import java.sql.SQLException;
import com.mysql.cj.jdbc.MysqlDataSource;

public class MySQLOpenHelper {

	/** Constructeur privé */
	private MySQLOpenHelper() {
		MysqlDataSource dataSource = new MysqlDataSource();

		try {
			dataSource.setUser("root");
			dataSource.setPassword("");
			dataSource.setServerName("localhost");
			dataSource.setDatabaseName("bddExamplePOEI2018");
			dataSource.setCreateDatabaseIfNotExist(true);
			dataSource.setServerTimezone("UTC");
			this.con = dataSource.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/** Instance unique non préinitialisée */
	private static MySQLOpenHelper INSTANCE = null;

	/** Point d'accès pour l'instance unique du singleton */
	public static synchronized MySQLOpenHelper getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new MySQLOpenHelper();
		}
		return INSTANCE;
	}

	private Connection con;

	public Connection getCon() {
		return con;
	}
	
	public void closeConnection() {
		try {
			this.con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
