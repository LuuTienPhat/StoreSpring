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
import models.EntityData;

@Controller
@Transactional

@RequestMapping("/admin/orders")
public class OrderController {
	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	EntityData entityData;

	String viewsDirectory = "admin/pages/order/";

	@RequestMapping("")
	public String renderOrderPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search,
			@RequestParam(value = "state", required = false) String state) throws IOException {

		entityData = new EntityData(factory);
		List<OrderEntity> orders = new ArrayList<OrderEntity>();
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderEntity WHERE state LIKE '%" + state + "%'";

		String hql2 = "FROM OrderEntity WHERE id LIKE '%" + search + "%' OR orderDate LIKE '%" + search
				+ "%' OR shipName LIKE '%" + search + "%' OR shipAddress LIKE '%" + search + "%' OR total LIKE '%"
				+ search + "%' OR shipAddress LIKE '%" + search + "%'"
				+ (state != null ? "OR state LIKE '%" + state + "%'" : "");

		if (search != null) {
			Query query = session.createQuery(hql2);
			orders = query.list();
			model.addAttribute("pagedLink", "/admin/categories?search=" + search + "&&state=" + state);
		} else if (state != null) {
			{
				Query query = session.createQuery(hql);
				orders = query.list();
				model.addAttribute("pagedLink", "/admin/categories?state=" + state);
			}
		} else {
			orders = entityData.getOrders();
			model.addAttribute("pagedLink", "/admin/categories");
		}

		model.addAttribute("title", "Quản lý đơn hàng");
		model.addAttribute("state", state);
		PagedListHolder pagedListHolder = pagination(request, orders);
		model.addAttribute("pagedListHolder", pagedListHolder);
		return viewsDirectory + "order";
	}

	// VIEW ORDER
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String renderOrderDetailPage(ModelMap model, HttpServletRequest request, @PathVariable("id") String id)
			throws IOException {

		entityData = new EntityData(factory);
		OrderEntity order = entityData.getOrder(id);
		model.addAttribute("order", entityData.getOrder(id));
		PagedListHolder pagedListHolder = pagination(request, order.getOrderDetails());
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("type", "sản phẩm");
		model.addAttribute("pagedLink", "admin/orders/" + id);
		model.addAttribute("title", "Đơn hàng " + order.getId());
		return viewsDirectory + "viewOrder";
	}

	// UPDATE ORDER STATE
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	public String changeOrderState(ModelMap model, HttpServletRequest request, @PathVariable("id") String id)
			throws IOException {
		int state = Integer.parseInt(request.getParameter("state"));

		if (state == 2) { // admin xac nhan don hang da xong
			OrderEntity order = entityData.getOrder(id);
			order.setState(state);
			List<OrderDetailEntity> orderDetailList = order.getOrderDetails();
			entityData.updateProducts(orderDetailList);
		} else {
			OrderEntity order = entityData.getOrder(id);

			if (order.getState() != 2) { // neu don hang da duoc admin xac nhan thi khong duoc xuong state thap hon
				order.setState(state);

				Session session = factory.openSession();
				Transaction t = session.beginTransaction();
				try {
					session.merge(order);
					t.commit();
					System.out.println("Updated");

				} catch (Exception e) {
					t.rollback();
					System.out.println("Error");
					e.printStackTrace();
				} finally {
					session.close();
				}
			}
		}

		OrderEntity order = entityData.getOrder(id);
		model.addAttribute("order", order);
		model.addAttribute("title", "Đơn hàng " + order.getId());
		return viewsDirectory + "viewOrder";
	}

	public PagedListHolder pagination(HttpServletRequest request, List list) {
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		return pagedListHolder;
	}
}
