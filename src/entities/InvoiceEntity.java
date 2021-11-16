package entities;

import java.util.ArrayList;
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
@Table(name = "Invoice")
public class InvoiceEntity {
	@Id
	@Column(name = "id", updatable = false)
	private String id;
	@Column(name = "date")
	/* @Temporal(TemporalType.DATE) */
	private String date;
	@Column(name = "time")
	/* @Temporal(TemporalType.TIMESTAMP) */
	private String time;

	@ManyToOne()
	@JoinColumn(name = "admin_id")
	private AdminEntity admin;

	@ManyToOne()
	@JoinColumn(name = "invoice_type_id")
	private InvoiceTypeEntity invoiceType;

	@OneToMany(mappedBy = "invoice", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<InvoiceDetailEntity> invoiceDetails;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public AdminEntity getAdmin() {
		return admin;
	}

	public void setAdmin(AdminEntity admin) {
		this.admin = admin;
	}

	public InvoiceTypeEntity getInvoiceType() {
		return invoiceType;
	}

	public void setInvoiceType(InvoiceTypeEntity invoiceType) {
		this.invoiceType = invoiceType;
	}

	public List<InvoiceDetailEntity> getInvoiceDetails() {
		return invoiceDetails;
	}

	public void setInvoiceDetails(List<InvoiceDetailEntity> invoiceDetails) {
		this.invoiceDetails = invoiceDetails;
	}

	public InvoiceEntity() {
		// TODO Auto-generated constructor stub
		this.invoiceType = new InvoiceTypeEntity();
		this.admin = new AdminEntity();
		this.invoiceDetails = new ArrayList<InvoiceDetailEntity>();
	}

	public boolean hasProduct(String productId) {
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			if (invoiceDetail.getProduct().getId().equals(productId))
				return true;
		}
		return false;
	}

	// GET TOTAL QUANTITY OF PRODUCT IN INVOICE
	public int getTotalQuantity() {
		int totalQuantity = 0;
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			totalQuantity += invoiceDetail.getQuantity();
		}
		return totalQuantity;
	}

	// GET TOTAL PRICE OF INVOICE
	public float getTotalPrice() {
		float totalPrice = 0;
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			totalPrice += (invoiceDetail.getPrice() * invoiceDetail.getQuantity());
		}
		return totalPrice;
	}

	public int getQuantity(String productId) {
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			if (invoiceDetail.getProduct().getId().equals(productId))
				return invoiceDetail.getQuantity();
		}
		return 0;
	}

	public float getPrice(String productId) {
		for (InvoiceDetailEntity invoiceDetail : invoiceDetails) {
			if (invoiceDetail.getProduct().getId().equals(productId))
				return invoiceDetail.getPrice();
		}
		return 0;
	}

}
