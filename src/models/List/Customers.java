package models.List;

import java.util.ArrayList;
import java.util.List;

import entities.CustomerEntity;

public class Customers {
	private List<CustomerEntity> list;

	public Customers() {
		// TODO Auto-generated constructor stub
		super();
		this.list = new ArrayList<CustomerEntity>();
	}

	public Customers(List<CustomerEntity> customers) {
		super();
		this.list = customers;
	}

	public List<CustomerEntity> getList() {
		return list;
	}

	public void setList(List<CustomerEntity> customers) {
		this.list = customers;
	}

}
