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
import org.hibernate.Transaction;
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

import entities.AccountEntity;
import entities.AdminEntity;
import entities.CategoryEntity;
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
			return "redirect:/admin/dashboard";
		}

		model.addAttribute("account", new AccountEntity());
		model.addAttribute("title", "Admin Đăng nhập");
		return viewsDirectory + "login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(RedirectAttributes redirectAttributes, ModelMap model, HttpServletRequest request,
			@Validated @ModelAttribute("account") AccountEntity account, BindingResult errors) {
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
			String hql = "FROM AccountEntity WHERE username = '" + username + "' AND password = '" + password + "'";
			Query query = session.createQuery(hql);

			if (!query.list().isEmpty()) {
				AccountEntity admin = (AccountEntity) query.list().get(0);
				HttpSession session2 = request.getSession();
				session2.setAttribute("admin", admin.getId());
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
		AdminEntity admin = new AdminEntity();

		model.addAttribute("admin", admin);
		model.addAttribute("title", "Admin Lost Password");
		return viewsDirectory + "forgot-password";
	}

	@RequestMapping(value = "forgot-password", method = RequestMethod.POST)
	public String getRecoveryCode(ModelMap model, HttpServletRequest request,
			@ModelAttribute("admin") AdminEntity admin, BindingResult errors) {

		int errorCount = 0;
		if (admin.getId().isEmpty()) {
			errors.rejectValue("id", "admin", "AdminID không được để trống!");
			model.addAttribute("idValid", "is-invalid");
			errorCount++;
		}

		if (admin.getAccount().getUsername().isEmpty()) {
			errors.rejectValue("account.username", "category", "Tên đăng nhập không được để trống!");
			model.addAttribute("usernameValid", "is-invalid");
			errorCount++;
		}

		if (admin.getEmail().isEmpty()) {
			errors.rejectValue("email", "category", "Email không được để trống!");
			model.addAttribute("emailValid", "is-invalid");
			errorCount++;
		}

		if (errors.hasErrors()) {
			model.addAttribute("admin", admin);
			model.addAttribute("title", "Admin Lost Password");
			return viewsDirectory + "forgot-password";
		}

		else {
			Session session = factory.openSession();
			String hql = "FROM AdminEntity WHERE account.username = '" + admin.getAccount().getUsername() + "' AND id = '" + admin.getId() + "' AND email = '" + admin.getEmail() + "'";
			Query query = session.createQuery(hql);
			System.out.println(query.list().size());
			//session.close();

			if (!query.list().isEmpty()) {
				AdminEntity admin2 = (AdminEntity) query.list().get(0);
				admin2.getAccount().setRecovery(generateId(5));
				updateDB(admin2);
				return viewsDirectory + "reset-password";
			} else {
				return "redirect:/admin/login";
			}
		}
	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		session.setAttribute("admin", null);
		return "redirect:/admin/login";
	}
	
	public void updateDB(Object entity) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(entity);
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
	
	/*
	 * public AdminInfoEntity getAdmin(AdminInfoEntity admin) { Session session =
	 * factory.openSession(); String hql = "FROM CategoryEntity WHERE id = '" + id +
	 * "'"; Query query = session. CategoryEntity category = (CategoryEntity)
	 * query.list().get(0); session.close(); return category; }
	 */
	

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
