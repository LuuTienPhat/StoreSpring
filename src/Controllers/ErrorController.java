package Controllers;

import org.springframework.web.bind.annotation.RequestMapping;

// ĐỂ IN CÁC TRANG LỖI 404 và 500
public class ErrorController {
	@RequestMapping("404")
	public String render404Page() {
		return "error/404";
	}
	
	public String render500Page() {
		return "error/500";
	}
}
