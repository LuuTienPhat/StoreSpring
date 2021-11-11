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
@Table(name = "Invoice")
public class InvoiceEntity {
	@Id
	@Column(name = "id", updatable = false)
	private String id;
	@Column(name = "date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date date;

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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
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
	}
}
