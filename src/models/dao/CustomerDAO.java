package models.dao;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import entities.CustomerEntity;
import models.List.Customers;

@Transactional
public class CustomerDAO extends DAO {

	public CustomerDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	// GET CUSTOMER FROM DB
	public Customers getCustomers() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM CustomerEntity";
		Query query = session.createQuery(hql);
		List<CustomerEntity> list = query.list();
		Customers customers = new Customers(list);
		session.close();
		return customers;
	}

	// GET CUSTOMER FROM BEGIN DATE TO END DATE
	public Customers getCustomers(LocalDate beginDate, LocalDate endDate) throws IOException {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM CustomerEntity c WHERE c.dateAdded BETWEEN '" + beginDateString + "' AND '" + endDateString
				+ "'";
		Query query = session.createQuery(hql);
		List<CustomerEntity> list = query.list();
		Customers customers = new Customers(list);
		session.close();
		return customers;
	}

	// GET SINGLE CUSTOMER
	public CustomerEntity getCustomer(String id) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM CustomerEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		CustomerEntity customer = (CustomerEntity) query.list().get(0);
		session.close();
		return customer;
	}

	// SEARCH CUSTOMER
	public Customers searchForCustomer(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM CustomerEntity c WHERE c.id LIKE:keyword OR c.firstname LIKE:keyword OR c.lastname LIKE:keyword OR c.phone LIKE:keyword OR c.address LIKE:keyword OR c.email LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<CustomerEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		Customers customers = new Customers(list);
		session.close();
		return customers;
	}
}
