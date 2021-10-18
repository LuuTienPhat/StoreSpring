package controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import entities.ProductEntity;
import models.UploadFile;

@Transactional
@Controller
@RequestMapping("/admin/products")
public class ProductController {
	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	String viewsDirectory = "admin/pages/product/";
	
	@RequestMapping("")
	public String renderProductPage(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> products = query.list();
		System.out.println(products.get(0).getId());
		model.addAttribute("productList", products);
		return viewsDirectory  + "product";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String renderAddProductPage(ModelMap model) {
		Session session = factory.getCurrentSession();
		model.addAttribute("user", new ProductEntity());
		return viewsDirectory  + "addProduct";
	}

	@RequestMapping(value = "product/add", method = RequestMethod.POST)
	public String addProduct(ModelMap model, @ModelAttribute("product") ProductEntity product) {
		String id = generateId(10);
		System.out.println(product.getName());
		/*
		 * Session session = factory.openSession(); Transaction t =
		 * session.beginTransaction(); try { session.save(product); t.commit();
		 * model.addAttribute("message", "Thêm thành công!");
		 * 
		 * } catch (Exception ex) { t.rollback(); model.addAttribute("message",
		 * "Thêm thất bại!"); } finally { session.close(); }
		 */

		return "admin/pages/addProduct";
	}

	@RequestMapping("form")
	public String form() {
		return "job/form";
	}

	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	public static String generateId(int targetStringLength) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

		return generatedString;
	}

	/*
	 * @RequestMapping(value = "product", method = RequestMethod.POST) public String
	 * addProduct(ModelMap model, @ModelAttribute("product") ProductEntity product)
	 * {
	 * 
	 * String id = generateId(10); Session session = factory.openSession();
	 * Transaction t = session.beginTransaction(); try { session.save(product);
	 * t.commit(); model.addAttribute("message", "Thêm thành công!");
	 * 
	 * } catch (Exception ex) { t.rollback(); model.addAttribute("message",
	 * "Thêm thất bại!"); } finally { session.close(); }
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
	 * 
	 * return "redirect:/admin/dashboard.html"; }
	 */
}
