package models.List;

import java.util.ArrayList;
import java.util.List;

public class Categories {
	private List<Categories> categories;

	public Categories() {
		// TODO Auto-generated constructor stub
		categories = new ArrayList<Categories>();
	}

	public Categories(List<Categories> categories) {
		// TODO Auto-generated constructor stub
		this.categories = categories;
	}

	public List<Categories> getCategories() {
		return categories;
	}

	public void setCategories(List<Categories> categories) {
		this.categories = categories;
	}
}
