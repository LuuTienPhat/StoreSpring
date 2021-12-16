package models.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.AccountEntity;

public class AccountDAO extends DAO {

	public AccountDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	public AccountEntity getAccount(String adminId, String username, String email) {
		AccountEntity account = null;
		Session session = factory.openSession();
		try {
			String hql = "FROM AccountEntity WHERE username = '" + username + "' AND id = '" + adminId
					+ "' AND admin.email = '" + email + "'";
			Query query = session.createQuery(hql);
			account = (AccountEntity) query.list().get(0);
		} catch (Exception e) {

		} finally {
			session.close();
		}
		return account;
	}

	public AccountEntity getAccountAuth(String username, String password) {
		AccountEntity account = null;
		Session session = factory.openSession();
		try {
			String hql = "FROM AccountEntity WHERE username = '" + username + "' AND password = '" + password + "'";
			Query query = session.createQuery(hql);
			account = (AccountEntity) query.list().get(0);
		} catch (Exception e) {

		} finally {
			session.close();
		}
		return account;
	}

	public AccountEntity getAccount(String adminId, String recoveryCode) {
		AccountEntity account = null;
		Session session = factory.openSession();
		try {
			String hql = "FROM AccountEntity WHERE id = '" + adminId + "' AND recovery = '" + recoveryCode + "'";
			Query query = session.createQuery(hql);
			account = (AccountEntity) query.list().get(0);
		} catch (Exception e) {

		} finally {
			session.close();
		}
		return account;
	}

	public void updateAccount(AccountEntity account) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(account);
			t.commit();
			System.out.println("Account is updated");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating account");
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

}
