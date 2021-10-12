package Interceptor;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


@Transactional
public class GlobalInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	SessionFactory factory;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("Global Interceptor preHandler()");
		
		/*
		 * Session session = factory.getCurrentSession(); String hql =
		 * "FROM MajorEntity"; Query query = session.createQuery(hql); List
		 * <MajorEntity> list = query.list(); request.setAttribute("majors", list);
		 */
	
		return true;
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("Global Interceptor postHandler()");
		HttpSession session = request.getSession();
		session.setAttribute("title", "Lab 7");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.out.println("Global Interceptor afterCompletion()");
	}
}
