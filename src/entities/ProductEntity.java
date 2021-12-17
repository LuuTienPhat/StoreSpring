package entities;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.format.annotation.DateTimeFormat;

import models.validator.DateTimeValidator;

@Entity
@Table(name = "Product")
public class ProductEntity {
	@Id
	@Column(name = "id", updatable = false)
	private String id;

	@Column(name = "name")
	private String name;

	@Column(name = "quantity")
	private int quantity;

	@Column(name = "unit")
	private String unit;

	@Column(name = "price")
	private float price;

	@Column(name = "description", nullable = true)
	private String description;

	@Column(name = "date_added", updatable = false)
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date dateAdded;

	@Column(name = "views", nullable = true)
	private int views;

	@ManyToOne
	@JoinColumn(name = "category_id")
	private CategoryEntity category;

	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<CartDetailEntity> cartDetails;

	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<OrderDetailEntity> orderDetails;

	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<ImageEntity> images;

	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<InvoiceDetailEntity> invoiceDetails;

	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<FavoriteProductEntity> favoriteProducts;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getDateAdded() {
		return dateAdded;
	}

	public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public CategoryEntity getCategory() {
		return category;
	}

	public void setCategory(CategoryEntity category) {
		this.category = category;
	}

	public List<ImageEntity> getImages() {
		return images;
	}

	public void setImages(List<ImageEntity> images) {
		this.images = images;
	}

	public List<CartDetailEntity> getCartDetails() {
		return cartDetails;
	}

	public void setCartDetails(List<CartDetailEntity> cartDetails) {
		this.cartDetails = cartDetails;
	}

	public List<OrderDetailEntity> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetailEntity> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public List<InvoiceDetailEntity> getInvoiceDetails() {
		return invoiceDetails;
	}

	public void setInvoiceDetails(List<InvoiceDetailEntity> invoiceDetails) {
		this.invoiceDetails = invoiceDetails;
	}

	public List<FavoriteProductEntity> getFavoriteProducts() {
		return favoriteProducts;
	}

	public void setFavoriteProducts(List<FavoriteProductEntity> favoriteProducts) {
		this.favoriteProducts = favoriteProducts;
	}

	// GET TOTAL REVENUE OF SINGLE PRODUCT IN ORDERS
	public float getGrossRevenueInOrders(String productId) {
		float revenue = 0;
		for (OrderDetailEntity orderDetail : orderDetails) {
			if (orderDetail.getProduct().getId().equals(productId)) {
				revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
			}
		}
		return revenue;
	}

	// GET TOTAL REVENUE OF SINGLE PRODUCT IN ORDERS OF THIS MONTH
	public float getGrossRevenueInOrdersOfThisMonth(String productId) throws ParseException {
		LocalDate now = LocalDate.now();
		LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
		LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

		String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = formatter.parse(firstDayOfMonthString);
		Date d2 = formatter.parse(lastDayOfMonthString);

		float revenue = 0;
		for (OrderDetailEntity orderDetail : orderDetails) {
			if (orderDetail.getProduct().getId().equals(productId)) {
				if (orderDetail.getOrder().getOrderDate().after(d1)
						&& orderDetail.getOrder().getOrderDate().before(d2)) {
					revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
				}
			}
		}
		return revenue;
	}

	public float getBounceRate(String productId) throws ParseException {
		float revenueThisMonth = getGrossRevenueInOrdersOfThisMonth(productId);
		float revenueLastMonth = getGrossRevenueInOrdersOfLastMonth(productId);
		return getBounceRate(revenueThisMonth, revenueLastMonth);
	}

	public float getBounceRate(float revenueThisMonth, float revenueLastMonth) {
		if (revenueLastMonth == 0)
			return 0;
		else
			return ((revenueLastMonth - revenueThisMonth) / revenueLastMonth) * 100;
	}

	public float getGrossRevenueInOrdersOfLastMonth(String productId) throws ParseException {
		LocalDate now = LocalDate.now().minusMonths(1);
		LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
		LocalDate firstDayOfMonth = now.with(TemporalAdjusters.firstDayOfMonth());

		String lastDayOfMonthString = lastDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		String firstDayOfMonthString = firstDayOfMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = formatter.parse(firstDayOfMonthString);
		Date d2 = formatter.parse(lastDayOfMonthString);

		float revenue = 0;
		for (OrderDetailEntity orderDetail : orderDetails) {
			if (orderDetail.getProduct().getId().equals(productId)) {
				if (orderDetail.getOrder().getOrderDate().after(d1)
						&& orderDetail.getOrder().getOrderDate().before(d2)) {
					revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
				}
			}
		}
		return revenue;
	}

	public float getTotalRevenueInOrders() throws ParseException {
		float revenue = 0;
		for (OrderDetailEntity orderDetail : this.orderDetails) {
			revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
		}
		return revenue;
	}

	public float getTotalRevenueInOrders(LocalDate beginDate, LocalDate endDate) throws ParseException {
		float revenue = 0;
		for (OrderDetailEntity orderDetail : this.orderDetails) {
			LocalDate orderDate = DateTimeValidator.convertToLocalDateViaInstant(orderDetail.getOrder().getOrderDate());
			if (orderDate.isAfter(beginDate) && orderDate.isBefore(endDate))
				revenue += orderDetail.getQuantity() * orderDetail.getProduct().getPrice();
		}
		return revenue;
	}

	public ProductEntity() {
		// TODO Auto-generated constructor stub
	}
}
