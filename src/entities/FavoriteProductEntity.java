package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "FavoriteProduct")
public class FavoriteProductEntity {
	@Id
	@GeneratedValue
	@Column(name = "id", updatable = false)
	private int id;

	@ManyToOne
	@JoinColumn(name = "customer_id")
	private CustomerEntity customer;

	@ManyToOne
	@JoinColumn(name = "product_id")
	private ProductEntity product;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CustomerEntity getCustomer() {
		return customer;
	}

	public void setCustomer(CustomerEntity customer) {
		this.customer = customer;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}
}
