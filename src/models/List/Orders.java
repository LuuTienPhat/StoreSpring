package models.List;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import entities.OrderEntity;
import models.validator.DateTimeValidator;

public class Orders {
	private List<OrderEntity> list;

	public List<OrderEntity> getList() {
		return list;
	}

	public void setList(List<OrderEntity> orders) {
		this.list = orders;
	}

	public Orders(List<OrderEntity> orders) {
		super();
		this.list = orders;
	}

	public Orders() {
		// TODO Auto-generated constructor stub
		this.list = new ArrayList<OrderEntity>();
	}

	public float getTotalRevenue() {
		float revenue = 0;
		for (OrderEntity order : list) {
			revenue += order.getTotalPrice();
		}
		return revenue;
	}

	public static float getTotalRevenue(LocalDate beginDate, LocalDate endDate, Orders orders) {
		float revenue = 0;
		for (OrderEntity order : orders.getList()) {
			LocalDate orderDate = DateTimeValidator.convertToLocalDateViaInstant(order.getOrderDate());
			if (orderDate.isAfter(beginDate) && orderDate.isBefore(endDate)) {
				revenue += order.getTotalPrice();
			}
		}
		return revenue;
	}

	public static Orders getOrders(LocalDate beginDate, LocalDate endDate, Orders orders) {
		List<OrderEntity> list = new ArrayList<OrderEntity>();
		for (OrderEntity order : orders.getList()) {
			LocalDate orderDate = DateTimeValidator.convertToLocalDateViaInstant(order.getOrderDate());
			if (orderDate.isAfter(beginDate) && orderDate.isBefore(endDate)) {
				list.add(order);
			}
		}
		return new Orders(list);
	}

	public static Orders getOrders(LocalDate beginDate, LocalDate endDate, int state, Orders orders) {
		List<OrderEntity> list = new ArrayList<OrderEntity>();
		for (OrderEntity order : orders.getList()) {
			LocalDate orderDate = DateTimeValidator.convertToLocalDateViaInstant(order.getOrderDate());
			if (orderDate.isAfter(beginDate) && orderDate.isBefore(endDate)) {
				if (state == 3)
					list.add(order);
			}
		}
		return new Orders(list);
	}
}
