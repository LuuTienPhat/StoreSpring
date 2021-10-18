package controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
		for(CartDetailEntity  c : getListCartDetail(getUserIdByUserName("tuanbui"))) {
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
}
