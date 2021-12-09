package models.List;

import java.util.ArrayList;
import java.util.List;

import entities.OrderEntity;

public class Orders {
	private List<OrderEntity> orders;

	public List<OrderEntity> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderEntity> orders) {
		this.orders = orders;
	}

	public Orders(List<OrderEntity> orders) {
		super();
		this.orders = orders;
	}

	public Orders() {
		// TODO Auto-generated constructor stub
		this.orders = new ArrayList<OrderEntity>();
	}

	public float getGrossRevenueOfAllOrders() {
		float revenue = 0;
		for (OrderEntity order : orders) {
			revenue += order.getTotalPrice();
		}
		return revenue;
	}
}
