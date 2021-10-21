package controllers;


import java.util.List;

import javax.servlet.ServletContext;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import entities.CategoryEntity;
import entities.ProductEntity;

@Transactional
@Controller
@RequestMapping("/")
public class MainController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext application1;
	@RequestMapping("")
	public String store(ModelMap model) {
		model.addAttribute("list", getListProduct());
		application1.setAttribute("listCategory", getListCategory());
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
	public List<CategoryEntity> getListCategory() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> list = query.list();
		return list;
	}
}
