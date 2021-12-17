package interceptors;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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

import entities.OrderEntity;

@Transactional
public class GlobalInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	ServletContext application;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

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
		application.setAttribute("ordersPage", "admin/orders");
		application.setAttribute("customerPage", "admin/customers");
		application.setAttribute("profilePage", "admin/profile");
		application.setAttribute("invoicePage", "admin/invoices");
		application.setAttribute("addInvoicePage", "admin/invoices/add");
		application.setAttribute("addAdminPage", "admin/add");
		application.setAttribute("topFavoriteProductsPage", "top-favorite-products");
		application.setAttribute("mostViewedProductsPage", "most-viewed-products");
		application.setAttribute("topRevenueProductsPage", "top-revenue-products");

		// STORE
		application.setAttribute("storeIndexPage", "");
		application.setAttribute("productDetailPage", "store/product-detail");
		application.setAttribute("signInPage", "store/sign-in");
		application.setAttribute("signUpPage", "store/sign-up");
		application.setAttribute("shoppingCartPage", "store/shopping-cart");
		application.setAttribute("userInfoPage", "store/user-info");
		application.setAttribute("changePasswordPage", "store/user-info/change-password");
		application.setAttribute("logOutPage", "store/log-out");
		application.setAttribute("orderHistoryPage", "store/user-info/order-history");
		application.setAttribute("userFavoritePage", "store/user-info/favorite");
		application.setAttribute("forgotPassPage", "store/forgot-password");
		return true;

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// System.out.println("Global Interceptor postHandler()");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// System.out.println("Global Interceptor afterCompletion()");
	}
}
