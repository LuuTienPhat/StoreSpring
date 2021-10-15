package controllers;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import models.UploadFile;

@Controller
@RequestMapping("/upload/")
public class UploadController {
	/*
	 * @RequestMapping("form") public String form() { return "job/form"; }
	 * 
	 * @Autowired ServletContext context;
	 * 
	 * @Autowired UploadFile uploadFile;
	 * 
	 * @RequestMapping(value = "product", method = RequestMethod.POST) public String
	 * addProduct(ModelMap model, @RequestParam("name") String fullname,
	 * 
	 * @RequestParam("category") String category, @RequestParam("image")
	 * MultipartFile image,
	 * 
	 * @RequestParam("quantity") String quantity, @RequestParam("price") float
	 * price) {
	 * 
	 * 
	 * 
	 * if (image.isEmpty()) { model.addAttribute("message", "Vui lòng chọn file"); }
	 * else { try { String date =
	 * LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss-"));
	 * String photoName = date + photo.getOriginalFilename(); String photoPath =
	 * uploadFile.getBasePath() + File.separator + photoName; // String photoPath =
	 * context.getRealPath("/files/" + // photo.getOriginalFilename());
	 * photo.transferTo(new File(photoPath)); System.out.println(photoPath);
	 * 
	 * String cvName = date + fullname + "-" + cv.getOriginalFilename(); String
	 * cvPath = uploadFile.getBasePath() + File.separator + cvName; // String cvPath
	 * = context.getRealPath("/files/" + cv.getOriginalFilename());
	 * cv.transferTo(new File(cvPath)); Thread.sleep(2500);
	 * 
	 * model.addAttribute("fullname", fullname); model.addAttribute("photo_name",
	 * photo.getOriginalFilename()); model.addAttribute("cv_name",
	 * cv.getOriginalFilename()); model.addAttribute("cv_type",
	 * cv.getContentType()); model.addAttribute("cv_size", cv.getSize());
	 * 
	 * return "job/apply"; } catch (Exception e) { // TODO: handle exception
	 * model.addAttribute("message", "Lỗi lưu file"); } }
	 * 
	 * return "job/form"; }
	 */
}
