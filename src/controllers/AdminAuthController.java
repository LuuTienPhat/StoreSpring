package controllers;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.AccountEntity;
import entities.AdminEntity;
import entities.CategoryEntity;
import models.AdminResetPasswordModel;
import models.EntityData;
import models.Mailer;
import models.dao.AccountDAO;
import models.dao.DAO;
import models.validator.InputValidator;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminAuthController {
	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	Mailer mailer;

	EntityData entityData;

	String viewsDirectory = "admin/pages/account/";

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String renderLoginPage(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		AdminEntity admin = null;
		String adminId = "";
		try {
			adminId = session.getAttribute("adminId").toString();
			admin = (AdminEntity) session.getAttribute("admin");
		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("account", new AccountEntity());
			model.addAttribute("title", "Admin Đăng nhập");
			return viewsDirectory + "login";

		}
		return "redirect:/admin/dashboard";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(RedirectAttributes redirectAttributes, ModelMap model, HttpSession session,
			@Validated @ModelAttribute("account") AccountEntity login, BindingResult errors) {

		entityData = new EntityData(factory);

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
			String username = login.getUsername();
			String password = login.getPassword();

			AccountEntity account = entityData.getAccount(username, password);

			if (account != null) {
				session.setAttribute("adminId", account.getId());
				// session.setAttribute("admin", account.getAdmin());
				return "redirect:/admin/dashboard";
			} else {
				model.addAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
				model.addAttribute("messageType", "error");
				model.addAttribute("title", "Admin Đăng nhập");
				model.addAttribute("account", login);
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
		String id = generateRecoveryCode(5);

		return "redirect:/admin/login";
	}

	// FORGOT PASSWORD
	@RequestMapping("forgot-password")
	public String renderForgotPasswordPage(ModelMap model) {
		AdminEntity admin = new AdminEntity();

		model.addAttribute("admin", admin);
		model.addAttribute("title", "Admin Lost Password");
		return viewsDirectory + "forgot-password";
	}

	@RequestMapping(value = "forgot-password", method = RequestMethod.POST)
	public String getRecoveryCode(ModelMap model, HttpServletRequest request, HttpSession session,
			@ModelAttribute("admin") AdminEntity admin, BindingResult errors, RedirectAttributes redirectAttributes) {

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

		if (errorCount != 0) {
			model.addAttribute("admin", admin);
			model.addAttribute("title", "Quên mật khẩu");
			return viewsDirectory + "forgot-password";
		}

		else {
			AccountDAO dao = new AccountDAO(factory);
			AccountEntity account = dao.getAccount(admin.getId(), admin.getAccount().getUsername(), admin.getEmail());
			if (account != null) {
				session.setAttribute("adminId", account.getId());
				session.setMaxInactiveInterval(1000 * 60 * 5);
				String recoveryCode = generateRecoveryCode(5);
				account.setRecovery(recoveryCode);
				dao.updateAccount(account);

				mailer.send(account.getAdmin().getEmail(), "Mã khôi phục mật khẩu", recoveryCode);
				return "redirect:/admin/reset-password";
			} else {
				redirectAttributes.addFlashAttribute("message", "Không tìm thấy Admin!");
				redirectAttributes.addFlashAttribute("messageType", "error");
				return "redirect:/admin/reset-password";
			}
		}
	}

	// RESET PASSWORD
	@RequestMapping(value = "reset-password", method = RequestMethod.GET)
	public String renderResetPasswordPage(ModelMap model, HttpSession session) {
		String adminId = null;
		try {
			adminId = session.getAttribute("adminId").toString();
			if (adminId != null) {
				AdminResetPasswordModel resetPassword = new AdminResetPasswordModel();
				model.addAttribute("reset-password", resetPassword);
				model.addAttribute("title", "Khôi phục mật khẩu");
				return viewsDirectory + "reset-password";
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "redirect:/admin/forgot-password";
	}

	@RequestMapping(value = "reset-password", method = RequestMethod.POST)
	public String resetPassword(ModelMap model, HttpServletRequest request, HttpSession session,
			@ModelAttribute("reset-password") AdminResetPasswordModel resetPassword, BindingResult errors,
			RedirectAttributes redirectAttributes) {

		AccountDAO dao = new AccountDAO(factory);
		try {
			String adminId = session.getAttribute("adminId").toString();
		} catch (Exception e) {
			// TODO: handle exception
			return "redirect:/admin/forgot-password";
		}

		int errorCount = 0;
		if (!InputValidator.isInputValid(resetPassword.getRecoveryCode())) {
			errors.rejectValue("recoveryCode", "reset-password", "Xin hãy nhập mã khôi phục!");
			model.addAttribute("recoveryCodeValid", "is-invalid");
			errorCount++;
		}
		if (!InputValidator.isInputValid(resetPassword.getNewPassword())) {
			errors.rejectValue("newPassword", "reset-password", "Xin hãy nhập mật khẩu mới!");
			model.addAttribute("newPasswordValid", "is-invalid");
			errorCount++;
		}
		if (!InputValidator.isInputValid(resetPassword.getRePassword())) {
			errors.rejectValue("rePassword", "reset-password", "Xin hãy nhập lại mật khẩu mới!");
			model.addAttribute("rePasswordValid", "is-invalid");
			errorCount++;
		} else if (!resetPassword.getRePassword().trim().equals(resetPassword.getNewPassword().trim())) {
			errors.rejectValue("rePassword", "reset-password", "Mật khẩu không trùng khớp");
			model.addAttribute("rePasswordValid", "is-invalid");
			errorCount++;
		}
		if (errorCount != 0) {
			model.addAttribute("reset-password", resetPassword);
			model.addAttribute("message", "Xin hãy nhập đúng thông tin");
			model.addAttribute("messageType", "error");
			model.addAttribute("title", "Khôi phục mật khẩu");
			return viewsDirectory + "reset-password";
		}

		else {
			String adminId = null;
			try {
				adminId = session.getAttribute("adminId").toString();
				AccountEntity account = dao.getAccount(adminId, resetPassword.getRecoveryCode());

				/*
				 * if (admin.getAccount().getRecovery().equals(resetPassword.getRecoveryCode()))
				 * { admin.getAccount().setPassword(resetPassword.getNewPassword());
				 * admin.getAccount().setRecovery(""); updateAccount(admin); }
				 */
				if (account != null) {
					account.setPassword(resetPassword.getNewPassword());
					account.setRecovery("");
					dao.updateAccount(account);
					session.removeAttribute("adminId");
					redirectAttributes.addFlashAttribute("message", "Khôi phục mật khẩu thành công!");
					redirectAttributes.addFlashAttribute("messageType", "success");
					return "redirect:/admin/login";
				} else {
					redirectAttributes.addFlashAttribute("message", "Mã khôi phục không trùng khớp!");
					redirectAttributes.addFlashAttribute("messageType", "error");
					return "redirect:/admin/reset-password";
				}
			} catch (Exception e) {
				// TODO: handle exception
				redirectAttributes.addFlashAttribute("message", "Mã khôi phục đã hết hạn!");
				redirectAttributes.addFlashAttribute("messageType", "error");
				return "redirect:/admin/forgot-password";
			}
		}
	}

	// LOGOUT
	@RequestMapping("logout")
	public String logout(HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("adminId");
		session.removeAttribute("admin");
		return "redirect:/admin/login";
	}

	public AdminEntity getAdmin(String id) {

		Session session = factory.openSession();
		String hql = "FROM AdminEntity WHERE id = '" + id + "'";
		Query query = session.createQuery(hql);
		AdminEntity admin = (AdminEntity) query.list().get(0);
		session.close();
		return admin;
	}

	public static String generateRecoveryCode(int targetStringLength) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 57; // numeral '9'
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
		return generatedString;
	}
}
