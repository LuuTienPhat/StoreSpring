package interceptors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import entities.AdminEntity;
import models.List.Orders;
import models.dao.AdminDAO;
import models.dao.OrderDAO;

@Transactional
public class AdminAuthInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	ServletContext application;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// System.out.println("Authorize Interceptor preHandler()");
		HttpSession session = request.getSession();

		if (session.getAttribute("adminId") == null) {
			response.sendRedirect(request.getContextPath() + "/admin/login");
			return false;
		} else {
			String adminId = session.getAttribute("adminId").toString();

			OrderDAO orderDAO = new OrderDAO(factory);
			AdminDAO adminDAO = new AdminDAO(factory);
			Orders orders = orderDAO.getLatestOrders("0", "DESC");
			application.setAttribute("lastestOrders", orders.getList());

			/*
			 * AdminEntity admin = (AdminEntity) session.getAttribute("admin"); AdminEntity
			 * admin2 = entityData.getAdmin(admin.getAccount().getUsername(),
			 * admin.getAccount().getPassword()); session.setAttribute("admin", admin2);
			 */

			AdminEntity admin = adminDAO.getAdmin(adminId);
			session.setAttribute("admin", admin);
		}
		return true;

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// System.out.println("Authorize Interceptor postHandler()");
		HttpSession session = request.getSession();
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// System.out.println("Authorize Interceptor afterCompletion()");
	}
}
