package interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminAuthInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// System.out.println("Authorize Interceptor preHandler()");
		HttpSession session = request.getSession();

		if (session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin/login");
			return false;
		}
		
		/*
		 * String referer = request.getHeader("Referer"); System.out.println(referer);
		 * response.sendRedirect(request.getContextPath() + referer);
		 */
		return true;

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// System.out.println("Authorize Interceptor postHandler()");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// System.out.println("Authorize Interceptor afterCompletion()");
	}
}
