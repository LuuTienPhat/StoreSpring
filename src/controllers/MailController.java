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
@RequestMapping("/admin/")
public class MailController {
	@Autowired
	JavaMailSender mailer;

	@Autowired
	UploadFile uploadFile;
	
	String viewsDirectory = "admin/pages/mail/";

	@RequestMapping("mail")
	public String renderMailPage(ModelMap model) {
		model.addAttribute("title", "Gửi mail");
		return viewsDirectory + "mail";
	}

	@RequestMapping(value = "send", method = RequestMethod.POST)
	public String send(ModelMap model, @RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("subject") String subject, @RequestParam("body") String body) {
		
		try {

			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail);
			helper.setFrom("luutienphat10@gmail.com", "luutienphat10@gmail.com");
			helper.setTo(email);
			helper.setReplyTo("luutienphat10@gmail.com", "luutienphat10@gmail.com");
			helper.setSubject(subject);
			helper.setText(body, true);

			mailer.send(mail);
			model.addAttribute("message", "Gửi Email thành công");

		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("message", "Gửi Email thất bại");
		}

		return "mailer/form";
	}
}
