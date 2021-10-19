package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/")
public class DashboardController {
	@RequestMapping("dashboard")
	public String renderAdminPage(ModelMap model) {
		model.addAttribute("title", "Dashboard");
		return "admin/pages/dashboard";
	}
	
	@RequestMapping("")
	public String renderPage() {
		return "";
	}
}
