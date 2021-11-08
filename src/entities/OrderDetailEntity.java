package entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import entities.CartDetailEntity.CompositeKey;


@Entity
@Table(name = "OrderDetail")
public class OrderDetailEntity {
	@EmbeddedId 
	private OrderDetailKey id;
	
	@ManyToOne
	@JoinColumn(name = "order_id", referencedColumnName = "id", insertable = false, updatable = false )
	private OrderEntity order; 
	
	@ManyToOne
	@JoinColumn(name = "product_id",referencedColumnName = "id",  insertable = false, updatable = false)
	private ProductEntity product;

	@Column(name = "quantity", nullable = true)
	private int quantity;

	public OrderDetailKey getId() {
		return id;
	}

	public void setId(OrderDetailKey id) {
		this.id = id;
	}

	public OrderEntity getOrder() {
		return order;
	}

	public void setOrder(OrderEntity order) {
		this.order = order;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public OrderDetailEntity(String orderId, String product_id) {
		this.id = new OrderDetailKey(orderId, product_id);
	}
	public OrderDetailEntity() {
		
	}
	// đưa orderDetailKey vào trong Class OrderDetailEntity
	@Embeddable
	public static class OrderDetailKey implements Serializable {
		private static final long serialVersionUID = 1L;
		
		@Column(name = "order_id")
		private String orderId;
		
		@Column(name = "product_id")
	    private String productId;
		
		public String getorderId() {
			return orderId;
		}
		public void setorderId(String orderId) {
			this.orderId = orderId;
		}
		public String getproductId() {
			return productId;
		}
		public void setproductId(String productId) {
			this.productId = productId;
		}
		
		public OrderDetailKey(String order_id, String product_id) {
			this.orderId = order_id;
			this.productId = product_id;
		}
		public OrderDetailKey() {
		
		}
	}
}





