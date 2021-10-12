package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import Models.Login;


@Controller
public class SignInController {
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String renderSignInPage() {
		return "admin/signin";
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String signIn(@ModelAttribute("user") Login login) {
		
		
		return "index";
	}
}
