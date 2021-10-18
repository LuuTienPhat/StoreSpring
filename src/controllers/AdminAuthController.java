package controllers;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.validator.constraints.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import entities.AdminEntity;
import models.Account;
import models.Login;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminAuthController {
	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	String viewsDirectory = "admin/pages/account/";

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String renderLoginPage(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		if (session.getAttribute("admin") != null) {
			/*
			 * String referer = request.getHeader("Ref"); System.out.println(referer);
			 * return "redirect:" + referer;
			 */
		}

		model.addAttribute("account", new AdminEntity());
		model.addAttribute("title", "Admin Đăng nhập");
		return viewsDirectory + "login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(RedirectAttributes redirectAttributes, ModelMap model, HttpServletRequest request,
			@Validated @ModelAttribute("account") AdminEntity account, BindingResult errors) {
		/*
		 * String username = request.getParameter("username"); String password =
		 * request.getParameter("password");
		 */

		if (errors.hasErrors()) {
			if (errors.hasFieldErrors("username")) {
				model.addAttribute("usernameValid", "is-invalid");
			} else {
				model.addAttribute("usernameValid", "is-valid");
			}

			if (errors.hasFieldErrors("password")) {
				model.addAttribute("passwordValid", "is-invalid");
			} else {
				model.addAttribute("passwordValid", "is-valid");
			}

			return viewsDirectory + "login";
		} else {
			String username = account.getUsername();
			String password = account.getPassword();

			Session session = factory.getCurrentSession();
			String hql = "FROM AdminEntity WHERE username = '" + username + "' AND password = '" + password + "'";
			Query query = session.createQuery(hql);

			if (!query.list().isEmpty()) {
				AdminEntity admin = (AdminEntity) query.list().get(0);
				HttpSession session2 = request.getSession();
				session2.setAttribute("admin", admin.getUsername());
				return "redirect:/admin/dashboard";
				// return new RedirectView(request.getContextPath() + "/admin/dashboard");
			}
			
			else {
				model.addAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
				model.addAttribute("title", "Admin Đăng nhập");
				return viewsDirectory + "login";
			}
		}
	}

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String renderSignUpPage() {
		return viewsDirectory + "register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register() {
		String id = generateId(5);

		return "redirect:/admin/login";
	}

	@RequestMapping("forgot-password")
	public String renderForgotPasswordPage(ModelMap model) {
		model.addAttribute("title", "Admin Lost Password");
		return viewsDirectory + "forgot-password";
	}

	@RequestMapping(value = "forgot-password", method = RequestMethod.POST)
	public String getRecoveryCode(ModelMap model, HttpServletRequest request, @RequestParam(value = "id") String id,
			@RequestParam(value = "username") String username, @RequestParam(value = "email") String email) {
		model.addAttribute("title", "Admin Lost Password");

		Session session = factory.getCurrentSession();
		String hql = "SELECT * FROM Admin JOIN AdminInfo ON Admin.id = AdminInfo.userId WHERE username = '" + username + "' AND Admin.id = '" + id + "' AND AdminInfo.email = '" +  email + "'";
		Query query = session.createQuery(hql);

		if (!query.list().isEmpty()) {
			AdminEntity admin = (AdminEntity) query.list().get(0);
			HttpSession session2 = request.getSession();
			session2.setAttribute("admin", admin.getUsername());
			return "redirect:/admin/dashboard";
		} else {
			return "redirect:/admin/login";
		}

		/* return viewsDirectory + "forgot-password"; */
	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		session.setAttribute("admin", null);
		return "redirect:/admin/login";
	}

	public static String generateId(int targetStringLength) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 57; // numeral '9'
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength - 1)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

		return "A" + generatedString;
	}
}
