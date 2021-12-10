package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("captcha")
public class CaptchaController {
	@RequestMapping(value = "index", method = RequestMethod.GET)
	public void index(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("image/jpg");
		int iTotalChars = 0;

	}
}
