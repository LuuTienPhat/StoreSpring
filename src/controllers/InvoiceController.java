package controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.AdminEntity;
import entities.InvoiceDetailEntity;
import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;
import entities.ProductEntity;
import models.Generate;
import models.Pagination;
import models.UploadFile;
import models.List.Invoices;
import models.List.Products;
import models.dao.InvoiceDAO;
import models.dao.ProductDAO;
import models.validator.DateTimeValidator;
import models.validator.InputValidator;

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

	InvoiceDAO invoiceDAO;
	ProductDAO productDAO;

	@RequestMapping("")
	public String renderCategoryPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		invoiceDAO = new InvoiceDAO(factory);
		Invoices invoices = new Invoices();

		if (search != null) {
			invoices = invoiceDAO.searchForInvoice(search);
			model.addAttribute("pagedLink", "/admin/invoices?search=" + search);

		} else {
			invoices = invoiceDAO.getInvoices();
			model.addAttribute("pagedLink", "/admin/invoices");
		}

		PagedListHolder pagedListHolder = Pagination.invoicePagination(request, invoices.getList(), 5, 5);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "hoá đơn");
		model.addAttribute("title", "Quản lý hoá đơn");

		return viewsDirectory + "invoice";
	}

	// ADD INVOICE
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddInvoicePage(ModelMap model, HttpSession session, RedirectAttributes redirectAttributes)
			throws IOException {

		invoiceDAO = new InvoiceDAO(factory);

		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
		if (invoice != null)
			session.setAttribute("invoice", null);

		invoice = new InvoiceEntity();
		Invoices invoices = invoiceDAO.getInvoices();
		invoice.setId(Generate.generateInvoiceId(invoices.getList()));
		invoice.setDate(LocalDate.now().format(DateTimeFormatter.ofPattern("uuuu-MM-dd")));
		invoice.setTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));

		model.addAttribute("invoice", invoice);
		model.addAttribute("invoiceTypes", invoiceDAO.getInoivceTypes());
		model.addAttribute("title", "Thêm hoá đơn");
		model.addAttribute("pageName", "addInvoice");
		return viewsDirectory + "addInvoice";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addInvoice(ModelMap model, HttpServletRequest request, HttpSession session,
			RedirectAttributes redirectAttributes, @ModelAttribute("invoice") InvoiceEntity invoice,
			BindingResult errors) throws IOException {

		int errorsCount = 0;
		String date = invoice.getDate();
		String time = invoice.getTime();
		invoiceDAO = new InvoiceDAO(factory);
		Invoices invoices = invoiceDAO.getInvoices();

		if (invoice.getId().isEmpty()) {
			errors.rejectValue("id", "invoice", "Nhập mã hóa đơn");
			model.addAttribute("idValid", "is-invalid");
			errorsCount++;
		} else if (invoice.getId().length() > 20) {
			errors.rejectValue("id", "invoice", "Mã hóa đơn <= 20 ký tự");
			model.addAttribute("idValid", "is-invalid");
			errorsCount++;
		} else if (invoice.getId().charAt(0) != 'I') {
			errors.rejectValue("id", "invoice", "Mã hóa đơn phải bắt đầu bằng ký tự I");
			model.addAttribute("idValid", "is-invalid");
			errorsCount++;
		} else if (Generate.searchInvoice(invoices.getList(), invoice.getId()) != null) {
			errors.rejectValue("id", "invoice", "Mã hóa đơn đã bị trùng");
			model.addAttribute("idValid", "is-invalid");
			errorsCount++;
		}

		if (date.isEmpty()) {
			errors.rejectValue("date", "invoice", "Nhập ngày lập hoá đơn");
			model.addAttribute("dateValid", "is-invalid");
			errorsCount++;
		} else if (!DateTimeValidator.isDateValid(date)) {
			errors.rejectValue("date", "invoice", "Định dạng ngày tháng không đúng");
			model.addAttribute("dateValid", "is-invalid");
			errorsCount++;
		}

		if (time.isEmpty()) {
			errors.rejectValue("time", "invoice", "Nhập giờ lập hoá đơn");
			model.addAttribute("timeValid", "is-invalid");
			errorsCount++;
		} else if (!DateTimeValidator.isTimeValid(time)) {
			errors.rejectValue("invoiceType.id", "invoice", "Định dạng giờ không đúng");
			model.addAttribute("invoiceTypeValid", "is-invalid");
			errorsCount++;
		}

		if (invoice.getInvoiceType().getId() == 0) {
			errors.rejectValue("invoiceType.id", "invoice", "Chọn loại hoá đơn");
			model.addAttribute("invoiceTypeValid", "is-invalid");
			errorsCount++;
		}

		if (errorsCount != 0) {
			model.addAttribute("invoice", invoice);
			model.addAttribute("invoiceTypes", invoiceDAO.getInoivceTypes());
			model.addAttribute("title", "Thêm hoá đơn");
			model.addAttribute("pageName", "addInvoice");
			return viewsDirectory + "addInvoice";

		} else {
			InvoiceTypeEntity invoiceType = new InvoiceTypeEntity();
			invoiceType.setId(invoice.getInvoiceType().getId());
			invoice.setInvoiceType(invoiceType);

			invoice.setDate(date);
			invoice.setTime(time);

			AdminEntity admin = new AdminEntity();
			admin.setId(session.getAttribute("adminId").toString());
			invoice.setAdmin(admin);

			session.setAttribute("invoice", invoice);
			return "redirect:/admin/invoices/add/invoice-detail";
		}
	}

	// ADD INVOICE DETAIL
	@RequestMapping(value = "/add/invoice-detail", method = RequestMethod.GET)
	public String renderAddInvoiceDetailPage(ModelMap model, HttpServletRequest request, HttpSession session2,
			RedirectAttributes redirectAttributes, @RequestParam(value = "search", required = false) String search)
			throws IOException {

		InvoiceEntity invoice = (InvoiceEntity) session2.getAttribute("invoice");

		if (invoice == null) {
			return "redirect:/admin/invoices/add";
		} else {
			productDAO = new ProductDAO(factory);
			invoiceDAO = new InvoiceDAO(factory);
			Products products = new Products();

			if (search != null) {
				products = productDAO.searchForProduct(search);
				model.addAttribute("pagedLink", "/admin/invoices/add/invoice-detail?search=" + search);

			} else {
				products = productDAO.getProducts();
				model.addAttribute("pagedLink", "/admin/invoices/add/invoice-detail");
			}

			PagedListHolder pagedListHolder = Pagination.productPagination(request, products.getList(), 10, 10);

			model.addAttribute("pagedListHolder", pagedListHolder);
			model.addAttribute("previousPageLink", "admin/invoices/add");
			model.addAttribute("nextPageLink", "admin/invoices/add/preview");
			model.addAttribute("invoice", invoice);
			model.addAttribute("type", "sản phẩm");
			model.addAttribute("title", "Thêm hoá đơn");
			model.addAttribute("pageName", "addInvoiceDetail");
			return viewsDirectory + "addInvoiceDetail";
		}
	}

	// UPDATE INVOICE DETAIL
	@RequestMapping(value = "/add/invoice-detail", method = RequestMethod.POST)
	public String updateInvoiceDetail(ModelMap model, HttpServletRequest request, HttpSession session,
			RedirectAttributes redirectAttributes) throws IOException {
		invoiceDAO = new InvoiceDAO(factory);
		productDAO = new ProductDAO(factory);

		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");

		if (invoice == null) {
			return "redirect:/admin/invoices/add";
		} else {

			String url = request.getRequestURI();

			String productId = request.getParameter("productId");
			String oldQuantity = request.getParameter("oldQuantity");
			String newQuantity = request.getParameter("newQuantity");
			String price = request.getParameter("price");

			int errorCount = 0;
			if (!InputValidator.isInputNumberValid(newQuantity)) {
				errorCount++;
			} else if (invoice.getInvoiceType().getId() == 2) {
				if (Integer.parseInt(oldQuantity) < Integer.parseInt(newQuantity)) {
					errorCount++;
				}
			}

			if (!InputValidator.isInputNumberValid(price)) {
				errorCount++;
			}

			if (errorCount != 0) {
				redirectAttributes.addFlashAttribute("message", "Lỗi cập nhật sản phẩm " + productId + "!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			} else {
				List<InvoiceDetailEntity> invoiceDetails = invoice.getInvoiceDetails();
				int index = searhcInvoiceDetail(invoiceDetails, productId);
				// NẾU CHI TIẾT HÓA ĐƠN KHÔNG CÓ SẢN PHẨM
				if (index == -1) {
					InvoiceDetailEntity invoiceDetail = new InvoiceDetailEntity();
					invoiceDetail.setInvoice(invoice);
					ProductEntity product = productDAO.getProduct(productId);
					invoiceDetail.setProduct(product);
					invoiceDetail.setQuantity(Integer.parseInt(newQuantity));
					invoiceDetail.setPrice(Float.parseFloat(price));
					invoiceDetails.add(invoiceDetail);
				}

//				// NẾU CÓ SẢN PHẨM
				else {
					invoiceDetails.get(index).setQuantity(Integer.parseInt(newQuantity));
					invoiceDetails.get(index).setPrice(Float.parseFloat(price));

				}
			}
		}
		return "redirect:/admin/invoices/add/invoice-detail";

		// HOA DON NHAP
//			if(invoice.getInvoiceType().getId() == 1) {
//			}
//			
//			//HOA DON XUAT
//			else {
//				
//			}

//		
//		String[] product_ids = request.getParameterValues("product_id");
//		String[] quantities = request.getParameterValues("quantity");
//		String[] prices = request.getParameterValues("price");
//		String[] rows = request.getParameterValues("rows");
//
//		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
//		HashMap<String, String> errors = new HashMap<String, String>();
//
//		// NẾU HÓA ĐƠN KHÔNG NULL
//		if (invoice != null) {
//
//			// LẤY DANH SÁCH CHI TIẾT HÓA ĐƠN TRONG HÓA ĐƠN
//			List<InvoiceDetailEntity> invoiceDetails = invoice.getInvoiceDetails();
//
//			// DUYỆT QUA TỪNG SẢN PHẨM
//			for (int i = 0; i < product_ids.length; i++) {
//
//				// NẾU SỐ LƯỢNG NHÂP/XUẤT VÀ GIÁ TIỀN KHÔNG RỖNG
//				if (!quantities[i].isEmpty() && !prices[i].isEmpty()) {
//
//					// TÌM KIẾM SẢN PHẨM TRONG DANH SÁCH CHI TIẾT HÓA ĐƠN
//					int index = searhcInvoiceDetail(invoiceDetails, product_ids[i]);
//
//					// NẾU CHI TIẾT HÓA ĐƠN KHÔNG CÓ SẢN PHẨM
//					if (index == -1) {
//						InvoiceDetailEntity invoiceDetail = new InvoiceDetailEntity();
//						invoiceDetail.setInvoice(invoice);
//						ProductEntity product = entityData.getProduct(product_ids[i]);
//						invoiceDetail.setProduct(product);
//						invoiceDetail.setQuantity(Integer.parseInt(quantities[i]));
//						invoiceDetail.setPrice(Float.parseFloat(prices[i]));
//						invoiceDetails.add(invoiceDetail);
//					}
//
//					// NẾU CÓ SẢN PHẨM
//					else {
//						invoiceDetails.get(index).setQuantity(Integer.parseInt(quantities[i]));
//						invoiceDetails.get(index).setPrice(Float.parseFloat(prices[i]));
//					}
//				}
//
//				// NẾU CÓ Ô ĐỂ TRỐNG
//				else {
////					redirectAttributes.addFlashAttribute("message", "Không thể cập nhật!");
////					redirectAttributes.addFlashAttribute("messageType", "error");
//					errors.put(product_ids[i], "Lỗi nhập liệu");
//
//				}
//			}
//			redirectAttributes.addFlashAttribute("errors", errors);
//			invoice.setInvoiceDetails(invoiceDetails);
//			session.setAttribute("invoice", invoice);
//		}

	}

//	public String checkError(String newQuantity, String oldQuantity, String price) {
//		if(newQuantity > oldQuantity) {
//			return ""
//		}
//		
//	}

	// PREVIEW INVOICE
	@RequestMapping(value = "/add/preview", method = RequestMethod.GET)
	public String previewInvoice(ModelMap model, HttpSession session) {
		System.out.println("preview");
		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");

		if (invoice == null) {
			return "redirect:/admin/invoices/add";
		} else {
			System.out.println(invoice.getId());
			model.addAttribute("previousPageLink", "admin/invoices/add/invoice-detail");
			model.addAttribute("nextPageLink", "admin/invoices/add/finish");

			model.addAttribute("type", "preview");
			model.addAttribute("invoice", invoice);
			model.addAttribute("title", "Hoá đơn " + invoice.getId());
			return viewsDirectory + "viewInvoice";
		}
	}

	// FINISH INVOICE
	@RequestMapping(value = "/add/finish", method = RequestMethod.GET)
	public String finsishInvoice(ModelMap model, HttpSession session, RedirectAttributes redirectAttributes)
			throws IOException {
		System.out.println("finish");
		invoiceDAO = new InvoiceDAO(factory);
		productDAO = new ProductDAO(factory);

		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");

		if (invoice == null) {
			return "redirect:/admin/invoices/add";
		} else {
			if (invoice.getInvoiceType().getId() == 1) {
				for (InvoiceDetailEntity invoiceDetail : invoice.getInvoiceDetails()) {
					ProductEntity product = productDAO.getProduct(invoiceDetail.getProduct().getId());
					product.setQuantity(product.getQuantity() + invoiceDetail.getQuantity());
					productDAO.updateProductInDB(product);
				}
			} else {
				for (InvoiceDetailEntity invoiceDetail : invoice.getInvoiceDetails()) {
					ProductEntity product = productDAO.getProduct(invoiceDetail.getProduct().getId());
					product.setQuantity(product.getQuantity() - invoiceDetail.getQuantity());
					productDAO.updateProductInDB(product);
				}
			}

			if (invoiceDAO.addInvoiceToDB(invoice)) {
				redirectAttributes.addFlashAttribute("message", "Thêm hoá đơn thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể thêm hoá đơn!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
			return "redirect:/admin/invoices/add";
		}
	}

	// VIEW DETAILS OF INVOICE
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String viewInvoiceDetail(ModelMap model, HttpServletRequest request, @PathVariable(value = "id") String id) {
		System.out.println("Id: " + id);
		invoiceDAO = new InvoiceDAO(factory);
		InvoiceEntity invoice = invoiceDAO.getInvoice(id);
		model.addAttribute("invoice", invoice);
		model.addAttribute("title", "Hoá đơn " + invoice.getId());
		return viewsDirectory + "viewInvoice";
	}

	public int searhcInvoiceDetail(List<InvoiceDetailEntity> invoiceDetails, String productId) {
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			if (invoiceDetail.getProduct().getId().equals(productId)) {
				return invoiceDetails.indexOf(invoiceDetail);
			}
		}
		return -1;
	}
}
