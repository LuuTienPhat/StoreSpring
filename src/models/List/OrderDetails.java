package models.List;

import java.time.LocalDate;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import entities.OrderDetailEntity;
import models.validator.DateTimeValidator;

public class OrderDetails implements List<OrderDetailEntity> {

	private List<OrderDetailEntity> list;

	public OrderDetails() {
		// TODO Auto-generated constructor stub
	}

	public OrderDetails(List<OrderDetailEntity> list) {
		super();
		this.list = list;
	}

	public List<OrderDetailEntity> getList() {
		return list;
	}

	public void setList(List<OrderDetailEntity> list) {
		this.list = list;
	}

	public float getTotalRevenue() {
		float revenue = 0;
		for (OrderDetailEntity orderDetail : this.list) {
			revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
		}
		return revenue;
	}

	public float getTotalRevenue(LocalDate beginDate, LocalDate endDate) {
		float revenue = 0;
		for (OrderDetailEntity orderDetail : this.list) {
			LocalDate orderDate = DateTimeValidator.convertToLocalDateViaInstant(orderDetail.getOrder().getOrderDate());
			if (orderDate.isAfter(orderDate) && orderDate.isBefore(endDate))
				revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
		}
		return revenue;
	}

	@Override
	public int size() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isEmpty() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean contains(Object o) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Iterator<OrderDetailEntity> iterator() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object[] toArray() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public <T> T[] toArray(T[] a) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean add(OrderDetailEntity e) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Object o) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsAll(Collection<?> c) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean addAll(Collection<? extends OrderDetailEntity> c) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean addAll(int index, Collection<? extends OrderDetailEntity> c) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeAll(Collection<?> c) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean retainAll(Collection<?> c) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void clear() {
		// TODO Auto-generated method stub

	}

	@Override
	public OrderDetailEntity get(int index) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OrderDetailEntity set(int index, OrderDetailEntity element) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void add(int index, OrderDetailEntity element) {
		// TODO Auto-generated method stub

	}

	@Override
	public OrderDetailEntity remove(int index) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int indexOf(Object o) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int lastIndexOf(Object o) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ListIterator<OrderDetailEntity> listIterator() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ListIterator<OrderDetailEntity> listIterator(int index) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderDetailEntity> subList(int fromIndex, int toIndex) {
		// TODO Auto-generated method stub
		return null;
	}

}
