package controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import entities.CartDetailEntity;
import entities.CustomerEntity;
import entities.ProductEntity;

@Transactional
@Controller
@RequestMapping("/store")
public class GiftController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("")
	public String store(ModelMap model) {
		model.addAttribute("list", getListProduct());
		return "store/index";
	}
	
	@RequestMapping("/")
	public String store2(ModelMap model) {
		model.addAttribute("list", getListProduct());
		return "store/index";
	}

	@RequestMapping("/product-detail")
	public String productDetail() {
		return "store/product-detail";
	}
	@RequestMapping("/product-detail/{productId}")
	public String productDetail2(@PathVariable("productId") String productId, ModelMap model) {
		model.addAttribute("product", getProduct(productId));
		System.out.println(productId+"; "+getProduct(productId).getName());
		return "store/product-detail";
	}
	@RequestMapping("/sign-in")
	public String signIn() {
		return "store/sign-in";
	}

	@RequestMapping("/sign-up")
	public String signUp() {
		return "store/sign-up";
	}

	@RequestMapping("/shopping-cart")
	public String shoppingCart(ModelMap model) {
		model.addAttribute("listCartDetail", getListCartDetail(getUserIdByUserName("tuanbui")));

		for (CartDetailEntity c : getListCartDetail(getUserIdByUserName("tuanbui"))) {
			System.out.println("user_id: " + c.getCustomer().getId() + "; product_id: " + c.getProduct().getId()
					+ "; quantity= " + c.getQuantity());
		}
		return "store/shopping-cart";
	}

	public List<CartDetailEntity> getListCartDetail(String customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CartDetailEntity c WHERE c.customer.id =:customerId";
		Query query = session.createQuery(hql);

		List<CartDetailEntity> list = query.setParameter("customerId", customerId).list();
		return list;
	}

	public String getUserIdByUserName(String userName) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT id FROM CustomerEntity c WHERE c.username =:userName";
		Query query = session.createQuery(hql);
		String customerId = (String) query.setParameter("userName", userName).uniqueResult();
		return customerId;
	}

	public List<ProductEntity> getListProduct() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);

		List<ProductEntity> list = query.list();
		return list;
	}

	@RequestMapping(value = "/shopping-cart/delete/{productId}", method = RequestMethod.GET)
	public String delete(@PathVariable("productId") String productId, ModelMap model) {
		System.out.println(productId);
		if (deleteProductFromCartDetail(productId)) {
			System.out.println("Delete successful");
		} else {
			System.out.println("Delete unsuccessful");
		}
//		model.addAttribute("listCartDetail", getListCartDetail(getUserIdByUserName("tuanbui")));
		/*
		 * for (CartDetailEntity c : getListCartDetail(getUserIdByUserName("tuanbui")))
		 * { System.out.println("user_id: " + c.getCustomer().getId() + "; product_id: "
		 * + c.getProduct().getId() + "; quantity= " + c.getQuantity()); }
		 */
		return "redirect:/store/shopping-cart";
	}

	public boolean deleteProductFromCartDetail(String productId) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM CartDetailEntity c WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId", getUserIdByUserName("tuanbui"));
		query.setParameter("productId", productId);

		return query.executeUpdate() > 0;
	}

	@RequestMapping(value = "/shopping-cart/update", method = RequestMethod.POST)
	public String update(HttpServletRequest request) {
		String[] product_ids = request.getParameterValues("product_id");
		String[] quantities = request.getParameterValues("quantity");
		for(int i=0; i<product_ids.length;i++) {
			updateProductQuantityFromCartDetail(product_ids[i], quantities[i]);
		}
		return "redirect:/store/shopping-cart";
	}
	
	public boolean updateProductQuantityFromCartDetail(String productId, String quantity) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CartDetailEntity c SET c.quantity=:quantity WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId", getUserIdByUserName("tuanbui"));
		query.setParameter("productId", productId);
		query.setParameter("quantity", Integer.parseInt(quantity));
		return query.executeUpdate() > 0;
	}
	@RequestMapping("/shopping-cart/insert-into-cart/{productId}")
	public String insertToCart(String customerId, @PathVariable("productId") String productId, HttpServletRequest request) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		CartDetailEntity cde = new CartDetailEntity(getUserIdByUserName("tuanbui"), (productId));
		if(cartItemIsExit(productId)) {
			System.out.println("Exit; increase quantity by 1!");
			if(!isCartItemMaximumAmountOfProduct(productId)) { //nếu số lượng tồn của sản phẩm k bằng số sản phẩm của product đó trong cart
				
				if(updateProductQuantityFromCartDetail(productId, String.valueOf(getQuantityOfCartItem(productId)+1))) {
					System.out.println("Exit; increase quantity by 1 successful!");
					return "redirect:/store/shopping-cart";
				}else {
					System.out.println("Exit; increase quantity by 1 unsuccessful!");
					return "redirect:/store/shopping-cart";
				}
				
			}else {
				System.out.println("Exit; increase quantity by 1 unsuccessful \n because amount of that product incart is equal to its amount in product!");
				return "redirect:/store/shopping-cart";
			}
			
		}else {
			cde.setQuantity(1);
			try {
				session.save(cde);
				t.commit();
				System.out.println("Insert successful!");
				
			}catch(Exception ex) {
				t.rollback();
				System.out.println("Insert unsuccessful!");
			}finally {
				session.close();
			}
		}
		
		 return "redirect:/store/shopping-cart";
	}
	
	public boolean cartItemIsExit(String product_id) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.id.product_id FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", getUserIdByUserName("tuanbui"));
		query.setParameter("productId", product_id);
		String productId = (String) query.uniqueResult();
		return product_id.equals(productId);
	}
	
	public int getQuantityOfCartItem(String product_id) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", getUserIdByUserName("tuanbui"));
		query.setParameter("productId", product_id);
		int quantity = (int) query.uniqueResult();
		return quantity;
	}
	
	public boolean isCartItemMaximumAmountOfProduct(String product_id) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", getUserIdByUserName("tuanbui"));
		query.setParameter("productId", product_id);
		int quantityOfCart = (int) query.uniqueResult();
		System.out.println("quantity from cart: " + quantityOfCart);
	 	hql = "SELECT c.product.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		query = session.createQuery(hql);
		query.setParameter("customerId", getUserIdByUserName("tuanbui"));
		query.setParameter("productId", product_id);
		int quantityOfProduct = (int) query.uniqueResult();
		System.out.println("quantity from product: " + quantityOfProduct);
		return quantityOfCart>=quantityOfProduct;
	}
	
	public ProductEntity getProduct(String productId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.id =:productId";
		Query query = session.createQuery(hql);

		ProductEntity product = (ProductEntity) query.setParameter("productId", productId).uniqueResult();
		return product;
	}
}
