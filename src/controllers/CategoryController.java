package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.CategoryEntity;
import models.Generate;
import models.Pagination;
import models.UploadFile;
import models.List.Categories;
import models.dao.CategoryDAO;
import models.dao.DAO;

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

	CategoryDAO categoryDAO;

	String viewsDirectory = "admin/pages/category/";

	@RequestMapping("")
	public String renderCategoryPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		Categories categories = new Categories();
		categoryDAO = new CategoryDAO(factory);

		if (search != null) {
			categories = categoryDAO.searchForCategory(search);
			model.addAttribute("pagedLink", "/admin/categories?search=" + search);

		} else {
			categories = categoryDAO.getCategories();
			model.addAttribute("pagedLink", "/admin/categories");
		}

		PagedListHolder pagedListHolder = Pagination.categoryPagination(request, categories.getList(), 10, 5);

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
			BindingResult errors, @RequestParam(value = "image", required = false) MultipartFile image,
			RedirectAttributes redirectAttributes) throws IllegalStateException, IOException, InterruptedException {

		if (category.getName().isEmpty()) {
			errors.rejectValue("name", "category", "Nhập tên danh mục");
			model.addAttribute("nameValid", "is-invalid");
		}

		if (errors.hasFieldErrors("name")) {
			model.addAttribute("category", category);
			model.addAttribute("title", "Thêm Danh Mục");
			return viewsDirectory + "addCategory";

		} else {
			categoryDAO = new CategoryDAO(factory);
			Categories categories = categoryDAO.getCategories();
			String categoryId = Generate.generateCategoryId(categories.getList());

			category.setId(categoryId);
			category.setDateAdded(new Date());

			if (image.getSize() != 0) {
				String imageFileName = categoryId + UploadFile.getExtension(image.getOriginalFilename());
				String imagePath = uploadFile.getRelativeUploadPath() + "categories/" + imageFileName;
				category.setImage(imagePath);

				File fileInServer = new File(uploadFile.getUploadPathOnServer(context) + "categories/" + imageFileName);
				File fileInResource = new File(uploadFile.getUploadPath() + "categories/" + imageFileName);
				if (!fileInServer.exists()) {
					UploadFile.writeFile(fileInServer, image);
				}
				if (!fileInResource.exists()) {
					UploadFile.writeFile(fileInResource, image);
				}
			}

			if (categoryDAO.addCategoryInDB(category)) {
				redirectAttributes.addFlashAttribute("message", "Thêm danh mục thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể thêm danh mục!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}

			return "redirect:/admin/categories/add";
		}
	}

	// DELETE CATEGORY
	@RequestMapping(value = "/delete/{id}")
	public String deleteCategory(ModelMap model, @PathVariable("id") String id, RedirectAttributes redirectAttributes) {

		categoryDAO = new CategoryDAO(factory);
		CategoryEntity category = categoryDAO.getCategory(id);

		if (categoryDAO.deleteCategoryInDB(category)) {
			String imageFileName = category.getId() + UploadFile.getExtension(category.getImage());
			File fileInServer = new File(uploadFile.getUploadPathOnServer(context) + "categories/" + imageFileName);
			File fileInResource = new File(uploadFile.getUploadPath() + "categories/" + imageFileName);

			if (fileInServer.exists()) {
				fileInServer.delete();
			}

			if (fileInResource.exists()) {
				fileInResource.delete();
			}

			redirectAttributes.addFlashAttribute("message", "Xoá danh mục thành công!");
			redirectAttributes.addFlashAttribute("messageType", "success");
		} else {
			redirectAttributes.addFlashAttribute("message", "Không thể xoá danh mục!");
			redirectAttributes.addFlashAttribute("messageType", "error");
		}

		return "redirect:/admin/categories";
	}

	// VIEW DETAILS OF CATEGORY
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String categoryDetail(ModelMap model, HttpServletRequest request, @PathVariable(value = "id") String id) {
		System.out.println("Id: " + id);

		categoryDAO = new CategoryDAO(factory);
		CategoryEntity category = categoryDAO.getCategory(id);
		model.addAttribute("category", category);
		model.addAttribute("title", "Danh mục " + category.getName());

		PagedListHolder pagedListHolder = Pagination.productPagination(request, category.getProducts(), 5, 5);
		model.addAttribute("pagedLink", "/admin/categories/" + id);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "sản phẩm");

		return viewsDirectory + "viewCategory";
	}

	// EDIT CATEGORY
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String renderEditCategoryPage(ModelMap model, @PathVariable(value = "id") String id) {

		categoryDAO = new CategoryDAO(factory);
		CategoryEntity category = categoryDAO.getCategory(id);
		model.addAttribute("category", category);
		model.addAttribute("title", "Sửa danh mục");
		return viewsDirectory + "editCategory";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String editCategory(ModelMap model, HttpServletRequest request, @PathVariable(value = "id") String id,
			@RequestParam(value = "image", required = false) MultipartFile image,
			@ModelAttribute("category") CategoryEntity modifiedCategory, BindingResult errors,
			RedirectAttributes redirectAttributes) throws IOException, InterruptedException {

		categoryDAO = new CategoryDAO(factory);
		if (modifiedCategory.getName().isEmpty()) {
			errors.rejectValue("name", "category", "Nhập tên danh mục");
			model.addAttribute("nameValid", "is-invalid");
		}

		if (errors.hasFieldErrors("name")) {
			CategoryEntity category = categoryDAO.getCategory(id);
			modifiedCategory.setImage(category.getImage());
			model.addAttribute("category", modifiedCategory);
			model.addAttribute("title", "Thêm Danh Mục");
			return viewsDirectory + "editCategory";
		} else {
			CategoryEntity category = categoryDAO.getCategory(id);
			category.setName(modifiedCategory.getName());
			category.setDescription(modifiedCategory.getDescription());

			if (image.getSize() != 0) {
				String oldImageFileName = category.getId() + UploadFile.getExtension(category.getImage());
				String imageFileName = category.getId() + UploadFile.getExtension(image.getOriginalFilename());
				String imagePath = uploadFile.getRelativeUploadPath() + "categories/" + imageFileName;
				category.setImage(imagePath);

				File oldFileInServer = new File(
						uploadFile.getUploadPathOnServer(context) + "categories/" + oldImageFileName);
				File oldFileInResource = new File(uploadFile.getUploadPath() + "categories/" + oldImageFileName);

				File fileInServer = new File(uploadFile.getUploadPathOnServer(context) + "categories/" + imageFileName);
				File fileInResource = new File(uploadFile.getUploadPath() + "categories/" + imageFileName);

				if (oldFileInResource.exists()) {
					oldFileInResource.delete();
				}

				if (oldFileInServer.exists()) {
					oldFileInServer.delete();
				}

				UploadFile.writeFile(fileInServer, image);
				UploadFile.writeFile(fileInResource, image);

				Thread.sleep(5000);
			}

			if (categoryDAO.updateCategoryInDB(category)) {
				redirectAttributes.addFlashAttribute("message", "Cập nhật danh mục thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể cập nhật danh mục!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}

			return "redirect:/admin/categories/edit/" + category.getId();
		}
	}
}
