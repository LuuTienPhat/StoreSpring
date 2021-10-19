package controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
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
	public static HttpSession httpSession;
	@Autowired
	SessionFactory factory;
	@RequestMapping("")
	public String store(ModelMap model, HttpServletRequest request) {
		httpSession = request.getSession();
		httpSession.setAttribute("customer", "tuanbui");
//		System.out.println(httpSession.getAttribute("customer")+"2");
		model.addAttribute("list", getListProduct());
		return "store/index";
	}
	@RequestMapping("/")
	public String store2(ModelMap model, HttpServletRequest request) {
		httpSession = request.getSession();
		httpSession.setAttribute("customer", "tuanbui");
		model.addAttribute("list", getListProduct());
		return "store/index";
	}
	@RequestMapping("/product-detail")
	public String productDetail() {
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
		model.addAttribute("listCartDetail", getListCartDetail(getUserIdByUserName((String) httpSession.getAttribute("customer"))));
		
		for(CartDetailEntity  c : getListCartDetail(getUserIdByUserName((String) httpSession.getAttribute("customer")))) {
			System.out.println("user_id: " + c.getCustomer().getId() +"; product_id: "+c.getProduct().getId()+"; quantity= "+c.getQuantity());
		}
//		System.out.println("==================== +\n userid = " + getUserIdByUserName("tuanbui"));
		return "store/shopping-cart";
	}
	
	public List<CartDetailEntity> getListCartDetail(String customerId){
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql="FROM CartDetailEntity c WHERE c.customer.id =:customerId";
		Query query = session.createQuery(hql);
		
		List<CartDetailEntity> list = query.setParameter("customerId", customerId).list();
		return list;
	}
	public String getUserIdByUserName(String userName) {
		/* System.out.println("getUserIdByUserName"); */;
		Session session = factory.getCurrentSession();
		String hql="SELECT id FROM CustomerEntity c WHERE c.username =:userName";
		Query query = session.createQuery(hql);
		String customerId = (String) query.setParameter("userName", userName).uniqueResult();
		return customerId;
	}
	
	public List<ProductEntity> getListProduct(){
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql="FROM ProductEntity";
		Query query = session.createQuery(hql);
		
		List<ProductEntity> list = query.list();
		return list;
	}
	
	@RequestMapping(value = "/shopping-cart/delete/{productId}", method=RequestMethod.GET)
	public String delete(@PathVariable("productId") String productId, ModelMap model) {
		System.out.println(productId);
		if(deleteProductFromCartDetail(productId)) {
			System.out.println("Delete successful");
		}else{
			System.out.println("Delete unsuccessful");
		}
		model.addAttribute("listCartDetail", getListCartDetail(getUserIdByUserName((String) httpSession.getAttribute("customer"))));
		
		for(CartDetailEntity  c : getListCartDetail(getUserIdByUserName((String) httpSession.getAttribute("customer")))) {
			System.out.println("user_id: " + c.getCustomer().getId() +"; product_id: "+c.getProduct().getId()+"; quantity= "+c.getQuantity());
		}
		return "redirect:/store/shopping-cart";
	}
	
	public boolean deleteProductFromCartDetail(String productId) {
		Session session = factory.getCurrentSession();
		String hql="DELETE FROM CartDetailEntity c WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId", getUserIdByUserName((String) httpSession.getAttribute("customer")));
		query.setParameter("productId", productId);
		
		return query.executeUpdate() > 0;
	}
}
