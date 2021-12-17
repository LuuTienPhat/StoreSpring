package models.dao;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.OrderDetailEntity;
import entities.OrderEntity;
import entities.ProductEntity;
import models.List.Orders;
import models.statistics.OrderStatistics;

@Transactional
public class OrderDAO extends DAO {

	public OrderDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	// GET ORDERS
	public Orders getOrders() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET ORDERS
	public Orders getOrders(String state) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.state = '" + state + "'";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET ORDERS
	public Orders getOrders(String state, String orderBy) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.state = '" + state + "' AND ORDER BY o.orderDate '" + orderBy + "'";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET ORDERS FROM BEGIN DATE TO END DATE
	public Orders getOrders(LocalDate beginDate, LocalDate endDate) throws IOException {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.orderDate BETWEEN '" + beginDateString + "' AND '" + endDateString
				+ "'";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET ORDERS FROM BEGIN DATE TO END DATE
	public Orders getOrders(LocalDate beginDate, LocalDate endDate, String state) throws IOException {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.state = '" + state + "' AND o.orderDate BETWEEN '" + beginDateString
				+ "' AND '" + endDateString + "'";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET ORDERS FROM BEGIN DATE TO END DATE
	public Orders getOrders(LocalDate beginDate, LocalDate endDate, String state, String orderBy) throws IOException {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.state = '" + state + "' AND o.orderDate BETWEEN '" + beginDateString
				+ "' AND '" + endDateString + "' ORDER BY o.orderDate '" + orderBy + "'";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// SEARCH ORDER
	public Orders searchForOrder(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.shipName LIKE :keyword OR o.id LIKE:keyword OR o.ship_note LIKE:keyword OR o.ship_address LIKE:keyword OR o.ship_phone LIKE:keyword OR o.state LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<OrderEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET ORDERS FROM DB WITH STATE
	public Orders getOrders(int state) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity WHERE state = '" + state + "'";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET LATEST ORDERS FROM DB WITH STATE = 0;
	public Orders getLatestOrders(String state, String orderBy) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity o WHERE o.state = '" + state + "' ORDER BY o.orderDate " + orderBy + "";
		Query query = session.createQuery(hql);
		List<OrderEntity> list = query.list();
		Orders orders = new Orders(list);
		session.close();
		return orders;
	}

	// GET SINGLE ORDER
	public OrderEntity getOrder(String id) {
		Session session = factory.openSession();
		String hql = "FROM OrderEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		OrderEntity order = (OrderEntity) query.list().get(0);
		session.close();
		return order;
	}

	public Boolean updateOrderInDB(OrderEntity order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(order);
			t.commit();
			System.out.println("Order is updated");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating orders");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// UPDATE PRODUCTS QUANTITY WHEN FINISH ORDER
	public void updateProducts(List<OrderDetailEntity> orderDetailList) throws IOException {
		ProductDAO productDAO = new ProductDAO(factory);

		for (OrderDetailEntity orderDetail : orderDetailList) {
			ProductEntity product = productDAO.getProduct(orderDetail.getProduct().getId());
			int newQuantity = product.getQuantity() - orderDetail.getQuantity();
			product.setQuantity(newQuantity);

			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.merge(product);
				t.commit();
				System.out.println("Product quantity is updated");

			} catch (Exception e) {
				t.rollback();
				System.out.println("Error when updating product quantity");
				e.printStackTrace();
			} finally {
				session.close();
			}
		}
	}

	// GET GROSS REVENUE OF ALL ORDERS IN THIS MONTH
	public float getGrossRevenueOfAllOrdersInThisMonth() throws IOException {
		LocalDate now = LocalDate.now();
		LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
		LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

		String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM OrderEntity WHERE orderDate >= '" + firstDayOfMonthString + "' AND orderDate <= '"
				+ lastDayOfMonthString + "' AND state = '3'";
		Query query = session.createQuery(hql);
//		Orders orders = query.list();

		float revenue = 0;
//		for (OrderEntity order : orders) {
//			revenue += order.getTotalPrice();
//		}
//		session.close();
		return revenue;
	}

	// GET GROSS REVENUE OF ALL ORDERS IN CHOSEN MONTH
	public float getGrossRevenueOfAllOrders(String month) throws IOException {
		LocalDate lastDayOfMonth = LocalDate.parse(month, DateTimeFormatter.ofPattern("M"))
				.with(TemporalAdjusters.lastDayOfMonth());
		LocalDate firstDayOfMonth = LocalDate.parse(month, DateTimeFormatter.ofPattern("M"))
				.with(TemporalAdjusters.firstDayOfMonth());

		String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM OrderEntity WHERE orderDate >= '" + firstDayOfMonthString + "' AND orderDate <= '"
				+ lastDayOfMonthString + "' AND state = '3'";
		Query query = session.createQuery(hql);
		// Orders orders = query.list();

		float revenue = 0;
//		for (OrderEntity order : orders) {
//			revenue += order.getTotalPrice();
//		}
//		session.close();
		return revenue;
	}

	// GET ORDER STATISTICS
	public List<OrderStatistics> getOrderStatistics() throws IOException {
		List<OrderStatistics> orderStatisticsByMonths = new ArrayList<OrderStatistics>();

		for (int i = 0; i < 6; i++) {
			LocalDate now = LocalDate.now().minusMonths(i);
			LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
			LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

			String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

			Session session = factory.openSession();
			String hql = "FROM OrderEntity WHERE orderDate >= '" + firstDayOfMonthString + "' AND orderDate <= '"
					+ lastDayOfMonthString + "' AND state = '3'";
			Query query = session.createQuery(hql);

			OrderStatistics orderStatistics = new OrderStatistics();
			orderStatistics.setDate(java.sql.Date.valueOf(now));
			orderStatistics.setNumber(query.list().size());
			orderStatisticsByMonths.add(orderStatistics);
		}

		return orderStatisticsByMonths;
	}
}
