package models.List;

import java.util.ArrayList;
import java.util.List;

import entities.CategoryEntity;

public class Categories {
	private List<CategoryEntity> list;

	public Categories() {
		// TODO Auto-generated constructor stub
		list = new ArrayList<CategoryEntity>();
	}

	public Categories(List<CategoryEntity> categories) {
		// TODO Auto-generated constructor stub
		this.list = categories;
	}

	public List<CategoryEntity> getList() {
		return list;
	}

	public void setList(List<CategoryEntity> categories) {
		this.list = categories;
	}
}
