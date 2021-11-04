package controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

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

import entities.CategoryEntity;
import entities.ImageEntity;
import entities.ProductEntity;
import models.UploadFile;
import models.Generate;

@Transactional
@Controller
@RequestMapping("/admin/products")
public class ProductController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	String viewsDirectory = "admin/pages/product/";

	@RequestMapping("")
	public String renderProductPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		List<ProductEntity> products = new ArrayList<ProductEntity>();
		if (search != null) {
			Session session = factory.openSession();
			String hql = "FROM ProductEntity WHERE id LIKE '%" + search + "%' OR name LIKE '%" + search
					+ "%' OR description LIKE '%" + search + "%' OR quantity LIKE '%" + search + "%' OR unit LIKE '%"
					+ search + "%' OR price LIKE '%" + search + "%' OR category_id LIKE '%" + search + "%'";

			Query query = session.createQuery(hql);
			products = query.list();
			session.close();

		} else {
			products = getProducts();
		}

		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);

		// model.addAttribute("products", products);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("title", "Quản lý sản phẩm");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "product";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddProductPage(ModelMap model) throws IOException {
		List<CategoryEntity> categories = getCategories();

		model.addAttribute("product", new ProductEntity());
		model.addAttribute("title", "Thêm sản phẩm");
		model.addAttribute("categories", categories);
		return viewsDirectory + "addProduct";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addProduct(ModelMap model, HttpServletRequest request, @RequestParam("images") MultipartFile[] files,
			@ModelAttribute("product") ProductEntity product2, BindingResult errors) throws IOException {

		CategoryEntity category = new CategoryEntity();
		category.setId(request.getParameter("categoryId"));

		List<ProductEntity> products = getProducts();
		ProductEntity product = new ProductEntity();
		String productId = Generate.generateProductId(products);

		product.setId(productId);
		product.setName(request.getParameter("name"));
		product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
		product.setUnit(request.getParameter("unit"));
		product.setPrice(Float.parseFloat(request.getParameter("price")));
		product.setDescription(request.getParameter("description"));
		product.setDateAdded(new Date());
		product.setCategory(category);

		if (files.length > 0) {
			List<ImageEntity> images = new ArrayList<ImageEntity>();
			String basePath = uploadFile.getBasePath();
			int index = 1;

			File folderInServer = new File(context.getRealPath("resources\\upload\\products\\" + productId + "\\"));
			File folderInResource = new File(basePath + "/products/" + productId + "/");

			if (!folderInResource.exists())
				folderInResource.mkdir();
			if (!folderInServer.exists())
				folderInServer.mkdir();

			for (MultipartFile image : files) {
				ImageEntity i = new ImageEntity();
				String imageFileName = productId + "_" + index + UploadFile.getExtension(image.getOriginalFilename());
				String imagePath = UploadFile.getProductBasePath() + "/" + productId + "/" + imageFileName;
				i.setProduct(product);
				i.setImage(imagePath);

				File fileInServer = new File(
						context.getRealPath("resources\\upload\\products\\" + productId + "\\" + imageFileName));
				File fileInResource = new File(basePath + "/products/" + productId + "/" + imageFileName);
				if (!fileInServer.exists()) {
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(fileInServer));
					stream.write(image.getBytes());
					stream.close();
				}
				if (!fileInResource.exists()) {
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(fileInResource));
					stream.write(image.getBytes());
					stream.close();
				}

				images.add(i);
				index++;
			}
			product.setImages(images);
		}

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(product);
			t.commit();
			System.out.println("Added");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return "redirect:/admin/products/add";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String deleteProduct(ModelMap model, @PathVariable("id") String id) throws IOException {
		ProductEntity product = new ProductEntity();
		product.setId(id);

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(product);
			t.commit();
			System.out.println("Deleted");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return "redirect:/admin/products";
	}

	// VIEW PRODUCT
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") String id) throws IOException {
		System.out.println("hello");
		ProductEntity product = getProduct(id);
		model.addAttribute("product", product);
		model.addAttribute("title", "Chi tiết " + product.getId());
		return viewsDirectory + "viewProduct";
	}

	// EDIT PRODUCT
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String renderEditProductPage(ModelMap model, @PathVariable("id") String id) throws IOException {
		ProductEntity product = getProduct(id);
		List<CategoryEntity> categories = getCategories();

		model.addAttribute("product", product);
		model.addAttribute("categories", categories);
		model.addAttribute("title", "Chi tiết sản phẩm");
		return viewsDirectory + "editProduct";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String editProduct(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "image", required = false) MultipartFile images, @PathVariable("id") String id)
			throws IOException {

		CategoryEntity category = new CategoryEntity();
		category.setId(request.getParameter("categoryId"));

		ProductEntity product = getProduct(id);
		product.setName(request.getParameter("name"));
		product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
		product.setUnit(request.getParameter("unit"));
		product.setPrice(Float.parseFloat(request.getParameter("price")));
		product.setDescription(request.getParameter("description"));
		product.setCategory(category);

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(product);
			t.commit();
			System.out.println("Updated");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return "redirect:/admin/products";
	}

	// GET CATEGORIES FROM SQL
	public List<CategoryEntity> getCategories() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> categories = query.list();
		session.close();
		return categories;
	}

	// GET PRODUCTS
	public List<ProductEntity> getProducts() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> products = query.list();
		session.close();
		return products;
	}

	// GET PRODUCT WITH ID
	public ProductEntity getProduct(String id) throws IOException {
		Session session = factory.openSession();
		String hql = "FROM ProductEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		ProductEntity product = (ProductEntity) query.list().get(0);
		session.close();
		return product;
	}

}
