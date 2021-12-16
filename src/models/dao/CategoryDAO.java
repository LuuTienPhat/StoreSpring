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
import entities.CategoryEntity;
import models.List.Categories;

@Transactional
public class CategoryDAO extends DAO {
	public CategoryDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	// GET CATEGORIES FROM DB
	public Categories getCategories() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> list = query.list();
		Categories categories = new Categories(list);
		session.close();
		return categories;
	}

	// GET SINGLE CATEGORY
	public CategoryEntity getCategory(String id) {
		Session session = factory.openSession();
		String hql = "FROM CategoryEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		CategoryEntity category = (CategoryEntity) query.list().get(0);
		session.close();
		return category;
	}

	// GET CATEGORIES FROM BEGIN DATE TO END DATE
	public Categories getCategories(LocalDate beginDate, LocalDate endDate) {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM CategoryEntity c WHERE c.dateAdded BETWEEN '" + beginDateString + "' AND '" + endDateString
				+ "'";
		Query query = session.createQuery(hql);
		List<CategoryEntity> list = query.list();
		Categories categories = new Categories(list);
		session.close();
		return categories;
	}

	// SEARCH CATEGORY
	public Categories searchForCategory(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM CategoryEntity c WHERE c.name LIKE :keyword OR c.id LIKE:keyword OR c.description LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<CategoryEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		Categories categories = new Categories(list);
		session.close();
		return categories;
	}

	// ADD CATEGORY TO DB
	public boolean addCategoryInDB(CategoryEntity category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(category);
			t.commit();
			System.out.println("Category is added");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when adding category");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// UPDATE CATEGORY IN DB
	public boolean updateCategoryInDB(CategoryEntity category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(category);
			t.commit();
			System.out.println("Category is udpated");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating category");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// DELETE CATEGORY IN DB
	public boolean deleteCategoryInDB(CategoryEntity category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(category);
			t.commit();
			System.out.println("Category is deleted");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when deleting category");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
}
