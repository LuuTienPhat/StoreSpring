package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import entities.CustomerEntity;
import entities.OrderEntity;
import entities.ProductEntity;
import models.EntityData;
import models.UploadFile;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	@Autowired
	@Qualifier("uploadFile")
	UploadFile uploadFile;

	EntityData entityData;

	String viewsDirectory = "admin/pages/dashboard/";

	@RequestMapping("")
	public String renderAdminPage(ModelMap model) throws IOException {
		entityData = new EntityData(factory);
		List<CustomerEntity> customers = entityData.getCustomers();

		float revenue = entityData.getGrossRevenueOfAllOrdersInThisMonth();
		List<ProductEntity> mostViewedProducts = entityData.getMostViewedProducts();
		List<ProductEntity> topFavoriteProducts = entityData.getTopFavoriteProducts();
		List topRevenueProducts = entityData.getTopGrossRevenueProductsInOrdersInThisMonth();
		List<OrderEntity> orders = entityData.getOrders(3);
		List<ProductEntity> products = entityData.getProducts();

		model.addAttribute("mostViewedProducts", mostViewedProducts);
		model.addAttribute("topFavoriteProducts", topFavoriteProducts);
		model.addAttribute("topRevenueProducts", topRevenueProducts);
		model.addAttribute("orders", orders);

		model.addAttribute("products", products);
		model.addAttribute("revenue", revenue);
		model.addAttribute("customers", customers);
		model.addAttribute("title", "Dashboard");
		model.addAttribute("pageName", "dashboard");
		return viewsDirectory + "dashboard";
	}
}
