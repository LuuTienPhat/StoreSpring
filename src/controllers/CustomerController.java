package controllers;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import entities.CategoryEntity;
import entities.ImageEntity;
import entities.CustomerEntity;
import models.UploadFile;
import models.Generate;

@Transactional
@Controller
@RequestMapping("/admin/customers")
public class CustomerController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	String viewsDirectory = "admin/pages/customer/";

	@RequestMapping("")
	public String renderProductPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		List<CustomerEntity> products = new ArrayList<CustomerEntity>();
		if (search != null) {
			Session session = factory.getCurrentSession();
			String hql = "FROM CustomerEntity WHERE id LIKE '%" + search + "%' OR name LIKE '%" + search
					+ "%' OR description LIKE '%" + search + "%' OR quantity LIKE '%" + search + "%' OR unit LIKE '%"
					+ search + "%' OR price LIKE '%" + search + "%' OR category_id LIKE '%" + search + "%'";

			Query query = session.createQuery(hql);
			products = query.list();

		} else {
			products = getCustomers();
		}

		model.addAttribute("products", products);
		model.addAttribute("title", "Quản lý khách hàng");
		return viewsDirectory + "customer";
	}

	/*
	 * @RequestMapping(value = "/add", method = RequestMethod.GET) public String
	 * renderAddProductPage(ModelMap model) throws IOException {
	 * model.addAttribute("title", "Thêm sản phẩm");
	 * model.addAttribute("categories", getCustomer()); //
	 * model.addAttribute("product", new CustomerEntity()); return viewsDirectory +
	 * "addProduct"; }
	 */

	/*
	 * @RequestMapping(value = "/add", method = RequestMethod.POST) public String
	 * addProduct(ModelMap model, HttpServletRequest
	 * request, @RequestParam("images") MultipartFile[] files) throws IOException {
	 * 
	 * CategoryEntity category = new CategoryEntity();
	 * category.setId(request.getParameter("categoryId"));
	 * 
	 * CustomerEntity product = new CustomerEntity();
	 * product.setId(Generate.generateProductId(5));
	 * product.setName(request.getParameter("name"));
	 * product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
	 * product.setUnit(request.getParameter("unit"));
	 * product.setPrice(Float.parseFloat(request.getParameter("price")));
	 * product.setDescription(request.getParameter("description"));
	 * product.setDateAdded(new Date()); product.setCategory(category);
	 * 
	 * List<ImageEntity> images = new ArrayList<ImageEntity>(); for (MultipartFile
	 * image : files) { ImageEntity i = new ImageEntity();
	 * i.setId(Generate.generateImageId(5)); i.setProduct(product);
	 * i.setImage(Base64.getEncoder().encodeToString(image.getBytes()));
	 * images.add(i); }
	 * 
	 * product.setImages(images);
	 * 
	 * Session session = factory.openSession(); Transaction t =
	 * session.beginTransaction(); try { session.save(product); t.commit();
	 * System.out.println("Added");
	 * 
	 * } catch (Exception e) { t.rollback(); System.out.println("Error");
	 * e.printStackTrace(); } finally { session.close(); }
	 * 
	 * return "redirect:/admin/customers/add"; }
	 */

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String deleteCustomer(ModelMap model, @PathVariable("id") String id) throws IOException {
		CustomerEntity customer = new CustomerEntity();
		customer.setId(id);

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(customer);
			t.commit();
			System.out.println("Deleted");

		} catch (Exception e) {
			t.rollback();
			System.out.println("Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return "redirect:/admin/customers";
	}

	// VIEW CUSTOMER
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") String id) throws IOException {
		model.addAttribute("product", getCustomer(id));
		model.addAttribute("title", "Chi tiết sản phẩm");
		return viewsDirectory + "viewProduct";
	}

	// EDIT PRODUCT
//	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
//	public String renderEditProductPage(ModelMap model, @PathVariable("id") String id) throws IOException {
//		model.addAttribute("product", getProduct(id));
//		model.addAttribute("categories", getCategory());
//		model.addAttribute("title", "Chi tiết sản phẩm");
//		return viewsDirectory + "editProduct";
//	}

	/*
	 * @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST) public
	 * String editProduct(ModelMap model, HttpServletRequest request,
	 * 
	 * @RequestParam(value = "image", required = false) MultipartFile
	 * images, @PathVariable("id") String id) throws IOException {
	 * 
	 * CategoryEntity category = new CategoryEntity();
	 * category.setId(request.getParameter("categoryId"));
	 * 
	 * CustomerEntity product = getProduct(id);
	 * product.setName(request.getParameter("name"));
	 * product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
	 * product.setUnit(request.getParameter("unit"));
	 * product.setPrice(Float.parseFloat(request.getParameter("price")));
	 * product.setDescription(request.getParameter("description"));
	 * product.setCategory(category);
	 * 
	 * Session session = factory.openSession(); Transaction t =
	 * session.beginTransaction(); try { session.merge(product); t.commit();
	 * System.out.println("Updated");
	 * 
	 * } catch (Exception e) { t.rollback(); System.out.println("Error");
	 * e.printStackTrace(); } finally { session.close(); }
	 * 
	 * return "redirect:/admin/products"; }
	 */

	public List<CustomerEntity> getCustomers() throws IOException {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity";
		Query query = session.createQuery(hql);
		List<CustomerEntity> customers = query.list();
		return customers;
	}

	public CustomerEntity getCustomer(String id) throws IOException {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);

		CustomerEntity customer = (CustomerEntity) query.list().get(0);
		return customer;
	}
}
