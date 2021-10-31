package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import entities.CategoryEntity;
import entities.OrderEntity;

@Controller
@Transactional

@RequestMapping("/admin/orders")
public class OrderController {
	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;
	
	String viewsDirectory = "admin/pages/order/";

	@RequestMapping("")
	public String renderOrderPage(ModelMap model, HttpServletRequest request,
			@RequestParam(value = "search", required = false) String search) throws IOException {
		
		
		model.addAttribute("orders", getOrders());
		
		model.addAttribute("title", "Quản lý đơn hàng");
		return viewsDirectory + "order";
	}
	
	@RequestMapping("/{id}")
	public String renderOrderDetailPage(ModelMap model, @PathVariable("id") String id) throws IOException {
		System.out.print(getOrder(id).toString());
		model.addAttribute("order", getOrder(id));
		model.addAttribute("title", "Quản lý đơn hàng");
		return viewsDirectory + "viewOrder";
	}
	
	@RequestMapping("/update-state")
	public String changeOrderState(ModelMap model, HttpServletRequest request) throws IOException {
		int state = Integer.parseInt(request.getParameter("state")) ;
		String id = request.getParameter("id");
		
		OrderEntity order = getOrder(id);
		
		
		model.addAttribute("title", "Quản lý đơn hàng");
		return viewsDirectory + "order";
	}
	
	// GET ORDERS FROM SQL
		public List<OrderEntity> getOrders() throws IOException {
			Session session = factory.getCurrentSession();
			String hql = "FROM OrderEntity";
			Query query = session.createQuery(hql);
			List<OrderEntity> orders = query.list();
			return orders;
		}
		
		//GET SINGLE ORDER
		public OrderEntity getOrder(String id) {
			Session session = factory.getCurrentSession();
			String hql = "FROM OrderEntity WHERE id = '" + id + "'";
			Query query = session.createQuery(hql);
			OrderEntity order = (OrderEntity) query.list().get(0);
			return order;
		}
}
