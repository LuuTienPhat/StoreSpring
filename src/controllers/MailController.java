package controllers;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/mail")
public class MailController {
	@Autowired
	JavaMailSender mailer;

	String viewsDirectory = "admin/pages/mail/";

	@RequestMapping("")
	public String renderMailPage(ModelMap model) {
		model.addAttribute("title", "Gửi mail");
		return viewsDirectory + "mail";
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public String renderMailPageWithEmail(ModelMap model,
			@RequestParam(value = "email", required = true) String email) {
		model.addAttribute("title", "Gửi mail");
		model.addAttribute("email", email);
		return viewsDirectory + "mail";
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String send(ModelMap model, @RequestParam("email") String email, @RequestParam("subject") String subject,
			@RequestParam("body") String body, RedirectAttributes redirectAttributes) {

		try {
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail);
			// helper.setFrom("");
			helper.setTo(email);
			// helper.setReplyTo("");
			helper.setSubject(subject);
			helper.setText(body, true);

			mailer.send(mail);
			redirectAttributes.addFlashAttribute("message", "Gửi Email thành công!");
			redirectAttributes.addFlashAttribute("messageType", "success");

		} catch (Exception e) {
			// TODO: handle exception
			redirectAttributes.addFlashAttribute("message", "Không thể gửi email");
			redirectAttributes.addFlashAttribute("messageType", "error");
			e.printStackTrace();
		}

		return "redirect:/admin/mail";
	}
}
