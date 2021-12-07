package models.statistics;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import entities.OrderEntity;
import entities.ProductEntity;
import models.Revenue;

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
}
