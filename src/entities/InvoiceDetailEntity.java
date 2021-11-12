package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "InvoiceDetail")
public class InvoiceDetailEntity {
	@Id
	@GeneratedValue
	@Column(name = "id", updatable = false)
	private int id;

	@ManyToOne()
	@JoinColumn(name = "invoice_id")
	private InvoiceEntity invoice;

	@ManyToOne()
	@JoinColumn(name = "product_id")
	private ProductEntity product;

	@Column(name = "quantity")
	private int quantity;

	@Column(name = "price")
	private float price;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public InvoiceEntity getInvoice() {
		return invoice;
	}

	public void setInvoice(InvoiceEntity invoice) {
		this.invoice = invoice;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public InvoiceDetailEntity() {
		// TODO Auto-generated constructor stub
	}
}
