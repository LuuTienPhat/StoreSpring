package entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "CartDetail")
public class CartDetailEntity {
	@EmbeddedId CompositeKey id;
	
	@Column(name = "quantity")
	private int quantity;
	
	@ManyToOne
	@JoinColumn(name = "customer_id", referencedColumnName = "id", insertable = false, updatable = false)
	private CustomerEntity customer; 
	
	@ManyToOne
	@JoinColumn(name = "product_id", referencedColumnName = "id", insertable = false, updatable = false)
	private ProductEntity product;

	public CompositeKey getId() {
		return id;
	}

	public void setId(CompositeKey id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
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

	public CartDetailEntity() {
		
	}
	public CartDetailEntity(String customer_id, String product_id) {
		this.id = new CompositeKey(customer_id, product_id);
	}
	@Embeddable
	static class CompositeKey implements Serializable {
	    private String customer_id;
	    private String product_id;
		public String getCustomer_id() {
			return customer_id;
		}
		public void setCustomer_id(String customer_id) {
			this.customer_id = customer_id;
		}
		public String getProduct_id() {
			return product_id;
		}
		public void setProduct_id(String product_id) {
			this.product_id = product_id;
		}
		public CompositeKey(String customer_id, String product_id) {
			this.customer_id = customer_id;
			this.product_id = product_id;
		}
		public CompositeKey(){
			
		}
	}
}


