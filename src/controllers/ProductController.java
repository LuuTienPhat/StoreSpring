package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.CategoryEntity;
import entities.ImageEntity;
import entities.ProductEntity;
import models.Generate;
import models.Pagination;
import models.UploadFile;
import models.List.Categories;
import models.List.Products;
import models.dao.CategoryDAO;
import models.dao.ProductDAO;

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

	// EntityData entityData;

	ProductDAO productDAO;

	String viewsDirectory = "admin/pages/product/";

	@RequestMapping("")
	public String renderProductPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		productDAO = new ProductDAO(factory);
		Products products = new Products();

		if (search != null) {
			products = productDAO.searchForProduct(search);
			model.addAttribute("pagedLink", "/admin/products?search=" + search);
		} else {
			products = productDAO.getProducts();
			model.addAttribute("pagedLink", "/admin/products");
		}

		PagedListHolder pagedListHolder = Pagination.productPagination(request, products.getList(), 5, 10);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("title", "Quản lý sản phẩm");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "product";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddProductPage(ModelMap model) throws IOException {
		CategoryDAO categoryDAO = new CategoryDAO(factory);
		Categories categories = categoryDAO.getCategories();

		model.addAttribute("categories", categories.getList());
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
			CategoryDAO categoryDAO = new CategoryDAO(factory);
			model.addAttribute("categories", categoryDAO.getCategories().getList());
			model.addAttribute("product", product);
			model.addAttribute("message", "Vui lòng điền đầy đủ thông tin!");
			model.addAttribute("messageType", "warning");
			model.addAttribute("title", "Thêm sản phẩm");
			return viewsDirectory + "addProduct";

		} else {
			productDAO = new ProductDAO(factory);
			Products products = productDAO.getProducts();
			String productId = Generate.generateProductId(products.getList());

			product.setId(productId);
			product.setDateAdded(new Date());

			if (files.length > 0) {
				List<ImageEntity> images = new ArrayList<ImageEntity>();

				File folderInServer = new File(
						uploadFile.getUploadPathOnServer(context) + "products/" + productId + "/");
				File folderInResource = new File(uploadFile.getUploadPath() + "products/" + productId + "/");

				if (!folderInResource.exists())
					folderInResource.mkdir();
				if (!folderInServer.exists())
					folderInServer.mkdir();

				int index = 1;
				for (MultipartFile image : files) {
					if (!image.isEmpty()) {
						ImageEntity i = new ImageEntity();
						String imageFileName = productId + "_" + index
								+ UploadFile.getExtension(image.getOriginalFilename());
						String imagePath = uploadFile.getRelativeUploadPath() + "products/" + productId + "/"
								+ imageFileName;
						i.setProduct(product);
						i.setImage(imagePath);

						File fileInServer = new File(folderInServer + "/" + imageFileName);
						File fileInResource = new File(folderInResource + "/" + imageFileName);

						if (!fileInServer.exists()) {
							UploadFile.writeFile(fileInServer, image);

						}
						if (!fileInResource.exists()) {
							UploadFile.writeFile(fileInResource, image);
						}

						images.add(i);
						index++;
					}
				}
				product.setImages(images);
			}

			if (productDAO.addProductToDB(product)) {
				redirectAttributes.addFlashAttribute("message", "Thêm sản phẩm thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
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
			productDAO = new ProductDAO(factory);
			ProductEntity product = productDAO.getProduct(productId);

			if (product != null) {
				File folderInServer = new File(
						uploadFile.getUploadPathOnServer(context) + "products/" + productId + "/");
				File folderInResource = new File(uploadFile.getUploadPath() + "products/" + productId + "/");

				if (folderInResource.exists()) {
					UploadFile.deleteDirectory(folderInResource);
				}
				if (folderInServer.exists()) {
					UploadFile.deleteDirectory(folderInServer);
				}

				if (productDAO.deleteProductInDB(product)) {
					redirectAttributes.addFlashAttribute("message", "Xoá sản phẩm thành công!");
					redirectAttributes.addFlashAttribute("messageType", "success");
				} else {
					redirectAttributes.addFlashAttribute("message", "Không thể xoá sản phẩm này!");
					redirectAttributes.addFlashAttribute("messageType", "error");
				}
			} else {
				redirectAttributes.addFlashAttribute("message", "Không tồn tại sản phẩm này");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
		}
		return "redirect:/admin/products";
	}

	// VIEW PRODUCT
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") String id) throws IOException {
		productDAO = new ProductDAO(factory);
		ProductEntity product = productDAO.getProduct(id);
		model.addAttribute("product", product);
		model.addAttribute("title", "Chi tiết " + product.getId());
		return viewsDirectory + "viewProduct";
	}

	// EDIT PRODUCT
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String renderEditProductPage(ModelMap model, @PathVariable("id") String id) throws IOException {
		productDAO = new ProductDAO(factory);
		ProductEntity product = productDAO.getProduct(id);
		CategoryDAO categoryDAO = new CategoryDAO(factory);
		Categories categories = categoryDAO.getCategories();

		model.addAttribute("categories", categories.getList());
		model.addAttribute("product", product);
		model.addAttribute("title", "Chỉnh sửa sản phẩm");
		return viewsDirectory + "editProduct";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String editProduct(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "images", required = false) MultipartFile[] files, @PathVariable("id") String id,
			@ModelAttribute("product") ProductEntity moddifiedProduct, BindingResult errors,
			RedirectAttributes redirectAttributes) throws IOException {

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

		}

		if (errorsCount != 0) {
			model.addAttribute("product", moddifiedProduct);
			model.addAttribute("title", "Chỉnh sửa sản phẩm");
			model.addAttribute("message", "Vui lòng điền đầy đủ thông tin!");
			model.addAttribute("messageType", "warning");
			return viewsDirectory + "editProduct";
		} else {
			productDAO = new ProductDAO(factory);
			ProductEntity product = productDAO.getProduct(id);
			product.setName(moddifiedProduct.getName());
			product.setQuantity(moddifiedProduct.getQuantity());
			product.setCategory(moddifiedProduct.getCategory());
			product.setUnit(moddifiedProduct.getUnit());
			product.setPrice(moddifiedProduct.getPrice());
			product.setDescription(moddifiedProduct.getDescription());

			File folderInServer = new File(
					uploadFile.getUploadPathOnServer(context) + "products/" + product.getId() + "/");
			File folderInResource = new File(uploadFile.getUploadPath() + "products/" + product.getId() + "/");

			List<ImageEntity> images = null;
			if (files.length != 0) {
				images = new ArrayList<ImageEntity>();
				int index = 1;

				if (folderInResource.exists()) {
					UploadFile.deleteDirectory(folderInResource);
					folderInResource.mkdir();
				} else {
					folderInResource.mkdir();
				}
				if (folderInServer.exists()) {
					UploadFile.deleteDirectory(folderInServer);
					folderInServer.mkdir();
				} else
					folderInServer.mkdir();

				for (MultipartFile image : files) {
					if (!image.isEmpty()) {
						ImageEntity i = new ImageEntity();
						String imageFileName = product.getId() + "_" + index
								+ UploadFile.getExtension(image.getOriginalFilename());
						String imagePath = uploadFile.getRelativeUploadPath() + "products/" + product.getId() + "/"
								+ imageFileName;
						i.setProduct(product);
						i.setImage(imagePath);

						File fileInServer = new File(folderInServer + "/" + imageFileName);
						File fileInResource = new File(folderInResource + "/" + imageFileName);

						if (!fileInServer.exists()) {
							UploadFile.writeFile(fileInServer, image);

						}
						if (!fileInResource.exists()) {
							UploadFile.writeFile(fileInResource, image);
						}
						images.add(i);
						index++;
					}
				}
			}

			product.setImages(images);

			if (productDAO.updateProductInDB(product)) {
				redirectAttributes.addFlashAttribute("message", "Cập nhật sản phẩm thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể cập nhật sản phẩm!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
			return "redirect:/admin/products/edit/" + product.getId();
		}
	}
}
