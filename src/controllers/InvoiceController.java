package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
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

import entities.InvoiceDetailEntity;
import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;
import entities.ProductEntity;
import models.UploadFile;

@Controller
@Transactional

@RequestMapping("/admin/invoices")
public class InvoiceController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	String viewsDirectory = "admin/pages/invoice/";

	@RequestMapping("")
	public String renderCategoryPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		if (search != null) {
			Session session = factory.getCurrentSession();
			String hql = "FROM InvoiceEntity WHERE id LIKE '%" + search + "%' OR name LIKE '%" + search
					+ "%' OR description LIKE '%" + search + "%'";
			Query query = session.createQuery(hql);
			invoices = query.list();
			model.addAttribute("pagedLink", "/admin/invoices?search=" + search);

		} else {
			invoices = getInvoices();
			model.addAttribute("pagedLink", "/admin/invoices");
		}

		PagedListHolder<InvoiceEntity> pagedListHolder = new PagedListHolder<InvoiceEntity>(invoices);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(10);
		pagedListHolder.setPageSize(5);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "hoá đơn");
		model.addAttribute("title", "Quản lý hoá đơn");

		return viewsDirectory + "invoice";
	}

	// ADD INVOICE
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddCategoryPage(ModelMap model, HttpServletRequest request, HttpSession session,
			RedirectAttributes redirectAttributes) throws IOException {

		// session = request.getSession();
		InvoiceEntity invoice = session.getAttribute("invoice") != null
				? (InvoiceEntity) session.getAttribute("invoice")
				: new InvoiceEntity();
		invoice.setId("1234");
		session.setAttribute("invoice", invoice);

		List<ProductEntity> products = getProducts();
		model.addAttribute("products", products);
		model.addAttribute("invoice", invoice);
		model.addAttribute("title", "Thêm hoá đơn");
		return viewsDirectory + "addInvoice";
	}

	// UPDATE INVOICE DETAIL
	@RequestMapping(value = "/add/update", method = RequestMethod.POST)
	public String updateInvoiceDetail(ModelMap model, HttpServletRequest request, HttpSession session,
			RedirectAttributes attributes) throws IOException {
		String[] product_ids = request.getParameterValues("product_id");
		String[] quantities = request.getParameterValues("quantity");
		String[] prices = request.getParameterValues("price");

		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
		List<InvoiceDetailEntity> invoiceDetails = invoice.getInvoiceDetails();
		for (int i = 0; i < product_ids.length; i++) {
			if (!quantities[i].isEmpty() || !prices[i].isEmpty()) {
				int index = searhcInvoiceDetail(invoiceDetails, product_ids[i]);
				if (index == -1) {
					InvoiceDetailEntity invoiceDetail = new InvoiceDetailEntity();
					invoiceDetail.setInvoice(invoice);
					ProductEntity product = new ProductEntity();
					product.setId(product_ids[i]);
					invoiceDetail.setProduct(product);
					invoiceDetail.setQuantity(Integer.parseInt(quantities[i]));
					invoiceDetail.setPrice(Float.parseFloat(prices[i]));
					invoiceDetails.add(invoiceDetail);
				} else {
					invoiceDetails.get(index).setQuantity(Integer.parseInt(quantities[i]));
					invoiceDetails.get(index).setPrice(Float.parseFloat(prices[i]));
				}
			}
		}

		invoice.setInvoiceDetails(invoiceDetails);
		session.setAttribute("invoice", invoice);

		/*
		 * int[] importQuantity =
		 * Integer.parseInt(request.getParameter("importQuantity"));
		 */

		// attributes.addFlashAttribute("message", "Đã thêm thành công");
		return "redirect:/admin/invoices/add";

		/*
		 * List<ProductEntity> products = getProducts(); model.addAttribute("products",
		 * products); model.addAttribute("invoice", invoice);
		 * model.addAttribute("title", "Thêm hoá đơn"); return viewsDirectory +
		 * "addInvoice";
		 */
	}

	public int searhcInvoiceDetail(List<InvoiceDetailEntity> invoiceDetails, String productId) {
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			if (invoiceDetail.getProduct().getId().equals(productId)) {
				return invoiceDetails.indexOf(invoiceDetail);
			}
		}
		return -1;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addInvoice(ModelMap model, @ModelAttribute(value = "invoice") InvoiceEntity invoice,
			BindingResult errors, @RequestParam(value = "image", required = false) MultipartFile image)
			throws IllegalStateException, IOException, InterruptedException {

		return viewsDirectory + "addInvoice";
		/*
		 * if (category.getName().isEmpty()) { errors.rejectValue("name", "category",
		 * "Nhập tên danh mục"); model.addAttribute("nameValid", "is-invalid"); }
		 * 
		 * if (errors.hasFieldErrors("name")) { model.addAttribute("category",
		 * category); model.addAttribute("title", "Thêm Danh Mục"); return
		 * viewsDirectory + "addCategory";
		 * 
		 * } else { List<InvoiceEntity> categories = getCategories(); String categoryId
		 * = Generate.generateCategoryId(categories); category.setId(categoryId);
		 * category.setDateAdded(new Date());
		 * 
		 * if (image.getSize() != 0) { String basePath = uploadFile.getBasePath();
		 * String imageFileName = categoryId +
		 * UploadFile.getExtension(image.getOriginalFilename()); String imagePath =
		 * UploadFile.getCategoryBasePath() + imageFileName;
		 * category.setImage(imagePath);
		 * 
		 * File fileInServer = new
		 * File(context.getRealPath("resources\\upload\\categories\\" + imageFileName));
		 * File fileInResource = new File(basePath + "/categories/" + imageFileName); if
		 * (!fileInServer.exists()) { BufferedOutputStream stream = new
		 * BufferedOutputStream(new FileOutputStream(fileInServer));
		 * stream.write(image.getBytes()); stream.close(); } if
		 * (!fileInResource.exists()) { BufferedOutputStream stream = new
		 * BufferedOutputStream(new FileOutputStream(fileInResource));
		 * stream.write(image.getBytes()); stream.close(); } Thread.sleep(5000); }
		 * 
		 * Session session = factory.openSession(); Transaction t =
		 * session.beginTransaction(); try { session.save(category); t.commit();
		 * System.out.println("Added");
		 * 
		 * } catch (Exception e) { t.rollback(); System.out.println("Error");
		 * System.err.println(e.getMessage()); } finally { session.close(); }
		 * 
		 * return "redirect:/admin/categories"; }
		 */
	}

	// VIEW DETAILS OF INVOICE

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String viewInvoiceDetail(ModelMap model, HttpServletRequest request, @PathVariable(value = "id") String id) {
		System.out.println("Id: " + id);
		InvoiceEntity invoice = getInvoice(id);
		model.addAttribute("invoice", invoice);
		model.addAttribute("title", "Hoá đơn " + invoice.getId());

		PagedListHolder pagedListHolder = new PagedListHolder(invoice.getInvoiceDetails());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(10);
		pagedListHolder.setPageSize(5);

		model.addAttribute("pagedListHolder", pagedListHolder);
		return viewsDirectory + "viewInvoice";
	}

	// GET INVOICES FROM SQL
	public List<InvoiceEntity> getInvoices() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity";
		Query query = session.createQuery(hql);
		List<InvoiceEntity> invoices = query.list();
		session.close();
		return invoices;
	}

	// GET SINGLE INVOICE
	public InvoiceEntity getInvoice(String id) {
		Session session = factory.openSession();
		String hql = "FROM InvoiceEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		InvoiceEntity invoice = (InvoiceEntity) query.list().get(0);
		session.close();
		return invoice;
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

	// GET INVOICE TYPES
	@ModelAttribute("invoiceTypes")
	public List<InvoiceTypeEntity> getInoivceTypes() throws IOException {
		Session session = factory.openSession();
		String hql = "FROM InvoiceTypeEntity";
		Query query = session.createQuery(hql);
		List<InvoiceTypeEntity> invoiceTypes = query.list();
		session.close();
		return invoiceTypes;
	}
}
