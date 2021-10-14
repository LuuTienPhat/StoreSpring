package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GiftController {
	@RequestMapping("product-detail")
	public String productDetail() {
		return "store/product-detail";
	}
	@RequestMapping("sign-in")
	public String signIn() {
		return "store/sign-in";
	}
	@RequestMapping("sign-up")
	public String signUp() {
		return "store/sign-up";
	}
	@RequestMapping("shopping-cart")
	public String shoppingCart() {
		return "store/shopping-cart";
	}
}
