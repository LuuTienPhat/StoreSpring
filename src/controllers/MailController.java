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

@Controller
@RequestMapping("/admin/mail")
public class MailController {
	@Autowired
	JavaMailSender mailer;

	/*
	 * @Autowired UploadFile uploadFile;
	 */

	String viewsDirectory = "admin/pages/mail/";

	@RequestMapping("")
	public String renderMailPage(ModelMap model) {
		model.addAttribute("title", "Gửi mail");
		return viewsDirectory + "mail";
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String send(ModelMap model, @RequestParam("email") String email, @RequestParam("subject") String subject,
			@RequestParam("body") String body) {

		try {

			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail);
			//helper.setFrom("");
			helper.setTo(email);
			//helper.setReplyTo("");
			helper.setSubject(subject);
			helper.setText(body, true);

			mailer.send(mail);
			model.addAttribute("message", "Email sent successfully!");

		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("message", "Unable to send email");
			e.printStackTrace();
		}

		return "redirect:/admin/mail";
	}
}
