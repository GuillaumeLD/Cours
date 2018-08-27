package com.capgemini.bddexample.database.contract;

import com.capgemini.bddexample.model.Role;

// Reprendre le même modèle que UserContract, avec les champs de la table Role

public class RoleContract extends BaseContract {

	public static final String TABLE_NAME = "role";

	public static final String ID = "id";

	public RoleContract() {
		super(TABLE_NAME,ID, Role.class);
	}

	@Override
	public String getChildrenCreateFields() {
		return null;
	}

	@Override
	public String[] getFields() {
		return null;
	}

}
