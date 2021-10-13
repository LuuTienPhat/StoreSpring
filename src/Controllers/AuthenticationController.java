package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Models.Login;


@Controller
@RequestMapping("/admin/")
public class AuthenticationController {
	@RequestMapping(value = "login")
	public String renderSignInPage() {
		return "admin/pages/login";
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String signIn(@ModelAttribute("user") Login login) {
		
		
		return "index";
	}
	
	@RequestMapping("register")
	public String renderSignUpPage() {
		return "admin/pages/register";
	}
	
	@RequestMapping("forgot-password")
	public String renderForgotPasswordPage() {
		return "admin/pages/forgot-password";
	}
}
