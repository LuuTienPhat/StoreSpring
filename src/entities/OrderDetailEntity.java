package entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


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

	@Column(name = "quantity")
	private int quantity;
}


@Embeddable
class OrderDetailKey implements Serializable {
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
}


