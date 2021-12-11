package models.statistics;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjuster;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import entities.OrderEntity;
import entities.ProductEntity;
import models.Revenue;
import models.List.Orders;
import models.List.Customers;
import models.List.Invoices;
import models.List.Orders;

public class Statistics {
	private SessionFactory factory;

	public Statistics(SessionFactory factory) {
		this.factory = factory;
	}

	// GET MONTHLY REVENUE
	public List<Revenue> getMonthlyRevenue(int numberOfMonths) {
		List<Revenue> montlyRevenue = new ArrayList<Revenue>();

		for (int i = 0; i < numberOfMonths; i++) {
			LocalDate now = LocalDate.now().minusMonths(i);
			LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
			LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

			String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

			Session session = factory.openSession();
			String hql = "FROM OrderEntity WHERE orderDate >= '" + firstDayOfMonthString + "' AND orderDate <= '"
					+ lastDayOfMonthString + "' AND state = '3'";
			Query query = session.createQuery(hql);

			float money = 0;
			for (OrderEntity order : (List<OrderEntity>) query.list()) {
				money += order.getTotalPrice();
			}

			Revenue revenue = new Revenue(java.sql.Date.valueOf(now), money);
			montlyRevenue.add(0, revenue);
		}

		return montlyRevenue;
	}

	// GET DAILY REVENUE
	public List<Revenue> getDailyRevenue(int numberOfMonths) {
		List<Revenue> montlyRevenue = new ArrayList<Revenue>();

		for (int i = 0; i < numberOfMonths; i++) {
			LocalDate now = LocalDate.now().minusMonths(i);
			LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
			LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

			String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

			Session session = factory.openSession();
			String hql = "FROM OrderEntity WHERE orderDate >= '" + firstDayOfMonthString + "' AND orderDate <= '"
					+ lastDayOfMonthString + "' AND state = '3'";
			Query query = session.createQuery(hql);

			float money = 0;
			for (OrderEntity order : (List<OrderEntity>) query.list()) {
				money += order.getTotalPrice();
			}

			Revenue revenue = new Revenue(java.sql.Date.valueOf(now), money);
			montlyRevenue.add(0, revenue);
		}

		return montlyRevenue;
	}

	// GET TOP FAVORITE PRODUCTS
	public List<ProductEntity> gettopFavoriteProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity p ORDER BY p.favoriteProducts.size DESC";
		Query query = session.createQuery(hql);
		List<ProductEntity> products = query.list();
		session.close();
		return products;
	}

	// GET MOST VIEWED PRODUCT
	public List<ProductEntity> getMostViewedProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity p ORDER BY p.views DESC ";
		Query query = session.createQuery(hql);
		List<ProductEntity> products = query.list();
		session.close();
		return products;
	}

	// GET TOP REVENUE PRODUCTS IN ORDERS IN THIS MONTH
	public List getTopGrossRevenueProductsInOrdersInThisMonth() throws IOException {
		LocalDate now = LocalDate.now();
		String lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth())
				.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth())
				.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "from ProductEntity p LEFT JOIN p.orderDetails od LEFT JOIN od.order o WHERE o.orderDate between '"
				+ firstDayOfMonth + "' AND '" + lastDayOfMonth
				+ "' AND o.state = '3' ORDER BY (od.quantity * p.price) DESC";
		Query query = session.createQuery(hql);
		List products = query.list();
		session.close();
		return products;
	}

	// GET GROSS REVENUE ORDERS TODAY
	public Orders getOrdersToday() throws IOException {
		LocalDate now = LocalDate.now();
		/*
		 * String today = now.format(DateTimeFormatter.ofPattern("uuuu-MM-dd")); Date
		 * date = new Date();
		 * 
		 * Session session = factory.openSession(); String hql =
		 * "from OrderEntity o WHERE o.orderDate =:date"; Query query =
		 * session.createQuery(hql).setParameter("date", date); List<OrderEntity>
		 * orders2 = query.list();
		 */
		Orders orders = getOrders(now, now.plusDays(1));
		// session.close();
		return orders;

		/*
		 * float revenue = 0; for (OrderEntity order : orders) { revenue +=
		 * order.getTotalPrice(); } return revenue;
		 */
	}

	// GET GROSS REVENUE ORDERS YESTERDAY
	public Orders getOrdersYesterDay() throws IOException {
		LocalDate yesterday = LocalDate.now().minusDays(1);
		Orders orders = getOrders(yesterday, LocalDate.now());
		/* session.close(); */
		return orders;
	}

	// GET GROSS REVENUE ORDERS TODAY
	public float getRatioOfOrdersComparedToYesterday() throws IOException {
		Orders todayOrders = getOrdersToday();
		Orders yesterdayOrders = getOrdersYesterDay();
		float revenueToday = todayOrders.getGrossRevenueOfAllOrders();
		float revenueYesterDay = yesterdayOrders.getGrossRevenueOfAllOrders();
		if (revenueToday == revenueYesterDay)
			return 0;
		else if (revenueYesterDay == 0) {
			return ((revenueYesterDay + revenueToday) / revenueToday) * 100;
		} else
			return ((revenueToday - revenueYesterDay) / revenueYesterDay) * 100;
	}

	// GET MONTH OVER MONTH REVENUE
	public float getMonthOverMonthGrowthRateOfRevenue() throws IOException {
		LocalDate now = LocalDate.now();

		Orders ordersThisMonth = getOrders(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Orders ordersLastMonth = getOrders(now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float revenueThisMonth = ordersThisMonth.getGrossRevenueOfAllOrders();
		float revenueLastMonth = ordersLastMonth.getGrossRevenueOfAllOrders();
		if (revenueThisMonth == revenueLastMonth)
			return 0;
		else if (revenueLastMonth == 0) {
			return ((revenueLastMonth + revenueThisMonth) / revenueThisMonth) * 100;
		} else
			return ((revenueThisMonth - revenueLastMonth) / revenueLastMonth) * 100;
	}

	// GET INVOICES BY MONTH
	public Invoices getInvoicesByMonth(LocalDate month) throws IOException {
		String lastDayOfMonth = month.with(TemporalAdjusters.lastDayOfMonth())
				.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String firstDayOfMonth = month.with(TemporalAdjusters.firstDayOfMonth())
				.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "from InvoiceEntity i WHERE i.date BETWEEN '" + firstDayOfMonth + "' AND '" + lastDayOfMonth + "'";
		Query query = session.createQuery(hql);
		/* Orders orders = new Orders(query.list()); */
		Invoices invoices = new Invoices(query.list());
		session.close();
		return invoices;
	}

	// GET GROWTH PERCENTAGE OF INVOICES BY MONTH
	public float getMonthOverMonthGrowthRateOfInvoices() throws IOException {
		LocalDate now = LocalDate.now();

		Invoices invoicesRegiteredThisMonth = getInvoicesByMonth(now);
		Invoices invoicesRegiteredLastMonth = getInvoicesByMonth(now.minusMonths(1));

		float numberOfInvoiceRegisteredThisMonth = invoicesRegiteredThisMonth.getInvoices().size();
		float numberOfInvoiceRegisteredLastMonth = invoicesRegiteredLastMonth.getInvoices().size();
		if (numberOfInvoiceRegisteredThisMonth == numberOfInvoiceRegisteredLastMonth)
			return 0;
		else if (numberOfInvoiceRegisteredLastMonth == 0) {
			return ((numberOfInvoiceRegisteredLastMonth + numberOfInvoiceRegisteredThisMonth)
					/ numberOfInvoiceRegisteredThisMonth) * 100;
		} else
			return ((numberOfInvoiceRegisteredThisMonth - numberOfInvoiceRegisteredLastMonth)
					/ numberOfInvoiceRegisteredLastMonth) * 100;
	}

	// GET CUSTOMERS BY MONTH
	public Customers getCustomersByMonth(LocalDate month) throws IOException {
		String lastDayOfMonth = month.with(TemporalAdjusters.lastDayOfMonth())
				.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String firstDayOfMonth = month.with(TemporalAdjusters.firstDayOfMonth())
				.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "from CustomerEntity i WHERE i.dateAdded BETWEEN '" + firstDayOfMonth + "' AND '" + lastDayOfMonth
				+ "'";
		Query query = session.createQuery(hql);
		/* Orders orders = new Orders(query.list()); */
		Customers users = new Customers(query.list());
		session.close();
		return users;
	}

	// GET GROWTH PERCENTAGE OF USERS BY MONTH
	public float getMonthOverMonthGrowthRateOfCustomers() throws IOException {
		LocalDate now = LocalDate.now();

		Customers customersRegiteredThisMonth = getCustomersByMonth(now);
		Customers customersRegiteredLastMonth = getCustomersByMonth(now.minusMonths(1));

		float numberOfCustomerRegisteredThisMonth = customersRegiteredThisMonth.getCustomers().size();
		float numberOfCustomerRegisteredLastMonth = customersRegiteredLastMonth.getCustomers().size();
		if (numberOfCustomerRegisteredThisMonth == numberOfCustomerRegisteredLastMonth)
			return 0;
		else if (numberOfCustomerRegisteredLastMonth == 0) {
			return ((numberOfCustomerRegisteredLastMonth + numberOfCustomerRegisteredThisMonth)
					/ numberOfCustomerRegisteredThisMonth) * 100;
		} else
			return ((numberOfCustomerRegisteredThisMonth - numberOfCustomerRegisteredLastMonth)
					/ numberOfCustomerRegisteredLastMonth) * 100;
	}

	// GET ORDERS WITH SPECIFIC BEGIN AND END DATE
	public Orders getOrders(LocalDate beginDate, LocalDate endDate) throws IOException {
		String firstDayOfMonth = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String lastDayOfMonth = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "from OrderEntity o WHERE o.orderDate BETWEEN '" + firstDayOfMonth + "' AND '" + lastDayOfMonth
				+ "'";
		Query query = session.createQuery(hql);
		/* Orders orders = new Orders(query.list()); */
		Orders orders = new Orders(query.list());
		session.close();
		return orders;
	}

	// GET GROWTH PERCENTAGE OF ORDERS
	public float getMonthOverMonthGrowthRateOfOrders() throws IOException {
		LocalDate now = LocalDate.now();

		Orders ordersThisMonth = getOrders(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Orders ordersLastMonth = getOrders(now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float numberOfOrdersThisMonth = ordersThisMonth.getOrders().size();
		float numberOfOrdersLastMonth = ordersLastMonth.getOrders().size();
		if (numberOfOrdersThisMonth == numberOfOrdersLastMonth)
			return 0;
		else if (numberOfOrdersLastMonth == 0) {
			return ((numberOfOrdersLastMonth + numberOfOrdersThisMonth) / numberOfOrdersThisMonth) * 100;
		} else
			return ((numberOfOrdersThisMonth - numberOfOrdersLastMonth) / numberOfOrdersLastMonth) * 100;
	}
}
