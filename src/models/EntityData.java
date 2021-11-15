package models;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.web.bind.annotation.ModelAttribute;

import entities.CategoryEntity;
import entities.CustomerEntity;
import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;
import entities.OrderDetailEntity;
import entities.OrderEntity;
import entities.ProductEntity;

@Transactional
public class EntityData {
	private SessionFactory factory;

	public EntityData(SessionFactory factory) {
		this.factory = factory;
	}

	// ==================== CATEGORIES ====================

	// GET CATEGORIES FROM DB
	@ModelAttribute("categories")
	public List<CategoryEntity> getCategories() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> categories = query.list();
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

	// SEARCH CATEGORY
	public List<CategoryEntity> searchForCategory(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM CategoryEntity c WHERE c.name LIKE :keyword OR c.id LIKE:keyword OR c.description LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<CategoryEntity> categories = query.setParameter("keyword", "%" + keyword + "%").list();
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

	// ==================== END OF CATEGORIES ====================

	
	// ==================== PRODUCTS ====================

	// GET PRODUCTS
	public List<ProductEntity> getProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> products = query.list();
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
	public List<ProductEntity> searchForProduct(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity p WHERE p.name LIKE :keyword OR p.category.name LIKE:keyword OR p.quantity LIKE:keyword OR p.unit LIKE:keyword OR p.price LIKE:keyword OR p.id LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<ProductEntity> products = query.setParameter("keyword", "%" + keyword + "%").list();
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

	// ==================== END OF PRODUCTS ====================

	
	// ==================== INVOICES ====================

	// GET INVOICES FROM DB
	public List<InvoiceEntity> getInvoices() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity";
		Query query = session.createQuery(hql);
		List<InvoiceEntity> invoices = query.list();
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
	public List<InvoiceEntity> searchForInvoice(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity i WHERE i.id LIKE :keyword OR i.date LIKE:keyword OR i.time LIKE:keyword OR i.admin.firstname LIKE:keyword OR i.invoiceType.name LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<InvoiceEntity> invoice = query.setParameter("keyword", "%" + keyword + "%").list();
		session.close();
		return invoice;
	}

	// GET INVOICE TYPES
	@ModelAttribute("invoiceTypes")
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

	// ==================== END OF INVOICES ====================

	
	// ==================== CUSTOMERS ====================

	// GET CUSTOMER FROM DB
	public List<CustomerEntity> getCustomers() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM CustomerEntity";
		Query query = session.createQuery(hql);
		List<CustomerEntity> customers = query.list();
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
	public List<CustomerEntity> searchForCustomer(String keyword) {
		Session session = factory.openSession();
		String hql = "FROM CustomerEntity c WHERE c.name LIKE :keyword OR c.id LIKE:keyword OR c.firstname LIKE:keyword OR c.lastname LIKE:keyword OR c.telephone LIKE:keyword OR c.address LIKE:keyword OR c.email LIKE:keyword";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<CustomerEntity> customers = query.setParameter("keyword", "%" + keyword + "%").list();
		session.close();
		return customers;
	}

	// ==================== END OF CUSTOMERS ====================

	
	// ==================== ORDERS ====================

	// GET ORDERS FROM DB
	public List<OrderEntity> getOrders() throws IOException {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderEntity";
		Query query = session.createQuery(hql);
		List<OrderEntity> orders = query.list();
		return orders;
	}

	// GET SINGLE ORDER
	public OrderEntity getOrder(String id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		OrderEntity order = (OrderEntity) query.list().get(0);
		return order;
	}

	// UPDATE PRODUCTS QUANTITY WHEN FINISH ORDER
	public void updateProducts(List<OrderDetailEntity> orderDetailList) throws IOException {
		List<ProductEntity> products = new ArrayList<ProductEntity>();

		for (OrderDetailEntity orderDetail : orderDetailList) {
			ProductEntity product = getProduct(orderDetail.getProduct().getId());
			product.setQuantity(product.getQuantity() - orderDetail.getQuantity());
			products.add(product);
		}

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(products);
			t.commit();
			System.out.println("Products quantity is updated");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating products quantity");
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	// ==================== END OF ORDERS ====================

}
