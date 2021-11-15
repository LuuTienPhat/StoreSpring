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

import entities.AdminEntity;
import entities.InvoiceDetailEntity;
import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;
import entities.ProductEntity;
import models.DateTimeValidator;
import models.EntityData;
import models.Generate;
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

	EntityData entityData;

	@RequestMapping("")
	public String renderCategoryPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		entityData = new EntityData(factory);

		if (search != null) {
			invoices = entityData.searchForInvoice(search);
			model.addAttribute("pagedLink", "/admin/invoices?search=" + search);

		} else {
			invoices = entityData.getInvoices();
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
	public String renderAddInvoicePage(ModelMap model, HttpSession session, RedirectAttributes redirectAttributes)
			throws IOException {

		entityData = new EntityData(factory);
		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
		if (invoice != null)
			session.setAttribute("invoice", null);

		model.addAttribute("invoice", new InvoiceEntity());
		model.addAttribute("invoiceTypes", entityData.getInoivceTypes());
		model.addAttribute("title", "Thêm hoá đơn");
		model.addAttribute("pageName", "addInvoice");
		return viewsDirectory + "addInvoice";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addInvoice(ModelMap model, HttpServletRequest request, HttpSession session,
			RedirectAttributes redirectAttributes, @ModelAttribute("invoice") InvoiceEntity invoice,
			BindingResult errors) throws IOException {

		int errorsCount = 0;
		String date = request.getParameter("date");
		String time = request.getParameter("time");

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

		if (invoice.getInvoiceType().getId().isEmpty()) {
			errors.rejectValue("invoiceType.id", "invoice", "Chọn loại hoá đơn");
			model.addAttribute("invoiceTypeValid", "is-invalid");
			errorsCount++;
		}

		if (errorsCount != 0) {
			model.addAttribute("invoice", invoice);
			model.addAttribute("title", "Thêm hoá đơn");
			model.addAttribute("pageName", "addInvoice");
			return viewsDirectory + "addInvoice";

		} else {
			invoice.setDate(date);
			invoice.setTime(time);
			AdminEntity admin = new AdminEntity();
			admin.setId(session.getAttribute("admin").toString());
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
			List<ProductEntity> products = new ArrayList<ProductEntity>();
			entityData = new EntityData(factory);

			if (search != null) {
				products = entityData.searchForProduct(search);
				model.addAttribute("pagedLink", "/admin/invoices/add/invoice-detail?search=" + search);

			} else {
				products = entityData.getProducts();
				model.addAttribute("pagedLink", "/admin/invoices/add/invoice-detail");
			}

			PagedListHolder pagedListHolder = new PagedListHolder(products);
			int page = ServletRequestUtils.getIntParameter(request, "p", 0);
			pagedListHolder.setPage(page);
			pagedListHolder.setMaxLinkedPages(5);
			pagedListHolder.setPageSize(5);

			model.addAttribute("pagedListHolder", pagedListHolder);
			model.addAttribute("previousPageLink", "admin/invoices/add");
			model.addAttribute("nextPageLink", "admin/invoices/add/preview");
			model.addAttribute("invoice", invoice);
			model.addAttribute("title", "Thêm hoá đơn");
			model.addAttribute("pageName", "addInvoiceDetail");
			return viewsDirectory + "addInvoiceDetail";
		}
	}

	// UPDATE INVOICE DETAIL
	@RequestMapping(value = "/add/invoice-detail", method = RequestMethod.POST)
	public String updateInvoiceDetail(ModelMap model, HttpServletRequest request, HttpSession session,
			RedirectAttributes attributes) throws IOException {
		entityData = new EntityData(factory);

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
					ProductEntity product = entityData.getProduct(product_ids[i]);
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
		return "redirect:/admin/invoices/add/invoice-detail";
	}

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
		System.out.println("preview");
		entityData = new EntityData(factory);
		InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");

		if (invoice == null) {
			return "redirect:/admin/invoices/add";
		} else {
			invoice.setId(Generate.generateInvoiceId(entityData.getInvoices()));
			if (entityData.addInvoiceToDB(invoice)) {
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
		entityData = new EntityData(factory);
		InvoiceEntity invoice = entityData.getInvoice(id);
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
