package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import entities.CategoryEntity;
import entities.ProductEntity;
import models.EntityData;
import models.Revenue;
import models.statistics.OrderStatistics;
import models.statistics.Statistics;

@Controller
@Transactional

@RequestMapping("/chart")
public class ChartController {
	private static final long serialVersionUID = 1L;
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("sessionFactory")
	SessionFactory factory;

	EntityData entityData;

	Statistics statistics;

	@RequestMapping(value = "", method = RequestMethod.GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		entityData = new EntityData(factory);
		List<OrderStatistics> orderStatisticsByMonths = entityData.getOrderStatistics();

		try {
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			response.setContentType("application/json");
			// response.setHeader("Access-Control-Allow-Origin",
			PrintWriter out = response.getWriter();
			out.println(gson.toJson(orderStatisticsByMonths));
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}

	}

	@RequestMapping(value = "products-of-category-chart", method = RequestMethod.GET)
	public void returnProductsOfCategoryChart(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		entityData = new EntityData(factory);
		List<CategoryEntity> categories = entityData.getCategories();
		for (CategoryEntity category : categories) {
			for (ProductEntity product : category.getProducts()) {
				product.setCartDetails(null);
				product.setCategory(null);
				product.setFavoriteProducts(null);
				product.setImages(null);
				product.setOrderDetails(null);
				product.setInvoiceDetails(null);
			}
		}

		try {
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			response.setContentType("application/json");
			// response.setHeader("Access-Control-Allow-Origin",
			PrintWriter out = response.getWriter();
			out.println(gson.toJson(categories));
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}

	@RequestMapping(value = "sales-chart", method = RequestMethod.GET)
	public void returnSalesChart(HttpServletRequest request, HttpServletResponse response) throws IOException {
		statistics = new Statistics(factory);

		List<Revenue> revenues = statistics.getMonthlyRevenue(10);

		try {
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			response.setContentType("application/json");
			// response.setHeader("Access-Control-Allow-Origin",
			PrintWriter out = response.getWriter();
			/* Wrapper wrapper = new Wrapper(orderStatisticsByMonths); */
			out.println(gson.toJson(revenues));
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
}
