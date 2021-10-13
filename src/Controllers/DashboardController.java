package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/")
public class DashboardController {
	@RequestMapping("dashboard")
	public String renderAdminPage() {
		return "admin/dashboard";
	}
	
	@RequestMapping("")
	public String renderPage() {
		return "";
	}
}
