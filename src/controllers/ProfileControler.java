package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import entities.AdminEntity;
import entities.ProductEntity;
import models.UploadFile;

@Controller
@RequestMapping("/admin/profile")
public class ProfileControler {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;
	
	String viewsDirectory = "admin/pages/profile/";
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String renderProfilePage(ModelMap model, HttpSession session) throws IOException {
		
		String id = session.getAttribute("admin").toString();
		AdminEntity admin = getAdmin(id);
		
		model.addAttribute("admin", admin);
		model.addAttribute("title", "Thông tin");
		model.addAttribute("type", "admin");
		return viewsDirectory + "profile";
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST )
	public String editProfile() {
		return viewsDirectory + "profile";
	}
	
	// GET PRODUCTS
		public List<AdminEntity> getAdmins() throws IOException {
			Session session = factory.openSession();
			String hql = "FROM AdminEntity";
			Query query = session.createQuery(hql);
			List<AdminEntity> admins = query.list();
			session.close();
			return admins;
		}

		// GET PRODUCT WITH ID
		public AdminEntity getAdmin(String id) throws IOException {
			Session session = factory.openSession();
			String hql = "FROM AdminEntity WHERE id = '" + id + "'";
			Query query = session.createQuery(hql);
			AdminEntity admin = (AdminEntity) query.list().get(0);
			session.close();
			return admin;
		}
}
