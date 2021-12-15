package models.List;

import java.util.List;

import entities.AdminEntity;

public class Admins {
	private List<AdminEntity> list;

	public Admins(List<AdminEntity> list) {
		super();
		this.list = list;
	}

	public Admins() {
		// TODO Auto-generated constructor stub
	}

	public List<AdminEntity> getList() {
		return list;
	}

	public void setList(List<AdminEntity> list) {
		this.list = list;
	}

	public static boolean isUserNameExist(Admins admins, String username) {
		for (AdminEntity admin : admins.getList()) {
			if (admin.getAccount().getUsername().equals(username))
				return true;
		}
		return false;
	}

}
