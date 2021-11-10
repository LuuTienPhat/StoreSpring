package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {
	
	String viewsDirectory = "admin/pages/dashboard/";
	
	@RequestMapping("")
	public String renderAdminPage(ModelMap model) {
		model.addAttribute("title", "Dashboard");
		return viewsDirectory +  "dashboard";
	}
}
