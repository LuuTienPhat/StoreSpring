package models.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.AdminEntity;
import models.List.Admins;

@Transactional
public class AdminDAO extends DAO {

	public AdminDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	public Admins getAdmins() {
		Session session = factory.openSession();
		String hql = "FROM AdminEntity";
		Query query = session.createQuery(hql);
		List<AdminEntity> list = query.list();
		Admins admins = new Admins(list);
		return admins;
	}

	public AdminEntity getAdmin(String adminId) {
		Session session = factory.openSession();
		String hql = "FROM AdminEntity WHERE id = '" + adminId + "'";
		Query query = session.createQuery(hql);

		if (query.list().isEmpty()) {
			session.close();
			return null;
		} else {
			AdminEntity admin = (AdminEntity) query.list().get(0);
			session.close();
			return admin;
		}
	}

	// ADD ADMIN IN DB
	public boolean addAdminInDB(AdminEntity admin) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(admin);
			t.commit();
			System.out.println("Admin is added");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when adding admin");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// UPDATE ADMIN IN DB
	public boolean updateAdminInDB(AdminEntity admin) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(admin);
			t.commit();
			System.out.println("Admin is updated");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating admin");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
}
