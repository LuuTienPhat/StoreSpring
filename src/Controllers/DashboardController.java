package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashboardController {
	@RequestMapping("/index")
	public String renderAdminPage() {
		return "admin/index";
	}
}
