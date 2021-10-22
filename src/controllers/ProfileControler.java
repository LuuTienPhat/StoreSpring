package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/profile")
public class ProfileControler {
	
	String viewsDirectory = "admin/pages/profile/";
	
	@RequestMapping("")
	public String renderProfilePage() {
		return viewsDirectory + "profile";
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST )
	public String editProfile() {
		return viewsDirectory + "profile";
	}
}
