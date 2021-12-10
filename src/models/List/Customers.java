package models.List;

import java.util.ArrayList;
import java.util.List;

import entities.CustomerEntity;

public class Customers {
	private List<CustomerEntity> customers;
	
	public Customers() {
		// TODO Auto-generated constructor stub
		super();
		this.customers = new ArrayList<CustomerEntity>();
	}

	public Customers(List<CustomerEntity> customers) {
		super();
		this.customers = customers;
	}

	public List<CustomerEntity> getCustomers() {
		return customers;
	}

	public void setCustomers(List<CustomerEntity> customers) {
		this.customers = customers;
	}
	
	
}
