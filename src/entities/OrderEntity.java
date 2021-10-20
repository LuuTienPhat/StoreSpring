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

@Entity
@Table(name = "[Order]")
public class OrderEntity {
	@Id
	@Column(name = "id")
	private String id;
	@Column(name = "customer_id")
	private String customerId;
	@Column(name = "order_date")
	private Date orderDate;
	@Column(name = "shipped_date")
	private Date shippedDate;
	@Column(name = "ship_name")
	private String shipName;
	@Column(name = "ship_phone")
	private String shipPhone;
	@Column(name = "ship_address")
	private String shipAddress;
	@Column(name = "ship_city")
	private String shipCity;
	@Column(name = "admin_approved")
	private byte adminApproved;

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<OrderDetailEntity> orderDetails;

	@ManyToOne
	@JoinColumn(name = "customer_id", insertable = false, updatable = false)
	private CustomerEntity customer;

}
