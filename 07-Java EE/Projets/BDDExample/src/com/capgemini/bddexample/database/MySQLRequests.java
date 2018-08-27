package com.capgemini.bddexample.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLRequests {

	private Statement st;

	public ResultSet select(String request) {
		ResultSet rs = null;
		try {
			st = MySQLOpenHelper.getInstance().getCon().createStatement();
			rs = st.executeQuery(request);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			return rs;
		}
	}

	public void other(String request) {
		try {
			st = MySQLOpenHelper.getInstance().getCon().createStatement();
			st.executeUpdate(request);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
