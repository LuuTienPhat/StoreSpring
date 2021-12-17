package models.dao;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.ProductEntity;
import models.List.Products;

@Transactional
public class ProductDAO extends DAO {
	public ProductDAO(SessionFactory factory) {
		super(factory);
		// TODO Auto-generated constructor stub
	}

	// GET PRODUCTS
	public Products getProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		Products products = new Products(list);
		session.close();
		return products;
	}

	// GET PRODUCTS FROM BEGIN DATE TO END DATE
	public Products getProducts(LocalDate beginDate, LocalDate endDate) throws IOException {
		String beginDateString = beginDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));
		String endDateString = endDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd"));

		Session session = factory.openSession();
		String hql = "FROM ProductEntity p WHERE p.dateAdded BETWEEN '" + beginDateString + "' AND '" + endDateString
				+ "'";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		Products products = new Products(list);
		session.close();
		return products;
	}

	// GET TOP FAVORITE PRODUCTS
	public Products getTopFavoriteProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity p ORDER BY p.favoriteProducts.size DESC";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		Products products = new Products(list);
		session.close();
		return products;
	}

	// GET MOST VIEWED PRODUCTS
	public Products getMostViewedProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity p ORDER BY p.views DESC ";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		Products products = new Products((ArrayList<ProductEntity>) list);
		session.close();
		return products;
	}

	// GET PRODUCT WITH ID
	public ProductEntity getProduct(String id) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		ProductEntity product = (ProductEntity) query.list().get(0);
		session.close();
		return product;
	}

	// GET PRODUCT WITH CATEGORY ID
	public ProductEntity getProductsInCategory(String categoryId) {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity WHERE category_id = '" + categoryId + "'";
		Query query = session.createQuery(hql);
		ProductEntity product = (ProductEntity) query.list().get(0);
		session.close();
		return product;
	}

	// SEARCH PRODUCT
	public Products searchForProduct(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity p WHERE p.name LIKE :keyword OR p.category.name LIKE:keyword OR p.quantity LIKE:keyword OR p.unit LIKE:keyword OR p.price LIKE:keyword OR p.id LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<ProductEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		Products products = new Products(list);
		session.close();
		return products;
	}

	// ADD PRODUCT TO DB
	public boolean addProductToDB(ProductEntity product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(product);
			t.commit();
			System.out.println("Product is Added");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when adding product");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// UPDATE PRODUCT IN DB
	public boolean updateProductInDB(ProductEntity product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(product);
			t.commit();
			System.out.println("Product is updated");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating product");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	// DELETE PRODUCT IN DB
	public boolean deleteProductInDB(ProductEntity product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(product);
			t.commit();
			System.out.println("Product is deleted");
			return true;

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when deleting product");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
}
