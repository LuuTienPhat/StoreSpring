package controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import entities.CategoryEntity;
import models.UploadFile;

@Controller
@Transactional

@RequestMapping("/admin/categories")
public class CategoryController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	String viewsDirectory = "admin/pages/category/";

	@RequestMapping("")
	public String renderCategoryPage(ModelMap model) throws IOException {
		List<CategoryEntity> categories = getCategory();
		model.addAttribute("categories", categories);
		return viewsDirectory + "category";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddCategoryPage(ModelMap model) {
		CategoryEntity category = new CategoryEntity();
		model.addAttribute("category", category);
		return viewsDirectory + "add";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @RequestParam("name") String name,
			@RequestParam("description") String description, @RequestParam("image") MultipartFile image)
			throws IllegalStateException, IOException, InterruptedException {

		String id = generateId(10);
		CategoryEntity category = new CategoryEntity();

		category.setId(id);
		category.setName(name);
		category.setDescription(description);
		category.setImage(Base64.getEncoder().encodeToString(image.getBytes()));

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(category);
			t.commit();
			System.out.println("Added");
			// model.addAttribute("message", "Thêm thành công!");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			System.err.println(e.getMessage());
			// model.addAttribute("message", "Thêm thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/categories";
	}

	@RequestMapping(value = "/delete/{id}")
	public String deleteCategory(ModelMap model, @PathVariable("id") String id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		CategoryEntity category = new CategoryEntity();
		category.setId(id);

		try {
			session.delete(category);
			t.commit();
			System.out.println("Deleted");
			// model.addAttribute("message", "Thêm thành công!");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			System.err.println(e.getMessage());
			// model.addAttribute("message", "Thêm thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/categories";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String categoryDetail(ModelMap model, @PathVariable(value = "id") String id) {
		System.out.println("Id: " + id);

		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		CategoryEntity category = (CategoryEntity) query.list().get(0);
		model.addAttribute("category", category);
		return viewsDirectory + "detail";
	}

	public List<CategoryEntity> getCategory() throws IOException {
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> categories = query.list();
		return categories;
	}

	public static String generateId(int targetStringLength) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

		return generatedString;
	}
}
