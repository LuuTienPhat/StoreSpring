package controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import entities.AccountEntity;
import entities.AdminEntity;
import entities.CartDetailEntity;
import entities.CategoryEntity;
import entities.CustomerEntity;
import entities.FavoriteProductEntity;
import entities.OrderDetailEntity;
import entities.OrderEntity;
import entities.ProductEntity;

public class Methods {
	
	SessionFactory factory;

	public Methods(SessionFactory factory) {
		super();
		this.factory = factory;
	}
	
	public String createTheNextCustomerId() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.id FROM CustomerEntity c WHERE c.id=(SELECT MAX(cc.id) FROM CustomerEntity cc)";
		Query query = session.createQuery(hql);

		String id = (String) query.uniqueResult();
		if (id == null || id.equals("")) {
			return "U0001";
		}
		int x = Integer.parseInt(id.substring(1)) + 1;
		String base = "U0000";
		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
		String newId = base2 + String.valueOf(x);
		return newId;
	}

	public String createTheNextOrderId() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT o.id FROM OrderEntity o WHERE o.id=(SELECT MAX(oo.id) FROM OrderEntity oo)";
		Query query = session.createQuery(hql);

		String id = (String) query.uniqueResult();
		if (id == null || id.equals("")) {
			return "O000000001";
		}
		int x = Integer.parseInt(id.substring(1)) + 1;
		String base = "O000000000";
		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
		String newId = base2 + String.valueOf(x);
		return newId;
	}

	public List<CategoryEntity> getListCategory() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> list = query.list();
		return list;
	}

	public List<ProductEntity> getTop16RecentProduct() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p ORDER BY p.dateAdded DESC";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.setMaxResults(16).list();
		return list;
	}

	public List<OrderEntity> getCustomerOrder(String customerId) {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderEntity o WHERE o.customerId=:customerId ORDER BY o.orderDate DESC";
		Query query = session.createQuery(hql).setParameter("customerId", customerId);
		List<OrderEntity> list = query.list();
		return list;
	}

	public List<ProductEntity> getAllProducts() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p ORDER BY p.dateAdded DESC";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		return list;
	}

	public List<ProductEntity> searchForProduct(String keyword) {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.name LIKE :keyword OR p.category.name LIKE:keyword ORDER BY p.dateAdded DESC";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<ProductEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		System.out.println(query.toString());
		return list;
	}
	
	public boolean updateCustomerDetail(CustomerEntity customer, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CustomerEntity c SET c.firstname=:firstname, c.lastname=:lastname,"
				+ "c.phone=:phone, c.address=:address, c.email=:email   WHERE c.id=:id";
		Query query = session.createQuery(hql).setParameter("id",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("firstname", customer.getFirstname());
		query.setParameter("lastname", customer.getLastname());
		query.setParameter("phone", customer.getPhone());
		query.setParameter("address", customer.getAddress());
		query.setParameter("email", customer.getEmail());
		return query.executeUpdate() > 0;
	}

	public boolean updateCustomerPassword(CustomerEntity customer, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CustomerEntity c SET c.password=:password WHERE c.id=:id";
		Query query = session.createQuery(hql).setParameter("id",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("password", customer.getPassword());
		return query.executeUpdate() > 0;
	}
	public boolean updateCustomerForgotPassword(CustomerEntity customer, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CustomerEntity c SET c.password=:password WHERE c.id=:id";
		Query query = session.createQuery(hql).setParameter("id",
				customer.getId());
		query.setParameter("password", customer.getPassword());
		return query.executeUpdate() > 0;
	}
	public boolean updateCustomerRecoveryCode(CustomerEntity customer, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CustomerEntity c SET c.recoveryCode=:recoveryCode WHERE c.id=:id";
		Query query = session.createQuery(hql).setParameter("id",
				customer.getId());
		query.setParameter("recoveryCode", AdminAuthController.generateRecoveryCode(5));
		return query.executeUpdate() > 0;
	}
	public boolean updateProductQuantityFromCartDetail(String productId, String quantity, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CartDetailEntity c SET c.quantity=:quantity WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", productId);
		query.setParameter("quantity", Integer.parseInt(quantity));
		return query.executeUpdate() > 0;
	}

	public boolean updateProductQuantity(String productId, int quantity) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE ProductEntity p SET p.quantity=:quantity WHERE p.id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("productId", productId);
		query.setParameter("quantity", quantity);
		return query.executeUpdate() > 0;
	}
	public boolean updateProductViews(String productId, int views) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE ProductEntity p SET p.views=:views WHERE p.id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("productId", productId);
		query.setParameter("views", views);
		return query.executeUpdate() > 0;
	}

	public boolean deleteProductFromCartDetail(String productId, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM CartDetailEntity c WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", productId);

		return query.executeUpdate() > 0;
	}

	public List<CartDetailEntity> getListCartDetail(String customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CartDetailEntity c WHERE c.customer.id =:customerId";
		Query query = session.createQuery(hql);

		List<CartDetailEntity> list = query.setParameter("customerId", customerId).list();
		return list;
	}

	public String getCustomerIdByUserName(String userName) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT id FROM CustomerEntity c WHERE c.username =:userName";
		Query query = session.createQuery(hql);
		String customerId = (String) query.setParameter("userName", userName).uniqueResult();
		return customerId;
	}

	public CustomerEntity getCustomerByUsername(String userName) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity c WHERE c.username =:userName";
		Query query = session.createQuery(hql);
		CustomerEntity customer = (CustomerEntity) query.setParameter("userName", userName).uniqueResult();
		return customer;
	}

	public List<ProductEntity> getListProduct() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		return list;
	}

	public boolean checkOutHibernate(OrderEntity order, List<CartDetailEntity> listCartDetail) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		List<ProductEntity> listProduct = this.getListProduct();

		List<ProductEntity> listProductToBeUpdate = new ArrayList<ProductEntity>();

		for (ProductEntity pe : listProduct) {
			for (CartDetailEntity cde : listCartDetail) {
				if (cde.getProduct().getId().trim().equals(pe.getId())) {
//					System.out.println(pe.getQuantity() +"old quan: "+ pe.getName());
					pe.setQuantity(pe.getQuantity() - cde.getQuantity());// new quantity after update
//					System.out.println(pe.getQuantity() +"new quan: "+ pe.getName());
					listProductToBeUpdate.add(pe);
				}
			}
		}
		List<OrderDetailEntity> listODE = new ArrayList<OrderDetailEntity>();
		for (CartDetailEntity cartDetailEntity : listCartDetail) {
			OrderDetailEntity ode = new OrderDetailEntity(order.getId(), cartDetailEntity.getProduct().getId());
			ode.setQuantity(cartDetailEntity.getQuantity());
			listODE.add(ode);
		}
		boolean updateFlag = false;
		try {
			session.save(order);
			for (CartDetailEntity cartDetailEntity : listCartDetail) {
				session.delete(cartDetailEntity);
			}
			for (OrderDetailEntity ode : listODE) {
				session.save(ode);
			}

			t.commit();
		} catch (Exception ex) {
			t.rollback();
			return false;
		} finally {
			session.close();
			updateFlag = true;
		}
		if (updateFlag == true) {
			for (ProductEntity p : listProductToBeUpdate) {
				if (!updateProductQuantity(p.getId(), p.getQuantity())) {
					return false;
				}
			}
		}
		return true;
	}

	public boolean cartItemIsExit(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.id.product_id FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		String productId = (String) query.uniqueResult();
		return product_id.equals(productId);
	}

	public int getQuantityOfCartItem(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		int quantity = (int) query.uniqueResult();
		return quantity;
	}

	public boolean isProductOutOfStock(String product_id) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT p.quantity FROM ProductEntity p WHERE p.id =:productId";
		Query query = session.createQuery(hql);
		int product = (int) query.setParameter("productId", product_id).uniqueResult();
		return product <= 0;
	}

	public boolean isCartItemMaximumAmountOfProduct(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		int quantityOfCart = (int) query.uniqueResult();
		System.out.println("quantity from cart: " + quantityOfCart);
		hql = "SELECT c.product.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		int quantityOfProduct = (int) query.uniqueResult();
		System.out.println("quantity from product: " + quantityOfProduct);
		return quantityOfCart >= quantityOfProduct;
	}

	public ProductEntity getProduct(String productId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.id =:productId";
		Query query = session.createQuery(hql);

		ProductEntity product = (ProductEntity) query.setParameter("productId", productId).uniqueResult();
		return product;
	}

	public List<ProductEntity> getListProductBycategory(String categoryId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.category.id=:categoryId";
		Query query = session.createQuery(hql);

		List<ProductEntity> list = query.setParameter("categoryId", categoryId).list();
		return list;
	}

	public boolean insertCustomer(CustomerEntity customer) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(customer);
			t.commit();
			System.out.println("Insert successful!");

		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
			System.out.println("Insert unsuccessful!");
			return false;
		} finally {
			session.close();
		}
		return true;
	}

	public boolean isCustomerWithUsernameExit(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity c WHERE c.username=:username";
		Query query = session.createQuery(hql);

		CustomerEntity customer = (CustomerEntity) query.setParameter("username", username).uniqueResult();
		return customer != null;
	}
	public boolean isAdminWithUsernameExit(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM AccountEntity a WHERE a.username=:username";
		Query query = session.createQuery(hql);

		AccountEntity admin = (AccountEntity) query.setParameter("username", username).uniqueResult();
		return admin != null;
	}

	public String getPasswordOfCustomerWithUsername(String username) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.password FROM CustomerEntity c WHERE c.username=:username";
		Query query = session.createQuery(hql);
		String password = (String) query.setParameter("username", username).uniqueResult();
		return password;
	}
	public String getEmailOfCustomerWithUsername(String username) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.email FROM CustomerEntity c WHERE c.username=:username";
		Query query = session.createQuery(hql);
		String email = (String) query.setParameter("username", username).uniqueResult();
		return email;
	}
	public String getRecoveryCodeOfCustomerWithUsername(String username) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.recoveryCode FROM CustomerEntity c WHERE c.username=:username";
		Query query = session.createQuery(hql);
		String recoveryCode = (String) query.setParameter("username", username).uniqueResult();
		return recoveryCode.trim();
	}
	//testing
	public List<FavoriteProductEntity> getListFavourite(String customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM FavoriteProductEntity f WHERE f.customer.id =:customerId";
		Query query = session.createQuery(hql);

		List<FavoriteProductEntity> list = query.setParameter("customerId", customerId).list();
//		for(FavoriteProductEntity f: list) {
//			System.out.println(f.getProduct().getId());
//		}
		return list;
	}
	
	public boolean favItemIsExit(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT f.product.id FROM FavoriteProductEntity f WHERE f.customer.id =:customerId and f.product.id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		String productId = (String) query.uniqueResult();
		return product_id.equals(productId);
	}
	
	public boolean deleteProductFromFavourite(String productId, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM FavoriteProductEntity f WHERE f.customer.id=:customerId and f.product.id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId",
				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", productId);

		return query.executeUpdate() > 0;
	}
	
}
