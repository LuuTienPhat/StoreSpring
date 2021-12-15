package controllers;

import java.io.File;
import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.AccountEntity;
import entities.AdminEntity;
import models.AdminResetPasswordModel;
import models.Generate;
import models.Mailer;
import models.UploadFile;
import models.List.Admins;
import models.dao.AccountDAO;
import models.dao.AdminDAO;
import models.validator.DateTimeValidator;
import models.validator.InputValidator;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminAuthController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	Mailer mailer;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	AdminDAO adminDAO;
	AccountDAO accountDAO;

	String viewsDirectory = "admin/pages/account/";

	// LOGIN
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
			model.addAttribute("title", "Đăng nhập");
			return viewsDirectory + "login";

		}
		return "redirect:/admin/dashboard";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(RedirectAttributes redirectAttributes, ModelMap model, HttpSession session,
			@Validated @ModelAttribute("account") AccountEntity login, BindingResult errors) {

		adminDAO = new AdminDAO(factory);
		accountDAO = new AccountDAO(factory);

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

			AccountEntity account = accountDAO.getAccountAuth(username, password);

			if (account != null) {
				session.setAttribute("adminId", account.getId());
				// session.setAttribute("admin", account.getAdmin());
				return "redirect:/admin/dashboard";
			} else {
				model.addAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
				model.addAttribute("messageType", "error");
				model.addAttribute("title", "Đăng nhập");
				model.addAttribute("account", login);
				return viewsDirectory + "login";
			}
		}
	}

	// REGISTER
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String renderSignUpPage(ModelMap model, HttpSession session) {
		AdminEntity admin = new AdminEntity();
		model.addAttribute("newAdmin", admin);
		model.addAttribute("title", "Đăng ký");
		return viewsDirectory + "register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String updateProfile(ModelMap model, HttpSession session, HttpServletRequest request,
			@RequestParam(value = "image", required = false) MultipartFile image,
			@RequestParam(value = "cover", required = false) MultipartFile cover,
			@ModelAttribute("newAdmin") AdminEntity newAdmin, BindingResult errors,
			RedirectAttributes redirectAttributes) throws IOException, InterruptedException {

		int errorsCount = 0;
		adminDAO = new AdminDAO(factory);
		Admins admins = adminDAO.getAdmins();

		if (!InputValidator.isFirstnameValid(newAdmin.getFirstname().trim())) {
			errors.rejectValue("firstname", "admin", "Tên không hợp lệ");
			model.addAttribute("firstnameValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isInputValid(newAdmin.getLastname())) {
			errors.rejectValue("lastname", "admin", "Họ không hợp lệ");
			model.addAttribute("lastnameValid", "is-invalid");
			errorsCount++;
		}

		if (!DateTimeValidator.isDateValid(newAdmin.getBirthday())) {
			errors.rejectValue("birthday", "admin", "Ngày sinh không hợp lệ");
			model.addAttribute("birthdayValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isGenderValid(newAdmin.getGender())) {
			errors.rejectValue("gender", "admin", "Giới tính không hợp lệ");
			model.addAttribute("genderValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isPhoneValid(newAdmin.getPhone())) {
			errors.rejectValue("phone", "admin", "Số điện thoại không hợp lệ");
			model.addAttribute("phoneValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isEmailValid(newAdmin.getEmail())) {
			errors.rejectValue("email", "admin", "Email không hợp lệ");
			model.addAttribute("emailValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isInputValid(newAdmin.getAccount().getUsername())) {
			errors.rejectValue("account.username", "admin", "Tên đăng nhập không hợp lệ");
			model.addAttribute("usernameValid", "is-invalid");
			errorsCount++;
		} else if (Admins.isUserNameExist(admins, newAdmin.getAccount().getUsername())) {
			errors.rejectValue("account.username", "admin", "Tên đăng nhập không hợp lệ");
			model.addAttribute("usernameValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isInputValid(newAdmin.getAccount().getPassword())) {
			errors.rejectValue("account.password", "admin", "Mật khẩu không hợp lệ");
			model.addAttribute("passwordValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isInputValid(request.getParameter("rePassword"))) {
			model.addAttribute("rePasswordValid", "is-invalid");
			errorsCount++;
		}

		if (errorsCount != 0) {
			model.addAttribute("newAdmin", newAdmin);
			model.addAttribute("title", "Đăng ký");
			model.addAttribute("message", "Vui lòng điền đầy đủ thông tin!");
			model.addAttribute("messageType", "warning");
			return viewsDirectory + "register";

		} else {
			adminDAO = new AdminDAO(factory);
			String adminId = Generate.generateAdminId(adminDAO.getAdmins().getList());
			newAdmin.setId(adminId);

			File folderInServer = new File(
					uploadFile.getUploadPathOnServer(context) + "admins/" + newAdmin.getId() + "/");
			File folderInResource = new File(uploadFile.getUploadPath() + "admins/" + newAdmin.getId() + "/");

			if (!folderInResource.exists())
				folderInResource.mkdir();
			if (!folderInServer.exists())
				folderInServer.mkdir();

			if (image.getSize() != 0) {
				String imageFileName = "image" + UploadFile.getExtension(image.getOriginalFilename());
				String imagePath = uploadFile.getRelativeUploadPath() + "admins/" + newAdmin.getId() + "/"
						+ imageFileName;
				newAdmin.setImage(imagePath);

				File fileInServer = new File(
						uploadFile.getUploadPathOnServer(context) + "admins/" + newAdmin.getId() + "/" + imageFileName);
				File fileInResource = new File(
						uploadFile.getUploadPath() + "admins/" + newAdmin.getId() + "/" + imageFileName);

				UploadFile.writeFile(fileInServer, image);
				UploadFile.writeFile(fileInResource, image);

				Thread.sleep(2000);
			}

			if (cover.getSize() != 0) {
				String imageFileName = "cover" + UploadFile.getExtension(cover.getOriginalFilename());
				String imagePath = uploadFile.getRelativeUploadPath() + "admins/" + newAdmin.getId() + "/"
						+ imageFileName;
				newAdmin.setCover(imagePath);

				File fileInServer = new File(
						uploadFile.getUploadPathOnServer(context) + "admins/" + newAdmin.getId() + "/" + imageFileName);
				File fileInResource = new File(
						uploadFile.getUploadPath() + "admins/" + newAdmin.getId() + "/" + imageFileName);

				UploadFile.writeFile(fileInServer, cover);
				UploadFile.writeFile(fileInResource, cover);

				Thread.sleep(2000);
			}

			if (adminDAO.updateAdminInDB(newAdmin)) {
				redirectAttributes.addFlashAttribute("message", "Thêm quản trị viên thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể thêm quản trị viên");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
		}

		return "redirect:/admin/profile";
	}

	// FORGOT PASSWORD
	@RequestMapping("forgot-password")
	public String renderForgotPasswordPage(ModelMap model) {
		AdminEntity admin = new AdminEntity();

		model.addAttribute("admin", admin);
		model.addAttribute("title", "AdminDAO Lost Password");
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
				redirectAttributes.addFlashAttribute("message", "Không tìm thấy AdminDAO!");
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
