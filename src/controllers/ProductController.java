package controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			model.addAttribute("pagedLink", "/admin/products?search=" + search);
			session.close();

		} else {
			products = getProducts();
			model.addAttribute("pagedLink", "/admin/products");
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
		model.addAttribute("product", new ProductEntity());
		model.addAttribute("title", "Thêm sản phẩm");
		return viewsDirectory + "addProduct";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addProduct(ModelMap model, HttpServletRequest request, @RequestParam("images") MultipartFile[] files,
			@ModelAttribute("product") ProductEntity product, BindingResult errors,
			RedirectAttributes redirectAttributes) throws IOException {
		int errorsCount = 0;

		if (product.getName().isEmpty()) {
			errors.rejectValue("name", "product", "Nhập tên sản phẩm");
			model.addAttribute("nameValid", "is-invalid");
			errorsCount++;
		}

		if (product.getQuantity() < 0) {
			errors.rejectValue("quantity", "product", "Số lượng phải >= 0");
			model.addAttribute("quantityValid", "is-invalid");
			errorsCount++;
		}

		if (product.getPrice() < 0) {
			errors.rejectValue("name", "product", "Giá sản phẩm phải >= 0");
			model.addAttribute("priceValid", "is-invalid");
			errorsCount++;
		}

		if (product.getCategory().getId().isEmpty()) {
			errors.rejectValue("category", "product", "Chọn danh mục sản phẩm");
			model.addAttribute("categoryValid", "is-invalid");
			errorsCount++;
		}

		if (errorsCount != 0) {
			model.addAttribute("title", "Thêm Danh Mục");
			model.addAttribute("message", "Thông tin bị lỗi");
			model.addAttribute("messageType", "warning");
			return viewsDirectory + "addProduct";
		} else {
			List<ProductEntity> products = getProducts();
			String productId = Generate.generateProductId(products);
			product.setId(productId);
			product.setDateAdded(new Date());

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
					String imageFileName = productId + "_" + index
							+ UploadFile.getExtension(image.getOriginalFilename());
					String imagePath = UploadFile.getProductBasePath() + "/" + productId + "/" + imageFileName;
					i.setProduct(product);
					i.setImage(imagePath);

					File fileInServer = new File(
							context.getRealPath("resources\\upload\\products\\" + productId + "\\" + imageFileName));
					File fileInResource = new File(basePath + "/products/" + productId + "/" + imageFileName);

					if (!fileInServer.exists()) {
						UploadFile.writeFile(fileInServer, image);
					}
					if (!fileInResource.exists()) {
						UploadFile.writeFile(fileInResource, image);
					}

					images.add(i);
					index++;
				}
				product.setImages(images);
			}

			if(addProductToDB(product)) {
				redirectAttributes.addFlashAttribute("message", "Thêm sản phẩm thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			}
			else {
				redirectAttributes.addFlashAttribute("message", "Không thể thêm sản phẩm!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
			return "redirect:/admin/products/add";
		}
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String deleteProduct(ModelMap model, @PathVariable("id") String productId,
			RedirectAttributes redirectAttributes) throws IOException {
		if (!productId.isEmpty()) {
			ProductEntity product = new ProductEntity();
			product.setId(productId);

			String basePath = uploadFile.getBasePath();
			File folderInServer = new File(context.getRealPath("resources\\upload\\products\\" + productId + "\\"));
			File folderInResource = new File(basePath + "/products/" + productId + "/");

			if (folderInResource.exists()) {
				deleteDirectory(folderInResource);
			}
			if (folderInServer.exists()) {
				deleteDirectory(folderInServer);
			}

			if (deleteProductInDB(product)) {
				redirectAttributes.addFlashAttribute("message", "Xoá sản phẩm thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể xoá sản phẩm này!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
		}
		return "redirect:/admin/products";
	}

	// VIEW PRODUCT
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") String id) throws IOException {
		ProductEntity product = getProduct(id);
		model.addAttribute("product", product);
		model.addAttribute("title", "Chi tiết " + product.getId());
		return viewsDirectory + "viewProduct";
	}

	// EDIT PRODUCT
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String renderEditProductPage(ModelMap model, @PathVariable("id") String id) throws IOException {
		ProductEntity product = getProduct(id);

		model.addAttribute("product", product);
		model.addAttribute("title", "Chi tiết sản phẩm");
		return viewsDirectory + "editProduct";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String editProduct(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "image", required = false) MultipartFile images, @PathVariable("id") String id,
			@ModelAttribute("product") ProductEntity moddifiedProduct, BindingResult errors,
			RedirectAttributes redirectAttributes) throws IOException {

		// CategoryEntity category = new CategoryEntity();
		// category.setId(request.getParameter("categoryId"));

		int errorsCount = 0;

		if (moddifiedProduct.getName().isEmpty()) {
			errors.rejectValue("name", "product", "Nhập tên sản phẩm");
			model.addAttribute("nameValid", "is-invalid");
			errorsCount++;
		}

		if (moddifiedProduct.getQuantity() < 0) {
			errors.rejectValue("quantity", "product", "Số lượng phải >= 0");
			model.addAttribute("quantityValid", "is-invalid");
			errorsCount++;
		}

		if (moddifiedProduct.getPrice() < 0) {
			errors.rejectValue("name", "product", "Giá sản phẩm phải >= 0");
			model.addAttribute("priceValid", "is-invalid");
			errorsCount++;
		}

		if (moddifiedProduct.getCategory().getId().isEmpty()) {
			errors.rejectValue("category", "product", "Chọn danh mục sản phẩm");
			model.addAttribute("categoryValid", "is-invalid");
			errorsCount++;
			return viewsDirectory + "editProduct";
		} else {
			ProductEntity product = getProduct(id);
			product.setName(moddifiedProduct.getName());
			product.setQuantity(moddifiedProduct.getQuantity());
			product.setCategory(moddifiedProduct.getCategory());
			product.setUnit(moddifiedProduct.getUnit());
			product.setPrice(moddifiedProduct.getPrice());
			product.setDescription(moddifiedProduct.getDescription());

			if (updateProductInDB(product)) {
				redirectAttributes.addFlashAttribute("message", "Cập nhật sản phẩm thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {

				redirectAttributes.addFlashAttribute("message", "Không thể cập nhật sản phẩm!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
			return "redirect:/admin/products";
		}
	}
	
	public boolean addProductToDB(ProductEntity product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(product);
			t.commit();
			System.out.println("Product is Added");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when adding product");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	public boolean updateProductInDB(ProductEntity product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(product);
			t.commit();
			System.out.println("Produc is updated");
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when updating product");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	public boolean deleteProductInDB(ProductEntity product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(product);
			t.commit();
			System.out.println("Product is deleted");
			return true;

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error when deleting product");
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	public static boolean deleteDirectory(File dir) {
		if (dir.isDirectory()) {
			File[] children = dir.listFiles();
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDirectory(children[i]);
				if (!success) {
					return false;
				}
			}
		}
		// either file or an empty directory
		System.out.println("removing file or directory : " + dir.getName());
		return dir.delete();
	}

	// GET CATEGORIES FROM SQL
	@ModelAttribute("categories")
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
