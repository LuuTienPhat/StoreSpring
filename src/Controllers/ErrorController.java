package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class ErrorController {
	@RequestMapping("404")
	public String render404Page() {
		System.out.println("404 page");
		return "admin/error/404";
	}
	
	@RequestMapping("500")
	public String render500Page() {
		return "admin/error/500";
	}
}
