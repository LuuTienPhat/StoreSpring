package controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.NoHandlerFoundException;

@Controller
@RequestMapping("/admin/")
public class ErrorController {

	String viewsDirectory = "admin/error/";

	@RequestMapping("400")
	public String render404Page(ModelMap model, HttpServletRequest request) {
		model.addAttribute("title", "404 - Page Not Found!");
		System.out.println("404 page");
		return viewsDirectory + "404";
	}

	@RequestMapping("500")
	public String render500Page(ModelMap model) {
		model.addAttribute("title", "500 – Internal Server Error!");
		return viewsDirectory + "500";
	}

}
