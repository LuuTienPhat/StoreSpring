package interceptors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class GlobalInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	ServletContext application;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		System.out.println("Global Interceptor preHandler()");
		
		// DEFAULT PAGE LINKS
		// ADMIN
		application.setAttribute("dashboardPage", "admin/dashboard");
		application.setAttribute("loginPage", "admin/login");
		application.setAttribute("logoutPage", "admin/logout");
		application.setAttribute("registerPage", "admin/register");
		application.setAttribute("resetPasswordPage", "admin/reset-password");
		application.setAttribute("forgotPasswordPage", "admin/forgot-password");
		application.setAttribute("productPage", "admin/products");	
		application.setAttribute("addProductPage", "admin/products/add");
		application.setAttribute("categoryPage", "admin/categories");
		application.setAttribute("addCategoryPage", "admin/categories/add");
		application.setAttribute("mailPage", "admin/mail");
		
		// STORE
		application.setAttribute("storeIndexPage", "");
		application.setAttribute("productDetailPage", "store/product-detail");
		application.setAttribute("signInPage", "store/sign-in");
		application.setAttribute("signUpPage", "store/sign-up");
		application.setAttribute("shoppingCartPage", "store/shopping-cart");
		return true;
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		//System.out.println("Global Interceptor postHandler()");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//System.out.println("Global Interceptor afterCompletion()");
	}
}
