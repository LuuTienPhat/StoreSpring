package models;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("mailer")
public class Mailer {
	@Autowired
	JavaMailSender mailer;

	private String from = "storespring21@gmail.com";

	public void send(String from, String to, String subject, String body) {
		try {
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");
			helper.setFrom(from, from);
			helper.setTo(to);
			helper.setReplyTo(from, from);
			helper.setSubject(subject);
			helper.setText(body, true);
//			mail.setContent(body,"text/html");
			mailer.send(mail);

		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
	}

	public boolean send(String to, String subject, String body) {
		try {
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");
			helper.setFrom(this.from, this.from);
			helper.setTo(to);
			helper.setReplyTo(this.from, this.from);
			helper.setSubject(subject);
			helper.setText(body, true);
//			mail.setContent(body,"text/html");
			mailer.send(mail);
			return true;

		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}
}
