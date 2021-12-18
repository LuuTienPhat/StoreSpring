package controllers;

import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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
import models.Pagination;
import models.UploadFile;
import models.List.Categories;
import models.List.Customers;
import models.List.Invoices;
import models.List.Orders;
import models.List.Products;
import models.dao.CategoryDAO;
import models.dao.CustomerDAO;
import models.dao.InvoiceDAO;
import models.dao.OrderDAO;
import models.dao.ProductDAO;
import models.statistics.Statistics;
import models.statistics.TopRevenueProduct;

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

	Statistics statistics;

	ProductDAO productDAO;
	CustomerDAO customerDAO;
	CategoryDAO categoryDAO;
	OrderDAO orderDAO;
	InvoiceDAO invoiceDAO;

	String viewsDirectory = "admin/pages/dashboard/";

	@RequestMapping("")
	public String renderAdminPage(ModelMap model) throws IOException, ParseException {
		statistics = new Statistics(factory);
		productDAO = new ProductDAO(factory);
		categoryDAO = new CategoryDAO(factory);
		customerDAO = new CustomerDAO(factory);
		orderDAO = new OrderDAO(factory);
		invoiceDAO = new InvoiceDAO(factory);

		Locale locale = new Locale("vi");
		LocalDate now = LocalDate.now();
		LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
		LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());
		String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("dd MMM").withLocale(locale));
		String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("dd MMM").withLocale(locale));

		Categories categories = categoryDAO.getCategories();
		Products products = productDAO.getProducts();
		Products mostViewedProducts = productDAO.getMostViewedProducts();
		Products topFavoriteProducts = productDAO.getTopFavoriteProducts();
		Customers customers = customerDAO.getCustomers();
		Orders orders = orderDAO.getOrders(3);
		Invoices thisMonthInvoices = invoiceDAO.getInvoices(firstDayOfMonth, lastDayOfMonth);
		Orders thisMonthOrders = orderDAO.getOrders(firstDayOfMonth, lastDayOfMonth, "3");

		// List topRevenueProducts =
		// statistics.getTopGrossRevenueProductsInOrdersInThisMonth();
		List<TopRevenueProduct> topRevenueProducts = statistics.getTopRevenueProductsInOrders();

		Orders todayOrders = orderDAO.getOrders(now, now.plusDays(1), "3");

		// TOTAL REVENUE OF ORDERS TODAY
		float todayTotalRevenue = todayOrders.getTotalRevenue();
		// TOTAL REVENUE THIS MONTH
		float thisMonthTotalRevenue = thisMonthOrders.getTotalRevenue();

		model.addAttribute("topRevenueProducts", topRevenueProducts);

		model.addAttribute("todayTotalRevenue", todayTotalRevenue);
		model.addAttribute("thisMonthTotalRevenue", thisMonthTotalRevenue);

		model.addAttribute("mostViewedProducts", mostViewedProducts.getList());
		model.addAttribute("topFavoriteProducts", topFavoriteProducts.getList());

		model.addAttribute("categories", categories.getList());
		model.addAttribute("products", products.getList());
		model.addAttribute("customers", customers.getList());
		model.addAttribute("orders", orders);
		model.addAttribute("thisMonthOrders", thisMonthOrders.getList());
		model.addAttribute("thisMonthInvoices", thisMonthInvoices);

		model.addAttribute("thisMonth", firstDayOfMonthString + " - " + lastDayOfMonthString);
		model.addAttribute("growthRateOfOrdersComparedToYesterday", statistics.getDayOverDayGrowthRateOfOrders());
		model.addAttribute("growthRateOfCustomers", statistics.getMonthOverMonthGrowthRateOfCustomers());
		model.addAttribute("growthRateOfInvoices", statistics.getMonthOverMonthGrowthRateOfInvoices());
		model.addAttribute("growthRateOfOrders", statistics.getMonthOverMonthGrowthRateOfOrders());
		model.addAttribute("growthRateOfRevenue", statistics.getMonthOverMonthGrowthRateOfRevenue());
		model.addAttribute("growthRateOfCategories", statistics.getMonthOverMonthGrowthRateOfCategories());
		model.addAttribute("growthRateOfProducts", statistics.getMonthOverMonthGrowthRateOfProducts());

		model.addAttribute("title", "Dashboard");
		model.addAttribute("type", "dashboard");
		return viewsDirectory + "dashboard";
	}

	@RequestMapping(value = "top-favorite-products")
	public String rendertopFavoriteProductsPage(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		productDAO = new ProductDAO(factory);

		Products topFavoriteProducts = productDAO.getTopFavoriteProducts();
		PagedListHolder pagedListHolder = Pagination.productPagination(request, topFavoriteProducts.getList(), 5, 10);
		model.addAttribute("pagedLink", "/admin/dashboard/top-favorite-products");
		model.addAttribute("pagedListHolder", pagedListHolder);

		model.addAttribute("title", "Xếp hạng yêu thích sản phẩm");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "topFavoriteProducts";
	}

	@RequestMapping(value = "most-viewed-products")
	public String renderMostViewedProductsRankingPage(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		productDAO = new ProductDAO(factory);

		Products mostViewedProducts = productDAO.getMostViewedProducts();
		PagedListHolder pagedListHolder = Pagination.productPagination(request, mostViewedProducts.getList(), 5, 10);
		model.addAttribute("pagedLink", "/admin/dashboard/most-viewed-products");
		model.addAttribute("pagedListHolder", pagedListHolder);

		model.addAttribute("title", "Xếp hạng lượt xem sản phẩm");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "mostViewedProducts";

	}

	@RequestMapping(value = "top-revenue-products")
	public String renderTopRevenueProductsPage(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ParseException {
		statistics = new Statistics(factory);

		List<TopRevenueProduct> topRevenueProducts = statistics.getTopRevenueProductsInOrders();
		PagedListHolder pagedListHolder = Pagination.listPagination(request, topRevenueProducts, 5, 10);

		model.addAttribute("pagedLink", "/admin/dashboard/top-revenue-products");
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("title", "Top doanh thu sản phẩm trong tháng");
		model.addAttribute("type", "sản phẩm");
		return viewsDirectory + "topRevenueProducts";
	}
}
