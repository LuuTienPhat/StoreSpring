package controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.CartDetailEntity;
import entities.CustomerEntity;
import entities.FavoriteProductEntity;
import entities.OrderEntity;
import entities.ProductEntity;
import models.ChangePasswordModel;
import models.CustomerForgotPasswordModel;
import models.CustomerLoginAccountModel;
import models.CustomerValidateModel;
import models.Mailer;
import models.OrderModel;

@Transactional
@Controller
@RequestMapping("/store")
public class GiftController {
	@Autowired
	SessionFactory factory;
	@Autowired
	Mailer mailer;

	@RequestMapping("")
	public String store(ModelMap model, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("list", method.getListProduct());
		if ((httpSession.getAttribute("customerUsername") != null)) {
			int sum = 0;
			for (CartDetailEntity c : method
					.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
			model.addAttribute("listFavorite", method.getListFavourite(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		}

		return "store/index";
	}

	@RequestMapping("/")
	public String store2(ModelMap model, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (httpSession.getAttribute("customerUsername") != null) {
			int sum = 0;
			for (CartDetailEntity c : method
					.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
			model.addAttribute("listFavorite", method.getListFavourite(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		}
		model.addAttribute("list", method.getListProduct());
		return "store/index";
	}

	@RequestMapping("/product-detail/{productId}")
	public String productDetail2(@PathVariable("productId") String productId, ModelMap model, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (httpSession.getAttribute("listRecentViewProducts") != null) {
			List<ProductEntity> lpe = (List<ProductEntity>) httpSession.getAttribute("listRecentViewProducts");
			boolean existed = false;
			for (ProductEntity pe : lpe) {
				if (pe.getId().equals(productId)) {
					existed = true;
				}
			}
			if (!existed) {
				lpe.add(0, method.getProduct(productId));
			}
			httpSession.setAttribute("listRecentViewProducts", lpe);
		} else {
			List<ProductEntity> lpe = new ArrayList<ProductEntity>();
			lpe.add(0, method.getProduct(productId));
			httpSession.setAttribute("listRecentViewProducts", lpe);
		}
		method.updateProductViews(productId, method.getProduct(productId).getViews() + 1);
		model.addAttribute("product", method.getProduct(productId));
		model.addAttribute("listFavorite", method.getListFavourite(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		System.out.println(productId + "; " + method.getProduct(productId).getName());
		return "store/product-detail";
	}

	@RequestMapping(value = "/sign-in")
	public String signIn(ModelMap model, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);

		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("account", new CustomerLoginAccountModel());
		if ((httpSession.getAttribute("customerUsername") != null)) {
			attributes.addFlashAttribute("message", "Vui lòng đăng xuất nếu muốn đăng nhập lại");
			return returnRedirectControl("index");
		}
		return "store/sign-in";
	}

	@RequestMapping(value = "/forgot-password")
	public String forgotPassword(ModelMap model, HttpSession httpSession, RedirectAttributes attributes) {
		if ((httpSession.getAttribute("customerUsername") != null)) {
			attributes.addFlashAttribute("message", "Bạn không thể khôi phục mật khẩu khi đã đăng nhập");
			return returnRedirectControl("index");
		}
		Methods method = new Methods(factory);

		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("account", new CustomerForgotPasswordModel());

		return "store/forgot-password";
	}

	@RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
	public String forgotPassword2(@ModelAttribute("account") CustomerForgotPasswordModel account, ModelMap model,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (account.getUsername().trim().length() == 0) {
			errors.rejectValue("username", "account", "Vui lòng nhập tên đăng nhập!");
		} else if (!method.isCustomerWithUsernameExit(account.getUsername())) {
			errors.rejectValue("username", "account", "Tên đăng nhập không tồn tại!");
		}
		if (account.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "account", "Vui lòng nhập email!");
		} else if (!validateEmail(account.getEmail().trim())) {
			errors.rejectValue("email", "account", "Email không đúng định dạng!");
		} else if (!account.getEmail().equals(method.getEmailOfCustomerWithUsername(account.getUsername()))) {
			errors.rejectValue("email", "account", "Email không đúng với tài khoản!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Thông tin bạn nhập không đúng!");

			return "store/forgot-password";
		} else {
			if (account.getRecoveryCode().trim().length() == 0) {
				String body = "<h3  style='margin: 8px 0;'>Mã khôi phục của bạn là: <span style='display: inline-block; padding: 4px 8px; background-color: yellow'>"
						+ method.getRecoveryCodeOfCustomerWithUsername(account.getUsername()) + "</span></h3>";
				body = body + "<p>Sau khi nhập mã khôi phục mật khẩu của bạn sẽ trở thành 12345</p>"
						+ "<p>Để tăng tính bảo mật hãy đổi mật khẩu ngay sau khi khôi phục</p>";
				try {
					mailer.send("storespring21@gmail.com", account.getEmail(), "Email về việc cấp lại mật khẩu.",
							body);
					model.addAttribute("message", "Đã gửi mail khôi phục mật khẩu!");

					System.out.println("Gửi email thành công!");
					return "store/forgot-password";
				} catch (Exception ex) {
					System.out.println("Gửi email thất bại!");
				}
			} else if (account.getRecoveryCode().trim().length() != 0) {
				if (account.getRecoveryCode().trim()
						.equals(method.getRecoveryCodeOfCustomerWithUsername(account.getUsername()))) {
					CustomerEntity ce = new CustomerEntity();
					ce.setPassword("12345");
					ce.setId(method.getCustomerIdByUserName(account.getUsername().trim()));
					if (method.updateCustomerForgotPassword(ce, httpSession)) {
						if (method.updateCustomerRecoveryCode(ce, httpSession)) {
							attributes.addFlashAttribute("message", "Khôi phục mật khẩu thành công!");
							return "redirect:/store/sign-in";
						}
						System.out.println("Không thể tạo mã khôi phục mới");
						model.addAttribute("message", "Đã xảy ra lỗi!");
						return "store/forgot-password";
					}

				}
			} else {
				errors.rejectValue("recoveryCode", "account", "Sai mã xác nhận!");
				return "store/forgot-password";
			}
//			httpSession.setAttribute("customerUsername", account.getUsername());
//			int sum = 0;
//			for (CartDetailEntity c : method.getCustomerByUsername(account.getUsername()).getCartDetails()) {
//				sum = sum + c.getQuantity();
//			}
//			System.out.println(sum);
//			httpSession.setAttribute("customerTotalQuantity", sum);

		}
		return "store/forgot-password";
	}

	@RequestMapping(value = "/log-out")
	public String logOut(ModelMap model, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		httpSession.removeAttribute("customerUsername");
		return "redirect:/";
	}

	@RequestMapping(value = "/sign-in", method = RequestMethod.POST)
	public String signIn(@ModelAttribute("account") CustomerLoginAccountModel account, ModelMap model,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (!method.isCustomerWithUsernameExit(account.getUsername())) {
			errors.rejectValue("username", "account", "Tên đăng nhập không tồn tại!");
		} else if (!account.getPassword().equals(method.getPasswordOfCustomerWithUsername(account.getUsername()))) {
			errors.rejectValue("password", "account", "Mật khẩu không đúng!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Thông tin đăng nhập sai!");

			return "store/sign-in";
		} else {
			httpSession.setAttribute("customerUsername", account.getUsername());
			int sum = 0;
			for (CartDetailEntity c : method.getCustomerByUsername(account.getUsername()).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
			attributes.addFlashAttribute("message", "Đăng nhập thành công!");
			return "redirect:/";
		}
	}

	@RequestMapping("/sign-up")
	public String signUp(ModelMap model, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		if ((httpSession.getAttribute("customerUsername") != null)) {
			attributes.addFlashAttribute("message", "Vui lòng đăng xuất nếu muốn đăng ký tài khoản mới");
			return returnRedirectControl("index");
		}
		httpSession.setAttribute("listCategory", method.getListCategory());
		System.out.println(method.createTheNextCustomerId());
		model.addAttribute("customer", new CustomerValidateModel());
		return "store/sign-up";
	}

	@RequestMapping(value = "/sign-up", method = RequestMethod.POST)
	public String signUp(ModelMap model, @ModelAttribute("customer") CustomerValidateModel customer,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (customer.getUsername().trim().length() == 0) {
			errors.rejectValue("username", "customer", "Vui lòng nhập tên đăng nhập!");
		} else if (customer.getUsername().trim().length() < 4) {
			errors.rejectValue("username", "customer", "Tên đăng nhập tối thiểu 4 ký tự!");
		} else if (method.isCustomerWithUsernameExit(customer.getUsername().trim())
				|| method.isAdminWithUsernameExit(customer.getUsername().trim())) {
			errors.rejectValue("username", "customer", "Tên đăng nhập đã tồn tại!");
		}
		if (customer.getFirstName().trim().length() == 0) {
			errors.rejectValue("firstName", "customer", "Vui lòng nhập họ!");
		}
		if (customer.getLastName().trim().length() == 0) {
			errors.rejectValue("lastName", "customer", "Vui lòng nhập tên!");
		}
		/*
		 * System.out.println(customer.getDateofbirth()); if (customer.getDateofbirth()
		 * == null || customer.getDateofbirth().equals("")) {
		 * errors.rejectValue("dateofbirth", "customer", "Vui lòng nhập ngày sinh!"); }
		 */
		if (customer.getTelephone().trim().length() == 0) {
			errors.rejectValue("telephone", "customer", "Vui lòng nhập số điện thoại!");
		} else if (!validatePhone(customer.getTelephone().trim())) {
			errors.rejectValue("telephone", "customer", "Số điện thoại không hợp lệ!");
		}
		if (customer.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "customer", "Vui lòng nhập email!");
		} else if (!validateEmail(customer.getEmail().trim())) {
			errors.rejectValue("email", "customer", "Email không đúng định dạng!");
		}
//		if (customer.getCity().trim().equals("0")) {
//			errors.rejectValue("city", "customer", "Vui lòng chọn Tỉnh/ Thành phố!");
//		}
//		if (customer.getDistrict().trim().equals("0")) {
//			errors.rejectValue("district", "customer", "Vui lòng chọn Quận/ Huyện!");
//		}
//		if (customer.getCommune().trim().equals("0")) {
//			errors.rejectValue("commune", "customer", "Vui lòng chọn Xã/ Phường!");
//		}
//		if (customer.getSpecificAddress().trim().length() == 0) {
//			errors.rejectValue("specificAddress", "customer", "Vui lòng nhập địa chỉ chi tiết!");
//		}
		if (customer.getFullAddress().trim().length() == 0) {
			errors.rejectValue("fullAddress", "customer", "Vui lòng nhập địa chỉ!");
		}
		if (customer.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "customer", "Vui lòng nhập mật khẩu!");
		}
		if (!customer.getPassword().trim().equals(customer.getConfirmPassword().trim())) {
			errors.rejectValue("confirmPassword", "customer", "Xác nhận mật khẩu không khớp!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			return "store/sign-up";
		} else {
			CustomerEntity ce = new CustomerEntity();
			ce.setId(method.createTheNextCustomerId().trim());
			ce.setUsername(customer.getUsername().trim());
			ce.setPassword(customer.getPassword().trim());
			ce.setFirstname(customer.getFirstName().trim());
			ce.setLastname(customer.getLastName().trim());
			ce.setPhone(customer.getTelephone().trim());
			ce.setDateAdded(new Date());
			ce.setRecoveryCode(AdminAuthController.generateRecoveryCode(5));

			// ce.setAddress(customer.getSpecificAddress().trim() + ", " +
			// customer.getDistrict().trim() + ", "
//					+ customer.getCity().trim());
			ce.setAddress(customer.getFullAddress());
			ce.setEmail(customer.getEmail().trim());
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
			if (method.insertCustomer(ce)) {
				attributes.addFlashAttribute("message", "Đăng ký thành công!");
				httpSession.setAttribute("customerUsername", ce.getUsername());
				System.out.println("Thêm thành công");
				return "redirect:/";
			} else {
				model.addAttribute("message", "Đăng ký thất bại!");
				System.out.println("Thêm thất bại");
				return "store/sign-up";
			}
		}
	}

	@RequestMapping("/category/{categoryId}")
	public String category(ModelMap model, @PathVariable("categoryId") String categoryId, HttpServletRequest request,
			HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("list", method.getListProductBycategory(categoryId));
		PagedListHolder pagedListHolder = new PagedListHolder(method.getListProductBycategory(categoryId));
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);

		model.addAttribute("listFavorite", method.getListFavourite(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "store/category-products";
	}

	@RequestMapping("/user-info")
	public String userInfo(HttpSession httpSession, ModelMap model) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("customer", new CustomerValidateModel());
		model.addAttribute("customerEntity",
				method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		return "store/user-info";
	}

	@RequestMapping(value = "/user-info", method = RequestMethod.POST)
	public String userInfo2(ModelMap model, @ModelAttribute("customer") CustomerValidateModel customer,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		/*
		 * if (customer.getUsername().trim().length() == 0) {
		 * errors.rejectValue("username", "customer", "Vui lòng nhập tên đăng nhập!"); }
		 * else if (customer.getUsername().trim().length() < 4) {
		 * errors.rejectValue("username", "customer",
		 * "Tên đăng nhập tối thiểu 4 ký tự!"); } else if
		 * (isCustomerWithUsernameExit(customer.getUsername().trim())) {
		 * errors.rejectValue("username", "customer", "Tên đăng nhập đã tồn tại!"); }
		 */
		if (customer.getFirstName().trim().length() == 0) {
			errors.rejectValue("firstName", "customer", "Vui lòng nhập họ!");
		}
		if (customer.getLastName().trim().length() == 0) {
			errors.rejectValue("lastName", "customer", "Vui lòng nhập tên!");
		}
		/*
		 * System.out.println(customer.getDateofbirth()); if (customer.getDateofbirth()
		 * == null || customer.getDateofbirth().equals("")) {
		 * errors.rejectValue("dateofbirth", "customer", "Vui lòng nhập ngày sinh!"); }
		 */
		if (customer.getTelephone().trim().length() == 0) {
			errors.rejectValue("telephone", "customer", "Vui lòng nhập số điện thoại!");
		} else if (!validatePhone(customer.getTelephone().trim())) {
			errors.rejectValue("telephone", "customer", "Số điện thoại không hợp lệ!");
		}
		if (customer.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "customer", "Vui lòng nhập email!");
		} else if (!validateEmail(customer.getEmail().trim())) {
			errors.rejectValue("email", "customer", "Email không đúng định dạng!");
		}
//		if (customer.getCity().trim().length() == 0) {
//			errors.rejectValue("city", "customer", "Vui lòng chọn tỉnh, thành phố!");
//		}
//		if (customer.getDistrict().trim().length() == 0) {
//			errors.rejectValue("district", "customer", "Vui lòng chọn quận huyện!");
//		}
//		if (customer.getSpecificAddress().trim().length() == 0) {
//			errors.rejectValue("specificAddress", "customer", "Vui lòng nhập địa chỉ chi tiết!");
//		}
//		if (customer.getPassword().trim().length() == 0) {
//			errors.rejectValue("password", "customer", "Vui lòng nhập mật khẩu!");
//		}
//		if (!customer.getPassword().trim().equals(customer.getConfirmPassword().trim())) {
//			errors.rejectValue("confirmPassword", "customer", "Xác nhận mật khẩu không khớp!");
//		}
		if (customer.getFullAddress().trim().length() == 0) {
			errors.rejectValue("fullAddress", "customer", "Vui lòng nhập địa chỉ!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
//			attributes.addFlashAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			model.addAttribute("customerEntity",
					method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
			return "store/user-info";
		} else {
			CustomerEntity ce = new CustomerEntity();
			ce.setFirstname(customer.getFirstName().trim());
			ce.setLastname(customer.getLastName().trim());
			ce.setPhone(customer.getTelephone().trim());
//			ce.setAddress(customer.getSpecificAddress().trim() + ", " + customer.getDistrict().trim() + ", "
//					+ customer.getCity().trim());
			ce.setAddress(customer.getFullAddress());

			ce.setEmail(customer.getEmail().trim());
			System.out.println("still ok");
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
			if (method.updateCustomerDetail(ce, httpSession)) {
				System.out.println("Cập nhật thành công");
				model.addAttribute("message", "Cập nhật thông tin thành công!");
				return "store/user-info";
			} else {
				model.addAttribute("message", "Cập nhật thông tin thất bại!");
			}
		}
		return "store/user-info";
	}

	@RequestMapping(value = "/user-info/change-password")
	public String changePassword(HttpSession httpSession, ModelMap model) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("customer", new ChangePasswordModel());
		model.addAttribute("customerEntity",
				method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		return "store/user-change-password";
	}

	@RequestMapping(value = "/user-info/order-history")
	public String orderHistory(HttpSession httpSession, ModelMap model) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("listOrder", method.getCustomerOrder(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		model.addAttribute("customerEntity",
				method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		return "store/order-history";
	}

	@RequestMapping(value = "/user-info/change-password", method = RequestMethod.POST)
	public String changePassword2(ModelMap model, @ModelAttribute("customer") ChangePasswordModel customer,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (customer.getOldPassword().trim().length() == 0) {
			errors.rejectValue("oldPassword", "customer", "Vui lòng nhập mật khẩu cũ!");
		} else if (!customer.getOldPassword().trim().equals(method
				.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getPassword().trim())) {
			errors.rejectValue("oldPassword", "customer", "Mật khẩu cũ không đúng!");
		}
		if (customer.getNewPassword().trim().length() == 0) {
			errors.rejectValue("newPassword", "customer", "Vui lòng nhập mật khẩu mới!");
		} else if (customer.getOldPassword().trim().equals(customer.getNewPassword().trim())) {
			errors.rejectValue("newPassword", "customer", "Mật khẩu mới không được trùng với mật khẩu cũ!");
		}
		if (!customer.getConfirmNewPassword().trim().equals(customer.getNewPassword().trim())
				|| customer.getConfirmNewPassword().trim().length() == 0) {
			errors.rejectValue("confirmNewPassword", "customer", "Xác nhận mật khẩu không khớp!");
		}

		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			model.addAttribute("customerEntity",
					method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
//			attributes.addFlashAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			return "store/user-change-password";
		} else {
			CustomerEntity ce = new CustomerEntity();
			ce.setPassword(customer.getConfirmNewPassword());
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
			if (method.updateCustomerPassword(ce, httpSession)) {
				System.out.println("Cập nhật mật khẩu thành công");
				attributes.addFlashAttribute("message", "Cập nhật mật khẩu thành công!");
			} else {
				attributes.addFlashAttribute("message", "Cập nhật mật khẩu thất bại!");
			}
		}
		return "redirect:/store/user-info";
	}

	@RequestMapping(value = "/shopping-cart/check-out")
	public String checkOut(HttpSession httpSession, ModelMap model, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		List<CartDetailEntity> listCart = method.getListCartDetail(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		if (listCart.size() == 0) {
			attributes.addFlashAttribute("message", "Không có sản phẩm nào trong giỏ hàng!");
			return "redirect:/store/shopping-cart";
		}
		for (CartDetailEntity c : listCart) {
			if (c.getQuantity() > c.getProduct().getQuantity()) {
				attributes.addFlashAttribute("message",
						"Vui lòng cập nhật số lượng hợp lệ và nhấn Thanh toán lần nữa");
				return "redirect:/store/shopping-cart";
			}
		}
		if (httpSession.getAttribute("customerUsername") != null) {
			int sum = 0;
			for (CartDetailEntity c : method
					.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
		}
		model.addAttribute("order", new OrderModel());
		model.addAttribute("customerEntity",
				method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		List<CartDetailEntity> cartDetails = method.getListCartDetail(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		model.addAttribute("cartDetails", cartDetails);
		float total = 0;
		for (CartDetailEntity c : cartDetails) {
			total = total + c.getQuantity() * c.getProduct().getPrice();
		}
//		System.out.println(total);
		model.addAttribute("cartDetailsTotal", total);
		return "store/check-out";
	}

	@RequestMapping(value = "/shopping-cart/check-out", method = RequestMethod.POST)
	public String checkOut2(HttpSession httpSession, ModelMap model, @ModelAttribute("order") OrderModel order,
			BindingResult errors, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		if (order.getShipName().trim().length() == 0) {
			errors.rejectValue("shipName", "order", "Vui lòng nhập họ!");
		}
		if (order.getShipPhone().trim().length() == 0) {
			errors.rejectValue("shipPhone", "order", "Vui lòng nhập số điện thoại!");
		} else if (!validatePhone(order.getShipPhone().trim())) {
			errors.rejectValue("shipPhone", "order", "Số điện thoại không hợp lệ!");
		}
		if (order.getShipEmail().trim().length() == 0) {
			errors.rejectValue("shipEmail", "order", "Vui lòng nhập email!");
		} else if (!validateEmail(order.getShipEmail().trim())) {
			errors.rejectValue("shipEmail", "order", "Email không đúng định dạng!");
		}
		if (order.getShipAddress().trim().length() == 0) {
			errors.rejectValue("shipAddress", "order", "Vui lòng nhập địa chỉ chi tiết!");
		}

		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
//			attributes.addFlashAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			List<CartDetailEntity> cartDetails = method.getListCartDetail(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
			model.addAttribute("cartDetails", cartDetails);
			float total = 0;
			for (CartDetailEntity c : cartDetails) {
				total = total + c.getQuantity() * c.getProduct().getPrice();
			}
			model.addAttribute("cartDetailsTotal", total);
			return "store/check-out";
		} else {
			OrderEntity oe = new OrderEntity();
			oe.setCustomerId(method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
			oe.setId(method.createTheNextOrderId());
			oe.setOrderDate(new Date());
			List<CartDetailEntity> cartDetails = method.getListCartDetail(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
			float total = 0;
			for (CartDetailEntity c : cartDetails) {
				total = total + c.getQuantity() * c.getProduct().getPrice();
			}
			// oe.setOrderTotal(total);
			oe.setShipAddress(order.getShipAddress());
			oe.setShipName(order.getShipName());
			oe.setShipPhone(order.getShipPhone());
			oe.setShipNote(order.getShipNote());
			oe.setState(0);
//			/
//			add new properties for order later
			if (method.checkOutHibernate(oe, method.getListCartDetail(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))))) {
				attributes.addFlashAttribute("message", "Đặt hàng thành công!");
				String body = "<h3  style='margin: 8px 0;'>Thông tin người nhận</h3><p  style='margin: 4px 0;'>Tên: "
						+ order.getShipName() + "</p><p style='margin: 4px 0;'>SĐT: " + order.getShipPhone()
						+ "</p><p  style='margin: 4px 0;'>Địa chỉ: " + order.getShipAddress() + "</p>";
				body = body + "<h3  style='margin: 8px 0;'>Thông tin đơn hàng</h3>"
						+ "<table style='width: 400px;border: 1px solid black;"
						+ "  border-collapse: collapse;'> <thead>" + "						<tr>"
						+ "							<th style='border: 1px solid black;border-collapse: collapse; padding: 0 4px;'>Sản phẩm</th>"
						+ "							<th style='border: 1px solid black;border-collapse: collapse; padding: 0 4px;'>Số lượng</th>"
						+ "							<th style='border: 1px solid black;border-collapse: collapse; padding: 0 4px;'>Tổng</th>"
						+ "						</tr>" + "					</thead>";
				for (CartDetailEntity cde : cartDetails) {
					body = body + "<tr>"
							+ "<td style='border: 1px solid black;border-collapse: collapse;padding-left:4px;'><p style='margin: 4px 0 0 0;'>"
							+ cde.getProduct().getName() + "</p>" + "<p style='margin: 0 0 4px 0;'>"
							+ cde.getProduct().getPrice() + " đ</p></td>"
							+ "<td style='text-align: center;border: 1px solid black;border-collapse: collapse;'>"
							+ cde.getQuantity() + "</td>"
							+ "<td style='text-align: center;border: 1px solid black;border-collapse: collapse;'>"
							+ (cde.getQuantity() * cde.getProduct().getPrice()) + " đ</td>" + "</tr>";
				}
				body = body
						+ "<tr><td colspan='3' style='text-align: right;border: 1px solid black;border-collapse: collapse;'>"
						+ total + " đ</td></tr></table>";
				try {
					mailer.send("storespring21@gmail.com", order.getShipEmail().trim(),
							"Thông báo hệ thống đã xác nhận đơn hàng của quý khách.", body);
					System.out.println("Gửi email thành công!");
				} catch (Exception ex) {
					System.out.println("Gửi email thất bại!");
				}
				return "redirect:/";
			} else {
				model.addAttribute("message", "Đặt hàng thất bại!");
				model.addAttribute("cartDetails", cartDetails);
				model.addAttribute("cartDetailsTotal", total);
				return "store/check-out";
			}
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
		}
	}

	@RequestMapping("/all")
	public String allProduct(ModelMap model, HttpServletRequest request, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		PagedListHolder pagedListHolder = new PagedListHolder(method.getAllProducts());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);

		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("listFavorite", method.getListFavourite(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		return "store/all-products";
	}

	@RequestMapping("/shopping-cart")
	public String shoppingCart(ModelMap model, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("listCartDetail", method.getListCartDetail(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));

		if ((httpSession.getAttribute("customerUsername") != null)) {
			int sum = 0;
			for (CartDetailEntity c : method
					.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
			model.addAttribute("listFavorite", method.getListFavourite(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		}

		return "store/shopping-cart";
	}

	@RequestMapping(value = "/shopping-cart/delete/{productId}", method = RequestMethod.GET)
	public String delete(@PathVariable("productId") String productId, HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		System.out.println(productId);
		if (method.deleteProductFromCartDetail(productId, httpSession)) {
			System.out.println("Delete successful");
		} else {
			System.out.println("Delete unsuccessful");
		}
		return "redirect:/store/shopping-cart";
	}

	@RequestMapping(value = "/shopping-cart/update", method = RequestMethod.POST)
	public String update(HttpServletRequest request, ModelMap model, HttpSession httpSession,
			RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		List<CartDetailEntity> listCart = method.getListCartDetail(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
		if (listCart.size() == 0) {
			attributes.addFlashAttribute("message", "Không có sản phẩm nào trong giỏ hàng!");
			return "redirect:/store/shopping-cart";
		}
		httpSession.setAttribute("listCategory", method.getListCategory());
		String[] product_ids = request.getParameterValues("product_id");
		String[] quantities = request.getParameterValues("quantity");
		for (int i = 0; i < product_ids.length; i++) {
			method.updateProductQuantityFromCartDetail(product_ids[i], quantities[i], httpSession);
		}
		attributes.addFlashAttribute("message", "Cập nhật số lượng thành công.");
		return "redirect:/store/shopping-cart";
	}

	public String returnRedirectControl(String redirectPath) {

		if (redirectPath.equals("index")) {
			return "redirect:/";
		}
		if (redirectPath.equals("user-fav")) {
			return "redirect:/store/user-info/favorite";
		}
		if (redirectPath.equals("user-cart")) {
			return "redirect:/store/shopping-cart";
		}
		if (redirectPath.contains("allseperator")) {
			String newPath = redirectPath.replaceAll("seperator", "/");
			newPath = newPath.replaceAll("questionmark", "?");
			return "redirect:/store/" + newPath;
		}
		if (redirectPath.contains("categoryseperator")) {
			String newPath = redirectPath.replaceAll("seperator", "/");
			newPath = newPath.replaceAll("questionmark", "?");
			return "redirect:/store/" + newPath;
		}
		if (redirectPath.contains("searchseperator")) {
			String newPath = redirectPath.replaceAll("seperator", "/");
			newPath = newPath.replaceAll("questionmark", "?");
			return "redirect:/store/" + newPath;
		}
		if (redirectPath.contains("product-detailseperator")) {
			String newPath = redirectPath.replaceAll("seperator", "/");
			return "redirect:/store/" + newPath;
		}
		return "redirect:/";
	}

	@RequestMapping("/shopping-cart/insert-into-cart/{productId}/{redirectPath}")
	public String insertToCart(String customerId, @PathVariable("productId") String productId,
			@PathVariable("redirectPath") String redirectPath, HttpSession httpSession, RedirectAttributes attributes,
			ModelMap model) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		CartDetailEntity cde = new CartDetailEntity(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")), (productId));
		if (method.isProductOutOfStock(productId)) {
			attributes.addFlashAttribute("message", "Sản phẩm hiện hết hàng");
//			return "redirect:/store/shopping-cart";
			return returnRedirectControl(redirectPath);
		}
		if (method.cartItemIsExit(productId, httpSession)) {
			System.out.println("Exist; increase quantity by 1!");
			if (!method.isCartItemMaximumAmountOfProduct(productId, httpSession)) { // nếu số lượng tồn của sản phẩm k
																					// bằng số
				// sản phẩm của
				// product đó trong cart

				if (method.updateProductQuantityFromCartDetail(productId,
						String.valueOf(method.getQuantityOfCartItem(productId, httpSession) + 1), httpSession)) {
					System.out.println("Exit; increase quantity by 1 successful!");
					attributes.addFlashAttribute("message", "Thêm thành công");
					if ((httpSession.getAttribute("customerUsername") != null)) {
						int sum = 0;
						for (CartDetailEntity c : method
								.getCustomerByUsername((String) httpSession.getAttribute("customerUsername"))
								.getCartDetails()) {
							sum = sum + c.getQuantity();
						}
						System.out.println(sum);
						httpSession.setAttribute("customerTotalQuantity", sum);
						model.addAttribute("listFavorite", method.getListFavourite(
								method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
					}
					return returnRedirectControl(redirectPath);
				} else {
					System.out.println("Exit; increase quantity by 1 unsuccessful!");
					return returnRedirectControl(redirectPath);
				}

			} else {
				System.out.println(
						"Exit; increase quantity by 1 unsuccessful \n because amount of that product incart is equal to its amount in product!");
				attributes.addFlashAttribute("message",
						"Số lượng của sản phẩm này trong giỏ đã bằng tồn kho");
				return returnRedirectControl(redirectPath);
			}

		} else {
			cde.setQuantity(1);
			try {
				session.save(cde);
				t.commit();
				System.out.println("Insert successful!");

			} catch (Exception ex) {
				t.rollback();
				System.out.println("Insert unsuccessful!");
			} finally {
				session.close();
			}
		}
		if ((httpSession.getAttribute("customerUsername") != null)) {
			int sum = 0;
			for (CartDetailEntity c : method
					.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
			model.addAttribute("listFavorite", method.getListFavourite(
					method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		}
		attributes.addFlashAttribute("message", "Thêm vào giỏ thành công");
		return returnRedirectControl(redirectPath);
//		return "redirect:/store/shopping-cart";
	}

	/*
	 * @RequestMapping(value = "/search", method = RequestMethod.GET) public String
	 * search2() {
	 * 
	 * return "store/search-result"; }
	 */
	@RequestMapping(value = "/search")
	public String search2() {
		return "redirect:/";
	}

	@RequestMapping(value = "/search/{keyword}")
	public String search(HttpServletRequest request, ModelMap model, @PathVariable("keyword") String keyword,
			HttpSession httpSession) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("keyword", keyword);
		System.out.println(keyword);
		PagedListHolder pagedListHolder = new PagedListHolder(method.searchForProduct(keyword));
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);

		if (httpSession.getAttribute("listRecentSearch") != null) {
			List<String> lrs = (List<String>) httpSession.getAttribute("listRecentSearch");
			boolean existed = false;
			for (String keyw : lrs) {
				if (keyw.equals(keyword)) {
					existed = true;
				}
			}
			if (!existed) {
				lrs.add(0, keyword);
			}
			httpSession.setAttribute("listRecentSearch", lrs);
		} else {
			List<String> lrs = new ArrayList<String>();
			lrs.add(0, keyword);

			httpSession.setAttribute("listRecentSearch", lrs);
		}
		model.addAttribute("listFavorite", method.getListFavourite(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "store/search-result";
	}

	@RequestMapping("/user-info/favorite")
	public String favoritePage(HttpSession httpSession, ModelMap model) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		model.addAttribute("listFavorite", method.getListFavourite(
				method.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		model.addAttribute("customerEntity",
				method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		return "store/user-favorite";
	}

	@RequestMapping("/insert-to-favlist/{productId}/{redirectPath}")
	public String insertToFavouriteList(String customerId, @PathVariable("productId") String productId,
			@PathVariable("redirectPath") String redirectPath, HttpSession httpSession, RedirectAttributes attributes) {
		Methods method = new Methods(factory);
		httpSession.setAttribute("listCategory", method.getListCategory());
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		FavoriteProductEntity fp = new FavoriteProductEntity();
		if (method.favItemIsExit(productId, httpSession)) {
			if (method.deleteProductFromFavourite(productId, httpSession)) {
				attributes.addFlashAttribute("message", "Đã xóa khỏi danh sách yêu thích");
				System.out.println("remove from fav list successful!-------------");
			}
		} else {
			fp.setCustomer(method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
			fp.setProduct(method.getProduct(productId));
			try {
				session.save(fp);
				t.commit();
				System.out.println("Insert to fav list successful!-------------");
				attributes.addFlashAttribute("message", "Đã thêm vào danh sách yêu thích");

			} catch (Exception ex) {
				t.rollback();
				System.out.println("--------Insert to fav list unsuccessful!");
			} finally {
				session.close();
			}
		}
		return returnRedirectControl(redirectPath);
//			return "redirect:/store/user-info/favorite";
	}

	public static final Pattern VALID_EMAIL_ADDRESS_REGEX = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
			Pattern.CASE_INSENSITIVE);

	public static boolean validateEmail(String emailStr) {
		Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(emailStr);
		return matcher.find();
	}

	public static final Pattern VALID_VI_PHONE_NUMBER_REGEX = Pattern.compile("^0{1}[0-9]{9}$",
			Pattern.CASE_INSENSITIVE);

	public static boolean validatePhone(String phoneNumber) {
		Matcher matcher = VALID_VI_PHONE_NUMBER_REGEX.matcher(phoneNumber);
		return matcher.find();
	}
//	public boolean updateCustomerDetail(CustomerEntity customer, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "UPDATE CustomerEntity c SET c.firstname=:firstname, c.lastname=:lastname,"
//				+ "c.phone=:phone, c.address=:address, c.email=:email   WHERE c.id=:id";
//		Query query = session.createQuery(hql).setParameter("id",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("firstname", customer.getFirstname());
//		query.setParameter("lastname", customer.getLastname());
//		query.setParameter("phone", customer.getPhone());
//		query.setParameter("address", customer.getAddress());
//		query.setParameter("email", customer.getEmail());
//		return query.executeUpdate() > 0;
//	}
//
//	public boolean updateCustomerPassword(CustomerEntity customer, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "UPDATE CustomerEntity c SET c.password=:password WHERE c.id=:id";
//		Query query = session.createQuery(hql).setParameter("id",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("password", customer.getPassword());
//		return query.executeUpdate() > 0;
//	}
//
//	public boolean updateProductQuantityFromCartDetail(String productId, String quantity, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "UPDATE CartDetailEntity c SET c.quantity=:quantity WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
//		Query query = session.createQuery(hql).setParameter("customerId",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("productId", productId);
//		query.setParameter("quantity", Integer.parseInt(quantity));
//		return query.executeUpdate() > 0;
//	}
//
//	public boolean updateProductQuantity(String productId, int quantity) {
//		Session session = factory.getCurrentSession();
//		String hql = "UPDATE ProductEntity p SET p.quantity=:quantity WHERE p.id=:productId";
//		Query query = session.createQuery(hql);
//		query.setParameter("productId", productId);
//		query.setParameter("quantity", quantity);
//		return query.executeUpdate() > 0;
//	}
//
//	public boolean deleteProductFromCartDetail(String productId, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "DELETE FROM CartDetailEntity c WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
//		Query query = session.createQuery(hql).setParameter("customerId",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("productId", productId);
//
//		return query.executeUpdate() > 0;
//	}
//
//	public List<CartDetailEntity> getListCartDetail(String customerId) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM CartDetailEntity c WHERE c.customer.id =:customerId";
//		Query query = session.createQuery(hql);
//
//		List<CartDetailEntity> list = query.setParameter("customerId", customerId).list();
//		return list;
//	}
//
//	public String getCustomerIdByUserName(String userName) {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT id FROM CustomerEntity c WHERE c.username =:userName";
//		Query query = session.createQuery(hql);
//		String customerId = (String) query.setParameter("userName", userName).uniqueResult();
//		return customerId;
//	}
//
//	public CustomerEntity getCustomerByUsername(String userName) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM CustomerEntity c WHERE c.username =:userName";
//		Query query = session.createQuery(hql);
//		CustomerEntity customer = (CustomerEntity) query.setParameter("userName", userName).uniqueResult();
//		return customer;
//	}
//
//	public List<ProductEntity> getListProduct() {
//		/* System.out.println("getListCartDetail"); */
//		Session session = factory.getCurrentSession();
//		String hql = "FROM ProductEntity";
//		Query query = session.createQuery(hql);
//		List<ProductEntity> list = query.list();
//		return list;
//	}
//
//	public boolean checkOutHibernate(OrderEntity order, List<CartDetailEntity> listCartDetail) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		List<ProductEntity> listProduct = this.getListProduct();
//
//		List<ProductEntity> listProductToBeUpdate = new ArrayList<ProductEntity>();
//
//		for (ProductEntity pe : listProduct) {
//			for (CartDetailEntity cde : listCartDetail) {
//				if (cde.getProduct().getId().trim().equals(pe.getId())) {
////					System.out.println(pe.getQuantity() +"old quan: "+ pe.getName());
//					pe.setQuantity(pe.getQuantity() - cde.getQuantity());// new quantity after update
////					System.out.println(pe.getQuantity() +"new quan: "+ pe.getName());
//					listProductToBeUpdate.add(pe);
//				}
//			}
//		}
//		List<OrderDetailEntity> listODE = new ArrayList<OrderDetailEntity>();
//		for (CartDetailEntity cartDetailEntity : listCartDetail) {
//			OrderDetailEntity ode = new OrderDetailEntity(order.getId(), cartDetailEntity.getProduct().getId());
//			ode.setQuantity(cartDetailEntity.getQuantity());
//			listODE.add(ode);
//		}
//		boolean updateFlag = false;
//		try {
//			session.save(order);
//			for (CartDetailEntity cartDetailEntity : listCartDetail) {
//				session.delete(cartDetailEntity);
//			}
//			for (OrderDetailEntity ode : listODE) {
//				session.save(ode);
//			}
//
//			t.commit();
//		} catch (Exception ex) {
//			t.rollback();
//			return false;
//		} finally {
//			session.close();
//			updateFlag = true;
//		}
//		if (updateFlag == true) {
//			for (ProductEntity p : listProductToBeUpdate) {
//				if (!updateProductQuantity(p.getId(), p.getQuantity())) {
//					return false;
//				}
//			}
//		}
//		return true;
//	}
//
//	public boolean cartItemIsExit(String product_id, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT c.id.product_id FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
//		Query query = session.createQuery(hql);
//		query.setParameter("customerId",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("productId", product_id);
//		String productId = (String) query.uniqueResult();
//		return product_id.equals(productId);
//	}
//
//	public int getQuantityOfCartItem(String product_id, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
//		Query query = session.createQuery(hql);
//		query.setParameter("customerId",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("productId", product_id);
//		int quantity = (int) query.uniqueResult();
//		return quantity;
//	}
//
//	public boolean isProductOutOfStock(String product_id) {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT p.quantity FROM ProductEntity p WHERE p.id =:productId";
//		Query query = session.createQuery(hql);
//		int product = (int) query.setParameter("productId", product_id).uniqueResult();
//		return product <= 0;
//	}
//
//	public boolean isCartItemMaximumAmountOfProduct(String product_id, HttpSession httpSession) {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
//		Query query = session.createQuery(hql);
//		query.setParameter("customerId",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("productId", product_id);
//		int quantityOfCart = (int) query.uniqueResult();
//		System.out.println("quantity from cart: " + quantityOfCart);
//		hql = "SELECT c.product.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
//		query = session.createQuery(hql);
//		query.setParameter("customerId",
//				this.getCustomerIdByUserName((String) httpSession.getAttribute("customerUsername")));
//		query.setParameter("productId", product_id);
//		int quantityOfProduct = (int) query.uniqueResult();
//		System.out.println("quantity from product: " + quantityOfProduct);
//		return quantityOfCart >= quantityOfProduct;
//	}
//
//	public ProductEntity getProduct(String productId) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM ProductEntity p WHERE p.id =:productId";
//		Query query = session.createQuery(hql);
//
//		ProductEntity product = (ProductEntity) query.setParameter("productId", productId).uniqueResult();
//		return product;
//	}
//
//	public List<ProductEntity> getListProductBycategory(String categoryId) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM ProductEntity p WHERE p.category.id=:categoryId";
//		Query query = session.createQuery(hql);
//
//		List<ProductEntity> list = query.setParameter("categoryId", categoryId).list();
//		return list;
//	}
//
//	public boolean insertCustomer(CustomerEntity customer) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		try {
//			session.save(customer);
//			t.commit();
//			System.out.println("Insert successful!");
//
//		} catch (Exception ex) {
//			ex.printStackTrace();
//			t.rollback();
//			System.out.println("Insert unsuccessful!");
//			return false;
//		} finally {
//			session.close();
//		}
//		return true;
//	}
//
//	public boolean isCustomerWithUsernameExit(String username) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM CustomerEntity c WHERE c.username=:username";
//		Query query = session.createQuery(hql);
//
//		CustomerEntity customer = (CustomerEntity) query.setParameter("username", username).uniqueResult();
//		return customer != null;
//	}
//
//	public String getPasswordOfCustomerWithUsername(String username) {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT c.password FROM CustomerEntity c WHERE c.username=:username";
//		Query query = session.createQuery(hql);
//		String password = (String) query.setParameter("username", username).uniqueResult();
//		return password;
//	}

//	public String createTheNextCustomerId() {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT c.id FROM CustomerEntity c WHERE c.id=(SELECT MAX(cc.id) FROM CustomerEntity cc)";
//		Query query = session.createQuery(hql);
//
//		String id = (String) query.uniqueResult();
//		if (id == null || id.equals("")) {
//			return "U0001";
//		}
//		int x = Integer.parseInt(id.substring(1)) + 1;
//		String base = "U0000";
//		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
//		String newId = base2 + String.valueOf(x);
//		return newId;
//	}
//
//	public String createTheNextOrderId() {
//		Session session = factory.getCurrentSession();
//		String hql = "SELECT o.id FROM OrderEntity o WHERE o.id=(SELECT MAX(oo.id) FROM OrderEntity oo)";
//		Query query = session.createQuery(hql);
//
//		String id = (String) query.uniqueResult();
//		if (id == null || id.equals("")) {
//			return "O000000001";
//		}
//		int x = Integer.parseInt(id.substring(1)) + 1;
//		String base = "O000000000";
//		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
//		String newId = base2 + String.valueOf(x);
//		return newId;
//	}
//
//	public List<CategoryEntity> getListCategory() {
//		/* System.out.println("getListCartDetail"); */
//		Session session = factory.getCurrentSession();
//		String hql = "FROM CategoryEntity";
//		Query query = session.createQuery(hql);
//		List<CategoryEntity> list = query.list();
//		return list;
//	}
//
//	public List<ProductEntity> getTop16RecentProduct() {
//		/* System.out.println("getListCartDetail"); */
//		Session session = factory.getCurrentSession();
//		String hql = "FROM ProductEntity p ORDER BY p.dateAdded DESC";
//		Query query = session.createQuery(hql);
//		List<ProductEntity> list = query.setMaxResults(16).list();
//		return list;
//	}
//
//	public List<OrderEntity> getCustomerOrder(String customerId) {
//		/* System.out.println("getListCartDetail"); */
//		Session session = factory.getCurrentSession();
//		String hql = "FROM OrderEntity o WHERE o.customerId=:customerId ORDER BY o.orderDate DESC";
//		Query query = session.createQuery(hql).setParameter("customerId", customerId);
//		List<OrderEntity> list = query.list();
//		return list;
//	}
//
//	public List<ProductEntity> getAllProducts() {
//		/* System.out.println("getListCartDetail"); */
//		Session session = factory.getCurrentSession();
//		String hql = "FROM ProductEntity p ORDER BY p.dateAdded DESC";
//		Query query = session.createQuery(hql);
//		List<ProductEntity> list = query.list();
//		return list;
//	}
//
//	public List<ProductEntity> searchForProduct(String keyword) {
//		/* System.out.println("getListCartDetail"); */
//		Session session = factory.getCurrentSession();
//		String hql = "FROM ProductEntity p WHERE p.name LIKE :keyword OR p.category.name LIKE:keyword ORDER BY p.dateAdded DESC";
//		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
//		List<ProductEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
//		return list;
//	}
	// Theem vaof danh sach yeu thich
//	@RequestMapping("/insert-to-favlist/{productId}")
//	public String insertToFavouriteList(String customerId, @PathVariable("productId") String productId, HttpSession httpSession,
//			RedirectAttributes attributes) {
//		Methods method = new Methods(factory);
//		httpSession.setAttribute("listCategory", method.getListCategory());
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		FavoriteProductEntity fp = new FavoriteProductEntity();
//		if (method.favItemIsExit(productId, httpSession)) {
//			if(method.deleteProductFromFavourite(productId, httpSession)) {
//				attributes.addFlashAttribute("message", "Đã xóa khỏi danh sách yêu thích");
//				System.out.println("remove from fav list successful!-------------");
//			}
//		} else {
//			fp.setCustomer(method.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
//			fp.setProduct(method.getProduct(productId));
//			try {
//				session.save(fp);
//				t.commit();
//				System.out.println("Insert to fav list successful!-------------");
//				attributes.addFlashAttribute("message", "Đã thêm vào danh sách yêu thích");
//
//			} catch (Exception ex) {
//				t.rollback();
//				System.out.println("--------Insert to fav list unsuccessful!");
//			} finally {
//				session.close();
//			}
//		}
//
//		return "redirect:/store/user-info/favorite";
//	}

}
