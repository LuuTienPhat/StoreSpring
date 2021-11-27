package controllers;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.AccountEntity;
import entities.AdminEntity;
import entities.ProductEntity;
import models.EntityData;
import models.Generate;
import models.UploadFile;
import models.validator.DateTimeValidator;
import models.validator.InputValidator;

@Controller
@RequestMapping("/admin/profile")
public class ProfileControler {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	EntityData entityData;

	String viewsDirectory = "admin/pages/profile/";

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String renderProfilePage(ModelMap model, HttpSession session) throws IOException {

		AdminEntity admin = (AdminEntity) session.getAttribute("admin");
		model.addAttribute("admin", admin);
		model.addAttribute("title", "Thông tin");
		model.addAttribute("type", "admin");
		return viewsDirectory + "profile";
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public String updateProfile(ModelMap model, HttpSession session, @ModelAttribute("admin") AdminEntity modifiedAdmin,
			BindingResult errors, RedirectAttributes redirectAttributes) {

		int errorsCount = 0;

		if (!InputValidator.isFirstnameValid(modifiedAdmin.getFirstname().trim())) {
			errors.rejectValue("firstname", "admin", "Tên không hợp lệ");
			model.addAttribute("firstnameValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isInputValid(modifiedAdmin.getLastname())) {
			errors.rejectValue("lastname", "admin", "Họ không hợp lệ");
			model.addAttribute("lastnameValid", "is-invalid");
			errorsCount++;
		}

		if (!DateTimeValidator.isDateValid(modifiedAdmin.getBirthday())) {
			errors.rejectValue("birthday", "admin", "Ngày sinh không hợp lệ");
			model.addAttribute("birthdayValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isGenderValid(modifiedAdmin.getGender())) {
			errors.rejectValue("gender", "admin", "Giới tính không hợp lệ");
			model.addAttribute("genderValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isPhoneValid(modifiedAdmin.getPhone())) {
			errors.rejectValue("phone", "admin", "Số điện thoại không hợp lệ");
			model.addAttribute("phoneValid", "is-invalid");
			errorsCount++;
		}

		if (!InputValidator.isEmailValid(modifiedAdmin.getEmail())) {
			errors.rejectValue("email", "admin", "Email không hợp lệ");
			model.addAttribute("emailValid", "is-invalid");
			errorsCount++;
		}

		if (errorsCount != 0) {
			model.addAttribute("admin", modifiedAdmin);
			model.addAttribute("title", "Thông tin");
			model.addAttribute("pageName", "profile");
			model.addAttribute("message", "Vui lòng điền đầy đủ thông tin!");
			model.addAttribute("messageType", "warning");
			return viewsDirectory + "profile";

		} else {
			EntityData entityData = new EntityData(factory);
			AdminEntity admin = (AdminEntity) session.getAttribute("admin");
			admin.setFirstname(modifiedAdmin.getFirstname());
			admin.setLastname(modifiedAdmin.getLastname());
			admin.setBirthday(modifiedAdmin.getBirthday());
			admin.setPhone(modifiedAdmin.getPhone());
			admin.setAddress(modifiedAdmin.getAddress());
			admin.setGender(modifiedAdmin.getGender());
			admin.setEmail(modifiedAdmin.getEmail());

			if (entityData.updateAdminInDB(admin)) {
				redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể cập nhật thông tin!");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
		}

		return "redirect:/admin/profile";
	}
}
