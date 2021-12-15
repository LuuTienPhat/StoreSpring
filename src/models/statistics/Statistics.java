package models.statistics;

import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import entities.OrderEntity;
import entities.ProductEntity;
import models.List.Categories;
import models.List.Customers;
import models.List.Invoices;
import models.List.Orders;
import models.List.Products;
import models.dao.CategoryDAO;
import models.dao.CustomerDAO;
import models.dao.InvoiceDAO;
import models.dao.OrderDAO;
import models.dao.ProductDAO;

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

	// GET TOP REVENUE PRODUCTS IN ORDERS IN THIS MONTH
	public List<TopRevenueProduct> getTopRevenueProductsInOrders() throws IOException, ParseException {
		LocalDate now = LocalDate.now();

		ProductDAO productDAO = new ProductDAO(factory);
		Products products = productDAO.getProducts();

		List<TopRevenueProduct> topRevenueProducts = new ArrayList<TopRevenueProduct>();

		for (ProductEntity product : products.getList()) {
			TopRevenueProduct topRevenueProduct = new TopRevenueProduct();
			topRevenueProduct.setProduct(product);
			topRevenueProduct.setAllTimeRevenue(product.getTotalRevenueInOrders());

			float revenueThisMonth = product.getTotalRevenueInOrders(now.with(TemporalAdjusters.firstDayOfMonth()),
					now.with(TemporalAdjusters.lastDayOfMonth()));
			float revenueLastMonth = product.getTotalRevenueInOrders(
					now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
					now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

			float growthRate = 0;
			if (revenueThisMonth == revenueLastMonth)
				growthRate = 0;
			else if (revenueLastMonth == 0) {
				growthRate = ((revenueLastMonth + revenueThisMonth) / revenueThisMonth) * 100;
			} else
				growthRate = ((revenueThisMonth - revenueLastMonth) / revenueLastMonth) * 100;

			topRevenueProduct.setThisMonthRevenue(revenueThisMonth);
			topRevenueProduct.setGrowthRatePercentage(growthRate);
			topRevenueProducts.add(topRevenueProduct);
		}

		Collections.sort(topRevenueProducts, new Comparator<TopRevenueProduct>() {

			@Override
			public int compare(TopRevenueProduct o1, TopRevenueProduct o2) {
				// TODO Auto-generated method stub
				if (o1.getThisMonthRevenue() > o2.getThisMonthRevenue())
					return -1;
				else if (o1.getThisMonthRevenue() < o2.getThisMonthRevenue())
					return 1;
				else
					return 0;
			}

		});

		return topRevenueProducts;
	}

	// GET GROSS REVENUE ORDERS TODAY
	public float getDayOverDayGrowthRateOfOrders() throws IOException {
		OrderDAO orderDAO = new OrderDAO(factory);
		LocalDate now = LocalDate.now();

		Orders todayOrders = orderDAO.getOrders(now, now.plusDays(1));
		Orders yesterdayOrders = orderDAO.getOrders(now.minusDays(1), now);
		float revenueToday = todayOrders.getTotalRevenue();
		float revenueYesterDay = yesterdayOrders.getTotalRevenue();
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
		OrderDAO orderDAO = new OrderDAO(factory);

		Orders ordersThisMonth = orderDAO.getOrders(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()), "3");
		Orders ordersLastMonth = orderDAO.getOrders(now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()), "3");

		float revenueThisMonth = ordersThisMonth.getTotalRevenue();
		float revenueLastMonth = ordersLastMonth.getTotalRevenue();
		if (revenueThisMonth == revenueLastMonth)
			return 0;
		else if (revenueLastMonth == 0) {
			return ((revenueLastMonth + revenueThisMonth) / revenueThisMonth) * 100;
		} else
			return ((revenueThisMonth - revenueLastMonth) / revenueLastMonth) * 100;
	}

	// GET GROWTH PERCENTAGE OF INVOICES BY MONTH
	public float getMonthOverMonthGrowthRateOfInvoices() throws IOException {
		LocalDate now = LocalDate.now();
		InvoiceDAO invoiceDAO = new InvoiceDAO(factory);

		Invoices thisMonthInvoices = invoiceDAO.getInvoices(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Invoices lastMonthInvoices = invoiceDAO.getInvoices(
				now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float numberOfInvoicesThisMonth = thisMonthInvoices.getList().size();
		float numberOfInvoiceSLastMonth = lastMonthInvoices.getList().size();
		if (numberOfInvoicesThisMonth == numberOfInvoiceSLastMonth)
			return 0;
		else if (numberOfInvoiceSLastMonth == 0) {
			return ((numberOfInvoiceSLastMonth + numberOfInvoicesThisMonth) / numberOfInvoicesThisMonth) * 100;
		} else
			return ((numberOfInvoicesThisMonth - numberOfInvoiceSLastMonth) / numberOfInvoiceSLastMonth) * 100;
	}

	// GET GROWTH PERCENTAGE OF USERS BY MONTH
	public float getMonthOverMonthGrowthRateOfCustomers() throws IOException {
		LocalDate now = LocalDate.now();
		CustomerDAO customerDAO = new CustomerDAO(factory);

		Customers customersRegiteredThisMonth = customerDAO.getCustomers(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Customers customersRegiteredLastMonth = customerDAO.getCustomers(
				now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float numberOfCustomersRegisteredThisMonth = customersRegiteredThisMonth.getList().size();
		float numberOfCustomersRegisteredLastMonth = customersRegiteredLastMonth.getList().size();
		if (numberOfCustomersRegisteredThisMonth == numberOfCustomersRegisteredLastMonth)
			return 0;
		else if (numberOfCustomersRegisteredLastMonth == 0) {
			return ((numberOfCustomersRegisteredLastMonth + numberOfCustomersRegisteredThisMonth)
					/ numberOfCustomersRegisteredThisMonth) * 100;
		} else
			return ((numberOfCustomersRegisteredThisMonth - numberOfCustomersRegisteredLastMonth)
					/ numberOfCustomersRegisteredLastMonth) * 100;
	}

	// GET GROWTH PERCENTAGE OF ORDERS
	public float getMonthOverMonthGrowthRateOfOrders() throws IOException {
		OrderDAO orderDAO = new OrderDAO(factory);

		LocalDate now = LocalDate.now();

		Orders ordersThisMonth = orderDAO.getOrders(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Orders ordersLastMonth = orderDAO.getOrders(now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float numberOfOrdersThisMonth = ordersThisMonth.getList().size();
		float numberOfOrdersLastMonth = ordersLastMonth.getList().size();
		if (numberOfOrdersThisMonth == numberOfOrdersLastMonth)
			return 0;
		else if (numberOfOrdersLastMonth == 0) {
			return ((numberOfOrdersLastMonth + numberOfOrdersThisMonth) / numberOfOrdersThisMonth) * 100;
		} else
			return ((numberOfOrdersThisMonth - numberOfOrdersLastMonth) / numberOfOrdersLastMonth) * 100;
	}

	// GET GROWTH PERCENTAGE OF CATEGORIES
	public float getMonthOverMonthGrowthRateOfCategories() throws IOException {
		CategoryDAO categoryDAO = new CategoryDAO(factory);

		LocalDate now = LocalDate.now();

		Categories thisMonthCategories = categoryDAO.getCategories(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Categories lastMonthCategories = categoryDAO.getCategories(
				now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float numberOfCategoriesThisMonth = thisMonthCategories.getList().size();
		float numberOfCategoriesLastMonth = lastMonthCategories.getList().size();
		if (numberOfCategoriesThisMonth == numberOfCategoriesLastMonth)
			return 0;
		else if (numberOfCategoriesLastMonth == 0) {
			return ((numberOfCategoriesLastMonth + numberOfCategoriesThisMonth) / numberOfCategoriesThisMonth) * 100;
		} else
			return ((numberOfCategoriesThisMonth - numberOfCategoriesLastMonth) / numberOfCategoriesLastMonth) * 100;
	}

	// GET GROWTH PERCENTAGE OF CATEGORIES
	public float getMonthOverMonthGrowthRateOfProducts() throws IOException {
		ProductDAO productDAO = new ProductDAO(factory);

		LocalDate now = LocalDate.now();

		Products thisMonthProducts = productDAO.getProducts(now.with(TemporalAdjusters.firstDayOfMonth()),
				now.with(TemporalAdjusters.lastDayOfMonth()));
		Products lastMonthProducts = productDAO.getProducts(
				now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()),
				now.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()));

		float numberOfProductsThisMonth = thisMonthProducts.getList().size();
		float numberOfProductsLastMonth = lastMonthProducts.getList().size();
		if (numberOfProductsThisMonth == numberOfProductsLastMonth)
			return 0;
		else if (numberOfProductsLastMonth == 0) {
			return ((numberOfProductsLastMonth + numberOfProductsThisMonth) / numberOfProductsThisMonth) * 100;
		} else
			return ((numberOfProductsThisMonth - numberOfProductsLastMonth) / numberOfProductsLastMonth) * 100;
	}
}
