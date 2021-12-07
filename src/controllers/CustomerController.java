package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import entities.CustomerEntity;
import entities.InvoiceDetailEntity;
import models.EntityData;
import models.Pagination;
import models.UploadFile;

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

	EntityData entityData;

	String viewsDirectory = "admin/pages/customer/";

	@RequestMapping("")
	public String renderCustomerPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		List<CustomerEntity> customers = new ArrayList<CustomerEntity>();
		entityData = new EntityData(factory);

		entityData = new EntityData(factory);
		if (search != null) {
			customers = entityData.searchForCustomer(search);
			model.addAttribute("pagedLink", "/admin/categories?search=" + search);

		} else {
			customers = entityData.getCustomers();
			model.addAttribute("pagedLink", "/admin/categories");
		}

		PagedListHolder<CustomerEntity> pagedListHolder = Pagination.customerPagination(request, customers, 10, 10);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("title", "Quản lý Khách hàng");
		model.addAttribute("type", "khách hàng");
		return viewsDirectory + "customer";
	}

	/*
	 * @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET) public
	 * String deleteCustomer(ModelMap model, @PathVariable("id") String id) throws
	 * IOException { CustomerEntity customer = new CustomerEntity();
	 * customer.setId(id);
	 * 
	 * Session session = factory.openSession(); Transaction t =
	 * session.beginTransaction(); try { session.delete(customer); t.commit();
	 * System.out.println("Deleted");
	 * 
	 * } catch (Exception e) { t.rollback(); System.out.println("Error");
	 * e.printStackTrace(); } finally { session.close(); }
	 * 
	 * return "redirect:/admin/customers"; }
	 */

	// VIEW CUSTOMER
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") String id, HttpServletRequest request)
			throws IOException {

		entityData = new EntityData(factory);
		CustomerEntity customer = entityData.getCustomer(id);

		PagedListHolder pagedListHolder = Pagination.ordersPagination(request, customer.getOrders(), 10, 10);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "đơn hàng");
		model.addAttribute("customer", customer);
		model.addAttribute("title", "Khách hàng " + customer.getId());
		return viewsDirectory + "viewCustomer";
	}
}
