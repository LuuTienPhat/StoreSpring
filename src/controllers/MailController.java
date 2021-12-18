package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import models.MailModel;
import models.Mailer;
import models.validator.InputValidator;

@Controller
@RequestMapping("/admin/mail")
public class MailController {
	@Autowired
	JavaMailSender mailer;

	String viewsDirectory = "admin/pages/mail/";

	@RequestMapping("")
	public String renderMailPage(ModelMap model) {
		model.addAttribute("title", "Gửi mail");
		model.addAttribute("mail", new MailModel());
		return viewsDirectory + "mail";
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public String renderMailPageWithEmail(ModelMap model,
			@RequestParam(value = "email", required = true) String email) {

		MailModel mail = new MailModel();
		mail.setEmail(email);

		model.addAttribute("mail", mail);
		model.addAttribute("title", "Gửi mail");
		return viewsDirectory + "mail";
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String send(ModelMap model, @ModelAttribute("mail") MailModel mailModel, BindingResult errors,
			RedirectAttributes redirectAttributes) {

		int errorCount = 0;

		if (!InputValidator.isInputValid(mailModel.getEmail())) {
			errors.rejectValue("email", "mail", "Nhập địa chỉ email nhận");
			model.addAttribute("emailValid", "is-invalid");
			errorCount++;
		} else if (!InputValidator.isEmailValid(mailModel.getEmail())) {
			errors.rejectValue("email", "mail", "Email không hợp lệ!");
			model.addAttribute("emailValid", "is-invalid");
			errorCount++;
		}

		if (!InputValidator.isInputValid(mailModel.getSubject())) {
			errors.rejectValue("subject", "mail", "Nhập tựa đề mail");
			model.addAttribute("subjectValid", "is-invalid");
			errorCount++;
		}

		if (!InputValidator.isInputValid(mailModel.getBody())) {
			errors.rejectValue("body", "mail", "Nhập nội dung mail");
			model.addAttribute("bodyValid", "is-invalid");
			errorCount++;
		}

		if (errorCount != 0) {
			model.addAttribute("message", "Xin hãy nhập đầy đủ thông tin!");
			model.addAttribute("messageType", "error");
			model.addAttribute("mail", mailModel);
			model.addAttribute("title", "Gửi mail");
			return viewsDirectory + "mail";
		} else {
			Mailer mailer = new Mailer();

			if (mailer.send(mailModel.getEmail(), mailModel.getSubject(), mailModel.getBody())) {
				redirectAttributes.addFlashAttribute("message", "Gửi Email thành công!");
				redirectAttributes.addFlashAttribute("messageType", "success");
			} else {
				redirectAttributes.addFlashAttribute("message", "Không thể gửi email");
				redirectAttributes.addFlashAttribute("messageType", "error");
			}
			return "redirect:/admin/mail";
		}
	}
}
