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
import org.springframework.validation.BindingResult;
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
		pagedListHolder.setMaxLinkedPages(10);
		pagedListHolder.setPageSize(5);

		// model.addAttribute("categories", categories);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "danh mục");
		model.addAttribute("title", "Quản lý Danh mục");
		return viewsDirectory + "category";
	}

	// ADD CATEGORY
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddCategoryPage(ModelMap model) {
		CategoryEntity category = new CategoryEntity();
		model.addAttribute("category", category);
		model.addAttribute("title", "Thêm Danh Mục");
		return viewsDirectory + "addCategory";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @ModelAttribute(value = "category") CategoryEntity category,
			BindingResult errors, @RequestParam(value = "image", required = false) MultipartFile image)
			throws IllegalStateException, IOException, InterruptedException {

		
		if (category.getName().isEmpty()) {
			errors.rejectValue("name", "category", "Nhập tên danh mục");
			model.addAttribute("nameValid", "is-invalid");
		}

		if (errors.hasFieldErrors("name")) {
			model.addAttribute("title", "Thêm Danh Mục");
			return viewsDirectory + "addCategory";

		} else {
			List<CategoryEntity> categories = getCategories();
			category.setId(Generate.generateCategoryId(categories));
			category.setDateAdded(new Date());
			
			if(image.getSize() != 0) {
				category.setImage(Base64.getEncoder().encodeToString(image.getBytes()));
			}
			
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
	}

	// DELETE CATEGORY
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
			e.printStackTrace();
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
		model.addAttribute("title", "Danh mục " + category.getName());
		return viewsDirectory + "viewCategory";
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
		return viewsDirectory + "editCategory";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String editCategory(ModelMap model, HttpServletRequest request, @PathVariable(value = "id") String id,
			@RequestParam(value = "image", required = false) MultipartFile image) throws IOException {
		System.out.println("Id: " + id);

		CategoryEntity category = getCategory(id);
		category.setName(request.getParameter("name"));
		category.setDescription(request.getParameter("description"));
		if (image.getSize() != 0) {
			category.setImage(Base64.getEncoder().encodeToString(image.getBytes()));
		}

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(category);
			t.commit();
			System.out.println("Updated");

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

	// GET SINGLE CATEGORY
	public CategoryEntity getCategory(String id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		CategoryEntity category = (CategoryEntity) query.list().get(0);
		return category;
	}
}
