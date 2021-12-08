package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import entities.CategoryEntity;
import entities.CustomerEntity;
import entities.OrderEntity;
import entities.ProductEntity;
import models.EntityData;
import models.Pagination;
import models.UploadFile;
import models.statistics.Statistics;

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

	Statistics statistics;

	String viewsDirectory = "admin/pages/dashboard/";

	@RequestMapping("")
	public String renderAdminPage(ModelMap model) throws IOException {
		entityData = new EntityData(factory);
		statistics = new Statistics(factory);
		List<CustomerEntity> customers = entityData.getCustomers();

		float revenue = entityData.getGrossRevenueOfAllOrdersInThisMonth();
		List<ProductEntity> mostViewedProducts = statistics.getMostViewedProducts();
		List<ProductEntity> topFavoriteProducts = statistics.gettopFavoriteProducts();
		List topRevenueProducts = entityData.getTopGrossRevenueProductsInOrdersInThisMonth();
		List<OrderEntity> orders = entityData.getOrders(3);
		List<ProductEntity> products = entityData.getProducts();
		List<CategoryEntity> categories = entityData.getCategories();

		model.addAttribute("mostViewedProducts", mostViewedProducts);
		model.addAttribute("topFavoriteProducts", topFavoriteProducts);
		model.addAttribute("topRevenueProducts", topRevenueProducts);
		model.addAttribute("orders", orders);
		model.addAttribute("categories", categories);

		model.addAttribute("products", products);
		model.addAttribute("revenue", revenue);
		model.addAttribute("customers", customers);
		model.addAttribute("title", "Dashboard");
		model.addAttribute("type", "dashboard");
		return viewsDirectory + "dashboard";
	}

	@RequestMapping(value = "top-favorite-products")
	public String rendertopFavoriteProductsPage(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		entityData = new EntityData(factory);
		statistics = new Statistics(factory);
		List<ProductEntity> topFavoriteProducts = new ArrayList<ProductEntity>();
		try {
			topFavoriteProducts = statistics.gettopFavoriteProducts();
			PagedListHolder pagedListHolder = Pagination.productPagination(request, topFavoriteProducts, 5, 10);
			model.addAttribute("pagedLink", "/admin/dashboard/top-favorite-products");
			model.addAttribute("pagedListHolder", pagedListHolder);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("title", "Xếp hạng yêu thích sản phẩm");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "topFavoriteProducts";
	}

	@RequestMapping(value = "most-viewed-products")
	public String renderMostViewedProductsRankingPage(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		entityData = new EntityData(factory);
		statistics = new Statistics(factory);

		List<ProductEntity> mostViewedProducts = new ArrayList<ProductEntity>();
		try {
			mostViewedProducts = statistics.getMostViewedProducts();
			PagedListHolder pagedListHolder = Pagination.productPagination(request, mostViewedProducts, 5, 10);
			model.addAttribute("pagedLink", "/admin/dashboard/most-viewed-products");
			model.addAttribute("pagedListHolder", pagedListHolder);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("title", "Xếp hạng lượt xem sản phẩm");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "mostViewedProducts";
	}
}
