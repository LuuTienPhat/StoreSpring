package controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entities.CartDetailEntity;
import entities.CategoryEntity;
import entities.CustomerEntity;
import entities.OrderDetailEntity;
import entities.OrderEntity;
import entities.ProductEntity;
import models.ChangePasswordModel;
import models.CustomerLoginAccountModel;
import models.CustomerValidateModel;
import models.OrderModel;

@Transactional
@Controller
@RequestMapping("/store")
public class GiftController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("")
	public String store(ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("list", this.getListProduct());
		int sum = 0;
		for (CartDetailEntity c : this.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
			sum = sum + c.getQuantity();
		}
		System.out.println(sum);
		httpSession.setAttribute("customerTotalQuantity", sum);
		return "store/index";
	}

	@RequestMapping("/")
	public String store2(ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		int sum = 0;
		for (CartDetailEntity c : this.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")).getCartDetails()) {
			sum = sum + c.getQuantity();
		}
		System.out.println(sum);
		httpSession.setAttribute("customerTotalQuantity", sum);
		model.addAttribute("list", this.getListProduct());
		return "store/index";
	}

	@RequestMapping("/product-detail/{productId}")
	public String productDetail2(@PathVariable("productId") String productId, ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("product", this.getProduct(productId));
		System.out.println(productId + "; " + this.getProduct(productId).getName());
		return "store/product-detail";
	}

	@RequestMapping(value = "/sign-in")
	public String signIn(ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("account", new CustomerLoginAccountModel());
		return "store/sign-in";
	}

	@RequestMapping(value = "/log-out")
	public String logOut(ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		httpSession.removeAttribute("customerUsername");
		return "redirect:/";
	}

	@RequestMapping(value = "/sign-in", method = RequestMethod.POST)
	public String signIn(@ModelAttribute("account") CustomerLoginAccountModel account, ModelMap model,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		if (!isCustomerWithUsernameExit(account.getUsername())) {
			errors.rejectValue("username", "account", "Tên đăng nhập không tồn tại!");
		} else if (!account.getPassword().equals(getPasswordOfCustomerWithUsername(account.getUsername()))) {
			errors.rejectValue("password", "account", "Mật khẩu không đúng!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Thông tin đăng nhập sai!");

			return "store/sign-in";
		} else {
			httpSession.setAttribute("customerUsername", account.getUsername());
			int sum = 0;
			for (CartDetailEntity c : this.getCustomerByUsername(account.getUsername()).getCartDetails()) {
				sum = sum + c.getQuantity();
			}
			System.out.println(sum);
			httpSession.setAttribute("customerTotalQuantity", sum);
			attributes.addFlashAttribute("message", "Đăng nhập thành công!");
			return "redirect:/";
		}
	}

	@RequestMapping("/sign-up")
	public String signUp(ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		System.out.println(this.createTheNextCustomerId());
		model.addAttribute("customer", new CustomerValidateModel());
		return "store/sign-up";
	}

	@RequestMapping(value = "/sign-up", method = RequestMethod.POST)
	public String signUp(ModelMap model, @ModelAttribute("customer") CustomerValidateModel customer,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		if (customer.getUsername().trim().length() == 0) {
			errors.rejectValue("username", "customer", "Vui lòng nhập tên đăng nhập!");
		} else if (customer.getUsername().trim().length() < 4) {
			errors.rejectValue("username", "customer", "Tên đăng nhập tối thiểu 4 ký tự!");
		} else if (isCustomerWithUsernameExit(customer.getUsername().trim())) {
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
		if (customer.getCity().trim().length() == 0) {
			errors.rejectValue("city", "customer", "Vui lòng chọn tỉnh, thành phố!");
		}
		if (customer.getDistrict().trim().length() == 0) {
			errors.rejectValue("district", "customer", "Vui lòng chọn quận huyện!");
		}
		if (customer.getSpecificAddress().trim().length() == 0) {
			errors.rejectValue("specificAddress", "customer", "Vui lòng nhập địa chỉ chi tiết!");
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
			ce.setId(createTheNextCustomerId().trim());
			ce.setUsername(customer.getUsername().trim());
			ce.setPassword(customer.getPassword().trim());
			ce.setFirstname(customer.getFirstName().trim());
			ce.setLastname(customer.getLastName().trim());
			ce.setPhone(customer.getTelephone().trim());
			ce.setAddress(customer.getSpecificAddress().trim() + ", " + customer.getDistrict().trim() + ", "
					+ customer.getCity().trim());
			ce.setEmail(customer.getEmail().trim());
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
			if (insertCustomer(ce)) {
				attributes.addFlashAttribute("message", "Đăng ký thành công!");
				httpSession.setAttribute("customerUsername", ce.getId());
				System.out.println("Thêm thành công");
				return "redirect:/store";
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
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("list", getListProductBycategory(categoryId));
		PagedListHolder pagedListHolder = new PagedListHolder(getListProductBycategory(categoryId));
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);

		model.addAttribute("pagedListHolder", pagedListHolder);

		return "store/category-products";
	}

	@RequestMapping("/user-info")
	public String userInfo(HttpSession httpSession, ModelMap model) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("customer", new CustomerValidateModel());
		model.addAttribute("customerEntity",
				this.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		return "store/user-info";
	}

	@RequestMapping(value = "/user-info", method = RequestMethod.POST)
	public String userInfo2(ModelMap model, @ModelAttribute("customer") CustomerValidateModel customer,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		httpSession.setAttribute("listCategory", this.getListCategory());
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
		if (customer.getCity().trim().length() == 0) {
			errors.rejectValue("city", "customer", "Vui lòng chọn tỉnh, thành phố!");
		}
		if (customer.getDistrict().trim().length() == 0) {
			errors.rejectValue("district", "customer", "Vui lòng chọn quận huyện!");
		}
		if (customer.getSpecificAddress().trim().length() == 0) {
			errors.rejectValue("specificAddress", "customer", "Vui lòng nhập địa chỉ chi tiết!");
		}
//		if (customer.getPassword().trim().length() == 0) {
//			errors.rejectValue("password", "customer", "Vui lòng nhập mật khẩu!");
//		}
//		if (!customer.getPassword().trim().equals(customer.getConfirmPassword().trim())) {
//			errors.rejectValue("confirmPassword", "customer", "Xác nhận mật khẩu không khớp!");
//		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
//			attributes.addFlashAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			return "store/user-info";
		} else {
			CustomerEntity ce = new CustomerEntity();
			ce.setFirstname(customer.getFirstName().trim());
			ce.setLastname(customer.getLastName().trim());
			ce.setPhone(customer.getTelephone().trim());
			ce.setAddress(customer.getSpecificAddress().trim() + ", " + customer.getDistrict().trim() + ", "
					+ customer.getCity().trim());
			ce.setEmail(customer.getEmail().trim());
			System.out.println("still ok");
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
			if (this.updateCustomerDetail(ce, httpSession)) {
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
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("customer", new ChangePasswordModel());
		model.addAttribute("customerEntity",
				this.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		return "store/user-change-password";
	}

	@RequestMapping(value = "/user-info/change-password", method = RequestMethod.POST)
	public String changePassword2(ModelMap model, @ModelAttribute("customer") ChangePasswordModel customer,
			BindingResult errors, HttpSession httpSession, RedirectAttributes attributes) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		if (customer.getOldPassword().trim().length() == 0) {
			errors.rejectValue("oldPassword", "customer", "Vui lòng nhập mật khẩu cũ!");
		} else if (!customer.getOldPassword().trim().equals(this
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
//			attributes.addFlashAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			return "store/user-change-password";
		} else {
			CustomerEntity ce = new CustomerEntity();
			ce.setPassword(customer.getConfirmNewPassword());
//			model.addAttribute("message", "Chúc mừng, bạn đã nhập đúng!");
			if (this.updateCustomerPassword(ce, httpSession)) {
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
		httpSession.setAttribute("listCategory", this.getListCategory());
		List<CartDetailEntity> listCart = this
				.getListCartDetail(this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		for (CartDetailEntity c : listCart) {
			if (c.getQuantity() > c.getProduct().getQuantity()) {
				attributes.addFlashAttribute("message",
						"Vui lòng cập nhật số lượng hợp lệ và nhấn Thanh toán lần nữa");
				return "redirect:/store/shopping-cart";
			}
		}
		model.addAttribute("order", new OrderModel());
		model.addAttribute("customerEntity",
				this.getCustomerByUsername((String) httpSession.getAttribute("customerUsername")));
		List<CartDetailEntity> cartDetails = this
				.getListCartDetail(this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		model.addAttribute("cartDetails", cartDetails);
		float total = 0;
		for (CartDetailEntity c : cartDetails) {
			total = total + c.getQuantity() * c.getProduct().getPrice();
		}
//		System.out.println(total);
		model.addAttribute("cartDetailsTotal", total);
		return "store/check-out";
	}

	@RequestMapping(value = "/shopping-cart/check-out", method=RequestMethod.POST)
	public String checkOut2(HttpSession httpSession, ModelMap model, @ModelAttribute("order") OrderModel order,
			BindingResult errors, RedirectAttributes attributes) {
		httpSession.setAttribute("listCategory", this.getListCategory());
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
			List <CartDetailEntity> cartDetails = this.getListCartDetail(this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
			model.addAttribute("cartDetails", cartDetails);
			float total=0;
			for(CartDetailEntity c: cartDetails) {
				total = total + c.getQuantity()*c.getProduct().getPrice();
			}
			model.addAttribute("cartDetailsTotal", total);		
			return "store/check-out";
		} else {
			OrderEntity oe = new OrderEntity();
			oe.setCustomerId(this.getUserIdByUserName((String)httpSession.getAttribute("customerUsername")));
			oe.setId(this.createTheNextOrderId());
			oe.setOrderDate(new Date());
			List <CartDetailEntity> cartDetails = this.getListCartDetail(this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
			float total=0;
			for(CartDetailEntity c: cartDetails) {
				total = total + c.getQuantity()*c.getProduct().getPrice();
			}
			oe.setOrderTotal(total);
			oe.setShipAddress(order.getShipAddress());
			oe.setShipName(order.getShipName());
			oe.setShipPhone(order.getShipPhone());
//			/
//			add new properties for order later
			if(this.checkOutHibernate(oe, this.getListCartDetail(this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername"))))){
				attributes.addFlashAttribute("message", "Đặt hàng thành công!");
				return "redirect:/";
			}else{
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
		httpSession.setAttribute("listCategory", this.getListCategory());
		PagedListHolder pagedListHolder = new PagedListHolder(this.getAllProducts());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);

		model.addAttribute("pagedListHolder", pagedListHolder);

		return "store/all-products";
	}

	@RequestMapping("/shopping-cart")
	public String shoppingCart(ModelMap model, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("listCartDetail",
				getListCartDetail(getUserIdByUserName((String) httpSession.getAttribute("customerUsername"))));
		for (CartDetailEntity c : getListCartDetail(getUserIdByUserName("tuanbui"))) {
			System.out.println("user_id: " + c.getCustomer().getId() + "; product_id: " + c.getProduct().getId()
					+ "; quantity= " + c.getQuantity());
		}
		return "store/shopping-cart";
	}

	public boolean checkOutHibernate(OrderEntity order, List<CartDetailEntity> listCartDetail) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		List<ProductEntity> listProduct = this.getListProduct();

		List<ProductEntity> listProductToBeUpdate = new ArrayList<ProductEntity>();

		for (ProductEntity pe : listProduct) {
			for (CartDetailEntity cde : listCartDetail) {
				if (cde.getProduct().getId().trim().equals(pe.getId())) {
//					System.out.println(pe.getQuantity() +"old quan: "+ pe.getName());
					pe.setQuantity(pe.getQuantity() - cde.getQuantity());// new quantity after update
//					System.out.println(pe.getQuantity() +"new quan: "+ pe.getName());
					listProductToBeUpdate.add(pe);
				}
			}
		}
		List<OrderDetailEntity> listODE = new ArrayList<OrderDetailEntity>();
		for (CartDetailEntity cartDetailEntity : listCartDetail) {
			OrderDetailEntity ode = new OrderDetailEntity(order.getId(), cartDetailEntity.getProduct().getId());
			ode.setQuantity(cartDetailEntity.getQuantity());
			listODE.add(ode);
		}
		try {
			session.save(order);
			for (CartDetailEntity cartDetailEntity : listCartDetail) {
				session.delete(cartDetailEntity);
			}
			for(OrderDetailEntity ode: listODE) {
				session.save(ode);
			}

			t.commit();
		} catch (Exception ex) {
			t.rollback();
			return false;
		} finally {
			
			session.close();
		}
		for(ProductEntity p : listProductToBeUpdate) {
			if(updateProductQuantity(p.getId(), p.getQuantity())) {
				return false;
			}
		}
		return true;
	}

	public List<CartDetailEntity> getListCartDetail(String customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CartDetailEntity c WHERE c.customer.id =:customerId";
		Query query = session.createQuery(hql);

		List<CartDetailEntity> list = query.setParameter("customerId", customerId).list();
		return list;
	}

	public String getUserIdByUserName(String userName) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT id FROM CustomerEntity c WHERE c.username =:userName";
		Query query = session.createQuery(hql);
		String customerId = (String) query.setParameter("userName", userName).uniqueResult();
		return customerId;
	}

	public CustomerEntity getCustomerByUsername(String userName) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity c WHERE c.username =:userName";
		Query query = session.createQuery(hql);
		CustomerEntity customer = (CustomerEntity) query.setParameter("userName", userName).uniqueResult();
		return customer;
	}

	public List<ProductEntity> getListProduct() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		return list;
	}

	@RequestMapping(value = "/shopping-cart/delete/{productId}", method = RequestMethod.GET)
	public String delete(@PathVariable("productId") String productId, HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		System.out.println(productId);
		if (deleteProductFromCartDetail(productId, httpSession)) {
			System.out.println("Delete successful");
		} else {
			System.out.println("Delete unsuccessful");
		}
		return "redirect:/store/shopping-cart";
	}

	public boolean deleteProductFromCartDetail(String productId, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM CartDetailEntity c WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId",
				getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", productId);

		return query.executeUpdate() > 0;
	}

	@RequestMapping(value = "/shopping-cart/update", method = RequestMethod.POST)
	public String update(HttpServletRequest request, ModelMap model, HttpSession httpSession, RedirectAttributes attributes) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		String[] product_ids = request.getParameterValues("product_id");
		String[] quantities = request.getParameterValues("quantity");
		for (int i = 0; i < product_ids.length; i++) {
			updateProductQuantityFromCartDetail(product_ids[i], quantities[i], httpSession);
		}
		attributes.addFlashAttribute("message", "Cập nhật số lượng thành công.");
		return "redirect:/store/shopping-cart";
	}

	public boolean updateCustomerDetail(CustomerEntity customer, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CustomerEntity c SET c.firstname=:firstname, c.lastname=:lastname,"
				+ "c.phone=:phone, c.address=:address, c.email=:email   WHERE c.id=:id";
		Query query = session.createQuery(hql).setParameter("id",
				getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("firstname", customer.getFirstname());
		query.setParameter("lastname", customer.getLastname());
		query.setParameter("phone", customer.getPhone());
		query.setParameter("address", customer.getAddress());
		query.setParameter("email", customer.getEmail());
		return query.executeUpdate() > 0;
	}

	public boolean updateCustomerPassword(CustomerEntity customer, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CustomerEntity c SET c.password=:password WHERE c.id=:id";
		Query query = session.createQuery(hql).setParameter("id",
				getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("password", customer.getPassword());
		return query.executeUpdate() > 0;
	}

	public boolean updateProductQuantityFromCartDetail(String productId, String quantity, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE CartDetailEntity c SET c.quantity=:quantity WHERE c.id.customer_id=:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql).setParameter("customerId",
				getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", productId);
		query.setParameter("quantity", Integer.parseInt(quantity));
		return query.executeUpdate() > 0;
	}
	public boolean updateProductQuantity(String productId, int quantity) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE ProductEntity p SET p.quantity=:quantity WHERE p.id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("productId", productId);
		query.setParameter("quantity", quantity);
		return query.executeUpdate() > 0;
	}

	@RequestMapping("/shopping-cart/insert-into-cart/{productId}")
	public String insertToCart(String customerId, @PathVariable("productId") String productId,
			HttpSession httpSession) {
		httpSession.setAttribute("listCategory", this.getListCategory());
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		CartDetailEntity cde = new CartDetailEntity(
				getUserIdByUserName((String) httpSession.getAttribute("customerUsername")), (productId));
		if (cartItemIsExit(productId, httpSession)) {
			System.out.println("Exit; increase quantity by 1!");
			if (!isCartItemMaximumAmountOfProduct(productId, httpSession)) { // nếu số lượng tồn của sản phẩm k bằng số
																				// sản phẩm của
				// product đó trong cart

				if (updateProductQuantityFromCartDetail(productId,
						String.valueOf(getQuantityOfCartItem(productId, httpSession) + 1), httpSession)) {
					System.out.println("Exit; increase quantity by 1 successful!");
					return "redirect:/store/shopping-cart";
				} else {
					System.out.println("Exit; increase quantity by 1 unsuccessful!");
					return "redirect:/store/shopping-cart";
				}

			} else {
				System.out.println(
						"Exit; increase quantity by 1 unsuccessful \n because amount of that product incart is equal to its amount in product!");
				return "redirect:/store/shopping-cart";
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

		return "redirect:/store/shopping-cart";
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
		httpSession.setAttribute("listCategory", this.getListCategory());
		model.addAttribute("keyword", keyword);
		System.out.println(keyword);
		PagedListHolder pagedListHolder = new PagedListHolder(this.searchForProduct(keyword));
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);

		model.addAttribute("pagedListHolder", pagedListHolder);
		return "store/search-result";
	}

	public boolean cartItemIsExit(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.id.product_id FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		String productId = (String) query.uniqueResult();
		return product_id.equals(productId);
	}

	public int getQuantityOfCartItem(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		int quantity = (int) query.uniqueResult();
		return quantity;
	}

	public boolean isCartItemMaximumAmountOfProduct(String product_id, HttpSession httpSession) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		Query query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		int quantityOfCart = (int) query.uniqueResult();
		System.out.println("quantity from cart: " + quantityOfCart);
		hql = "SELECT c.product.quantity FROM CartDetailEntity c WHERE c.id.customer_id =:customerId and c.id.product_id=:productId";
		query = session.createQuery(hql);
		query.setParameter("customerId",
				this.getUserIdByUserName((String) httpSession.getAttribute("customerUsername")));
		query.setParameter("productId", product_id);
		int quantityOfProduct = (int) query.uniqueResult();
		System.out.println("quantity from product: " + quantityOfProduct);
		return quantityOfCart >= quantityOfProduct;
	}

	public ProductEntity getProduct(String productId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.id =:productId";
		Query query = session.createQuery(hql);

		ProductEntity product = (ProductEntity) query.setParameter("productId", productId).uniqueResult();
		return product;
	}

	public List<ProductEntity> getListProductBycategory(String categoryId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.category.id=:categoryId";
		Query query = session.createQuery(hql);

		List<ProductEntity> list = query.setParameter("categoryId", categoryId).list();
		return list;
	}

	public boolean insertCustomer(CustomerEntity customer) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(customer);
			t.commit();
			System.out.println("Insert successful!");

		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
			System.out.println("Insert unsuccessful!");
			return false;
		} finally {
			session.close();
		}
		return true;
	}

	public boolean isCustomerWithUsernameExit(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CustomerEntity c WHERE c.username=:username";
		Query query = session.createQuery(hql);

		CustomerEntity customer = (CustomerEntity) query.setParameter("username", username).uniqueResult();
		return customer != null;
	}

	public String getPasswordOfCustomerWithUsername(String username) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.password FROM CustomerEntity c WHERE c.username=:username";
		Query query = session.createQuery(hql);
		String password = (String) query.setParameter("username", username).uniqueResult();
		return password;
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

	public String createTheNextCustomerId() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT c.id FROM CustomerEntity c WHERE c.id=(SELECT MAX(cc.id) FROM CustomerEntity cc)";
		Query query = session.createQuery(hql);

		String id = (String) query.uniqueResult();
		if (id == null || id.equals("")) {
			return "C0001";
		}
		int x = Integer.parseInt(id.substring(1)) + 1;
		String base = "C0000";
		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
		String newId = base2 + String.valueOf(x);
		return newId;
	}

	public String createTheNextOrderId() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT o.id FROM OrderEntity o WHERE o.id=(SELECT MAX(oo.id) FROM OrderEntity oo)";
		Query query = session.createQuery(hql);

		String id = (String) query.uniqueResult();
		if (id == null || id.equals("")) {
			return "O0001";
		}
		int x = Integer.parseInt(id.substring(1)) + 1;
		String base = "O0000";
		String base2 = base.substring(0, base.length() - String.valueOf(x).length());
		String newId = base2 + String.valueOf(x);
		return newId;
	}

	public List<CategoryEntity> getListCategory() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM CategoryEntity";
		Query query = session.createQuery(hql);
		List<CategoryEntity> list = query.list();
		return list;
	}

	public List<ProductEntity> getTop16RecentProduct() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p ORDER BY p.dateAdded DESC";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.setMaxResults(16).list();
		return list;
	}

	public List<ProductEntity> getAllProducts() {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p ORDER BY p.dateAdded DESC";
		Query query = session.createQuery(hql);
		List<ProductEntity> list = query.list();
		return list;
	}

	public List<ProductEntity> searchForProduct(String keyword) {
		/* System.out.println("getListCartDetail"); */
		Session session = factory.getCurrentSession();
		String hql = "FROM ProductEntity p WHERE p.name LIKE :keyword OR p.category.name LIKE:keyword ORDER BY p.dateAdded DESC";
		Query query = session.createQuery(hql).setParameter("keyword", "%" + keyword + "%");
		List<ProductEntity> list = query.setParameter("keyword", "%" + keyword + "%").list();
		return list;
	}
}
