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
import models.Pagination;
import models.UploadFile;
import models.List.Customers;
import models.dao.CustomerDAO;

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

	CustomerDAO customerDAO;

	String viewsDirectory = "admin/pages/customer/";

	@RequestMapping("")
	public String renderCustomerPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {

		Customers customers = new Customers();
		customerDAO = new CustomerDAO(factory);

		customerDAO = new CustomerDAO(factory);
		if (search != null) {
			customers = customerDAO.searchForCustomer(search);
			model.addAttribute("pagedLink", "/admin/categories?search=" + search);

		} else {
			customers = customerDAO.getCustomers();
			model.addAttribute("pagedLink", "/admin/categories");
		}

		PagedListHolder pagedListHolder = Pagination.customerPagination(request, customers.getList(), 10, 10);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("title", "Quản lý Khách hàng");
		model.addAttribute("type", "khách hàng");
		return viewsDirectory + "customer";
	}

	// VIEW CUSTOMER
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String productDetail(ModelMap model, @PathVariable("id") String id, HttpServletRequest request)
			throws IOException {

		customerDAO = new CustomerDAO(factory);
		CustomerEntity customer = customerDAO.getCustomer(id);

		PagedListHolder pagedListHolder = Pagination.ordersPagination(request, customer.getOrders(), 10, 10);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "đơn hàng");
		model.addAttribute("customer", customer);
		model.addAttribute("title", "Khách hàng " + customer.getId());
		return viewsDirectory + "viewCustomer";
	}
}
