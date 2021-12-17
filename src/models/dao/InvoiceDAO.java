package models.dao;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.web.bind.annotation.ModelAttribute;

import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;
import models.List.Invoices;

@Transactional
public class InvoiceDAO extends DAO {

	public InvoiceDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	// GET INVOICES FROM DB
	public Invoices getInvoices() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity";
		Query query = session.createQuery(hql);
		List<InvoiceEntity> list = query.list();
		Invoices invoices = new Invoices(list);
		session.close();
		return invoices;
	}

	// GET INVOICES FROM BEGIN DATE TO END DATE
	public Invoices getInvoices(LocalDate beginDate, LocalDate endDate) throws IOException {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity i WHERE i.date BETWEEN '" + beginDateString + "' AND '" + endDateString + "'";
		Query query = session.createQuery(hql);
		List<InvoiceEntity> list = query.list();
		Invoices invoices = new Invoices(list);
		session.close();
		return invoices;
	}

	// GET SINGLE INVOICE
	public InvoiceEntity getInvoice(String id) {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		InvoiceEntity invoice = (InvoiceEntity) query.list().get(0);
		session.close();
		return invoice;
	}

	// SEARCH INVOICE
	public Invoices searchForInvoice(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity i WHERE i.id LIKE :keyword OR i.date LIKE:keyword OR i.time LIKE:keyword OR i.admin.firstname LIKE:keyword OR i.invoiceType.name LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<InvoiceEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		Invoices invoice = new Invoices(list);
		session.close();
		return invoice;
	}

	// GET INVOICE TYPES
	public List<InvoiceTypeEntity> getInoivceTypes() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM InvoiceTypeEntity";
		Query query = session.createQuery(hql);
		List<InvoiceTypeEntity> invoiceTypes = query.list();
		session.close();
		return invoiceTypes;
	}

	// ADD INVOICE TO DB
	public boolean addInvoiceToDB(InvoiceEntity invoice) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(invoice);
			t.commit();
			System.out.println("Invoice is Added");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when adding invoice");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// UPDATE INVOICE IN DB
	public boolean updateInvoiceInDB(InvoiceEntity invoice) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(invoice);
			t.commit();
			System.out.println("Invoice is updated");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating invoice");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// DELETE INVOICE FROM DB
	public boolean deleteInvoiceInDB(InvoiceEntity invoice) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(invoice);
			t.commit();
			System.out.println("Invoice is deleted");
			return true;

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when deleting invoice");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
}
