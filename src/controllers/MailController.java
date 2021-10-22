package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import models.UploadFile;

import java.io.File;
import java.nio.file.FileSystem;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

@Controller
@RequestMapping("/admin/mail")
public class MailController {
	@Autowired
	JavaMailSender mailer;

	@Autowired
	UploadFile uploadFile;

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
