package controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
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
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import entities.CategoryEntity;
import models.Generate;
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
	public String renderCategoryPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {
		List<CategoryEntity> categories = new ArrayList<CategoryEntity>();
		if (search != null) {
			Session session = factory.getCurrentSession();
			String hql = "FROM CategoryEntity WHERE id LIKE '%" + search + "%' OR name LIKE '%" + search
					+ "%' OR description LIKE '%" + search + "%'";
			Query query = session.createQuery(hql);
			categories = query.list();
		} else {
			categories = getCategories();
		}

		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);

		// model.addAttribute("categories", categories);
		model.addAttribute("pagedListHolder", pagedListHolder);
		return viewsDirectory + "category";
	}

	//ADD CATEGORY
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddCategoryPage(ModelMap model) {
		CategoryEntity category = new CategoryEntity();
		model.addAttribute("category", category);
		model.addAttribute("title", "Thêm Danh Mục");
		return viewsDirectory + "add";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @RequestParam("name") String name,
			@RequestParam("description") String description, @RequestParam("image") MultipartFile image)
			throws IllegalStateException, IOException, InterruptedException {

		CategoryEntity category = new CategoryEntity();
		category.setId(Generate.generateCategoryId(5));
		category.setName(name);
		category.setDescription(description);
		category.setDateAdded(new Date());
		category.setImage(Base64.getEncoder().encodeToString(image.getBytes()));

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(category);
			t.commit();
			System.out.println("Added");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			System.err.println(e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/categories";
	}
	
	//DELETE CATEGORY
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

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			System.err.println(e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/categories";
	}

	// VIEW DETAILS OF CATEGORY
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String categoryDetail(ModelMap model, @PathVariable(value = "id") String id) {
		System.out.println("Id: " + id);

		CategoryEntity category = getCategory(id);
		model.addAttribute("category", category);
		return viewsDirectory + "detail";
	}

	// EDIT CATEGORY
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String renderEditCategoryPage(ModelMap model, @PathVariable(value = "id") String id) {
		System.out.println("Id: " + id);

		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		CategoryEntity category = (CategoryEntity) query.list().get(0);
		System.out.println(category.getDateAdded());

		model.addAttribute("category", category);
		model.addAttribute("title", "Sửa danh mục");
		return viewsDirectory + "edit";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String editCategory(ModelMap model, HttpServletRequest request, @PathVariable(value = "id") String id,
			@RequestParam("image") MultipartFile image) throws IOException {
		System.out.println("Id: " + id);

		CategoryEntity category = new CategoryEntity();
		category.setId(id);
		category.setName(request.getParameter("name"));
		category.setDescription(request.getParameter("description"));
		category.setImage(Base64.getEncoder().encodeToString(image.getBytes()));

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(category);
			t.commit();
			System.out.println("Deleted");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return "redirect:/admin/categories";
	}

	// GET CATEGORIES FROM SQL
	public List<CategoryEntity> getCategories() throws IOException {
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> categories = query.list();
		return categories;
	}
	
	//GET SINGLE CATEGORY
	public CategoryEntity getCategory(String id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		CategoryEntity category = (CategoryEntity) query.list().get(0);
		return category;
	}
}
