package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WelcomeController {
	@RequestMapping(value = "/index")
	public String welcome() {
		
		return "index";
	}
	
	@RequestMapping(value="signin")
	public String signin() {
		return "sign-in";
	}
}
