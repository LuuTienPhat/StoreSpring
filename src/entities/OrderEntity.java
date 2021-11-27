package entities;

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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "[Order]")
public class OrderEntity {
	@Id
	@Column(name = "id")
	private String id;
	@Column(name = "customer_id")
	private String customerId;
	/*
	 * @Column(name = "order_total") private float orderTotal;
	 */
	@Column(name = "order_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date orderDate;
	/*
	 * @Column(name = "shipped_date") private Date shippedDate;
	 */
	@Column(name = "ship_name")
	private String shipName;
	@Column(name = "ship_phone")
	private String shipPhone;
	@Column(name = "ship_address")
	private String shipAddress;
	@Column(name = "ship_note")
	private String shipNote;
	@Column(name = "state")
	private int state;

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<OrderDetailEntity> orderDetails;

	@ManyToOne
	@JoinColumn(name = "customer_id", insertable = false, updatable = false)
	private CustomerEntity customer;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	/*
	 * public Date getShippedDate() { return shippedDate; }
	 * 
	 * public void setShippedDate(Date shippedDate) { this.shippedDate =
	 * shippedDate; }
	 */

	public String getShipName() {
		return shipName;
	}

	public void setShipName(String shipName) {
		this.shipName = shipName;
	}

	public String getShipPhone() {
		return shipPhone;
	}

	public void setShipPhone(String shipPhone) {
		this.shipPhone = shipPhone;
	}

	public String getShipAddress() {
		return shipAddress;
	}

	public void setShipAddress(String shipAddress) {
		this.shipAddress = shipAddress;
	}

	public String getShipNote() {
		return shipNote;
	}

	public void setShipNote(String shipNote) {
		this.shipNote = shipNote;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public List<OrderDetailEntity> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetailEntity> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public CustomerEntity getCustomer() {
		return customer;
	}

	public void setCustomer(CustomerEntity customer) {
		this.customer = customer;
	}

	/*
	 * public float getOrderTotal() { return orderTotal; }
	 * 
	 * public void setOrderTotal(float orderTotal) { this.orderTotal = orderTotal; }
	 */

	public OrderEntity() {
		// TODO Auto-generated constructor stub
	}

	// GET TOTAL PRICE OF ORDER
	public float getTotalPrice() {
		float totalPrice = 0;
		for (OrderDetailEntity orderDetail : orderDetails) {
			totalPrice += (orderDetail.getProduct().getPrice() * orderDetail.getQuantity());
		}
		return totalPrice;
	}

	// GET TOTAL QUANTITY OF ORDER
	public int getTotalQuantity() {
		int totalQuantity = 0;
		for (OrderDetailEntity orderDetail : orderDetails) {
			totalQuantity += orderDetail.getQuantity();
		}
		return totalQuantity;
	}

	// GET QUANTITY OF CHOSEN PRODUCT IN ORDER
	public int getQuantity(String productId) {
		for (OrderDetailEntity orderDetail : orderDetails) {
			if (orderDetail.getProduct().getId().equals(productId))
				return orderDetail.getQuantity();
		}
		return 0;
	}

}
