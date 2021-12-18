package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import entities.CategoryEntity;
import entities.OrderDetailEntity;
import entities.OrderEntity;
import entities.ProductEntity;
import models.Pagination;
import models.List.Orders;
import models.dao.OrderDAO;

@Controller
@Transactional

@RequestMapping("/admin/orders")
public class OrdersController {
	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	OrderDAO orderDAO;

	String viewsDirectory = "admin/pages/order/";

	@RequestMapping("")
	public String renderOrderPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search,
			@RequestParam(value = "state", required = false) String state) throws IOException {

		orderDAO = new OrderDAO(factory);
		Orders orders = new Orders();

		String hql2 = "FROM OrderEntity WHERE id LIKE '%" + search + "%' OR orderDate LIKE '%" + search
				+ "%' OR shipName LIKE '%" + search + "%' OR shipAddress LIKE '%" + search + "%' OR shipAddress LIKE '%"
				+ search + "%'" + (state != null ? "OR state LIKE '%" + state + "%'" : "");

		if (search != null) {
			Session session = factory.openSession();
			Query query = session.createQuery(hql2);
			orders = new Orders(query.list());
			session.close();
			model.addAttribute("pagedLink", "/admin/orders?search=" + search + "&&state=" + state);
		} else if (state != null) {
			orders = orderDAO.getOrders(state);
			model.addAttribute("pagedLink", "/admin/orders?state=" + state);
		} else {
			orders = orderDAO.getOrders();
			model.addAttribute("pagedLink", "/admin/orders");
		}

		PagedListHolder pagedListHolder = Pagination.ordersPagination(request, orders.getList(), 10, 5);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("title", "Quản lý đơn hàng");
		model.addAttribute("state", state);
		model.addAttribute("type", "đơn hàng");
		return viewsDirectory + "order";
	}

	// VIEW ORDER
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String renderOrderDetailPage(ModelMap model, HttpServletRequest request, @PathVariable("id") String id)
			throws IOException {

		orderDAO = new OrderDAO(factory);
		OrderEntity order = orderDAO.getOrder(id);
		PagedListHolder pagedListHolder = Pagination.orderDetailPagination(request, order.getOrderDetails(), 10, 10);

		model.addAttribute("order", orderDAO.getOrder(id));
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "đơn hàng");
		model.addAttribute("pagedLink", "admin/orders/" + id);
		model.addAttribute("title", "Đơn hàng " + order.getId());
		return viewsDirectory + "viewOrder";
	}

	// UPDATE ORDER STATE
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	public String changeOrderState(ModelMap model, HttpServletRequest request, @PathVariable("id") String id)
			throws IOException {

		orderDAO = new OrderDAO(factory);
		int state = Integer.parseInt(request.getParameter("state"));

		if (state == 3) { // ADMIN XÁC NHẬN ĐƠN HÀNG ĐÃ XONG
			OrderEntity order = orderDAO.getOrder(id);
			order.setState(state);
			List<OrderDetailEntity> orderDetailList = order.getOrderDetails();
			/* entityData.updateProducts(orderDetailList); */
			orderDAO.updateOrderInDB(order);
		} else {
			OrderEntity order = orderDAO.getOrder(id);
			if (order.getState() != 3) { // NẾU ĐƠN HÀNG CHƯA HOÀN THÀNH THÌ CÓ THỂ XUỐNG THẤP HƠN
				order.setState(state);
				orderDAO.updateOrderInDB(order);
			}
		}

		/*
		 * OrderEntity order = entityData.getOrder(id); model.addAttribute("order",
		 * order); model.addAttribute("title", "Đơn hàng " + order.getId()); return
		 * viewsDirectory + "viewOrder";
		 */
		return "redirect:/admin/orders/" + id;
	}
}
