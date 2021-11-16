package entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "InvoiceType")
public class InvoiceTypeEntity {
	@Id
	@GeneratedValue
	@Column(name = "id", updatable = false, insertable = false)
	private int id;

	@Column(name = "name")
	private String name;
	
	@OneToMany(mappedBy = "invoiceType", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private List<InvoiceEntity> invoices;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public List<InvoiceEntity> getInvoices() {
		return invoices;
	}

	public void setInvoices(List<InvoiceEntity> invoices) {
		this.invoices = invoices;
	}

	public InvoiceTypeEntity() {
		// TODO Auto-generated constructor stub
	}
}
