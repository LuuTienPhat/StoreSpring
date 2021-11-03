package controllers;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import entities.CategoryEntity;
import entities.ImageEntity;
import entities.ProductEntity;

@Transactional
@Controller
@RequestMapping("/")
public class MainController {
	@Autowired
	SessionFactory factory;
	@RequestMapping("")
	public String store(ModelMap model, HttpSession session) {
		/* model.addAttribute("list", getListProduct()); */
		model.addAttribute("list", getTop16RecentProduct());
		session.setAttribute("listCategory", getListCategory());
		/* addProductsForTesting(); */
		return "store/index";
	}
	public List<ProductEntity> getListProduct() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
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
	public List<CategoryEntity> getListCategory() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> list = query.list();
		return list;
	}
	
	public String createTheNextProductId() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT p.id FROM ProductEntity p WHERE p.id=(SELECT MAX(pp.id) FROM ProductEntity pp)";
		Query query = session.createQuery(hql);

		String id = (String) query.uniqueResult();
		int x = Integer.parseInt(id.substring(1)) + 1;
		String base = "P0000";
		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
		String newId = base2 + String.valueOf(x);
		return newId;
	}
	
	public boolean addProductsForTesting() {
		
		for(int i=0; i<20; i++) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			ProductEntity pe = new ProductEntity();
			pe.setName("Product p = "+i);
			pe.setId(createTheNextProductId());
			pe.setPrice(2000000);
			try {
				session.save(pe);
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
		}
		
		return true;
	}
}
