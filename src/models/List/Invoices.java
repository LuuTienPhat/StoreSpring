package models.List;

import java.util.ArrayList;
import java.util.List;

import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;

public class Invoices {
	private List<InvoiceEntity> invoices;

	public List<InvoiceEntity> getInvoices() {
		return invoices;
	}

	public void setInvoices(List<InvoiceEntity> invoices) {
		this.invoices = invoices;
	}

	public Invoices(List<InvoiceEntity> invoices) {
		super();
		this.invoices = invoices;
	}

	public Invoices() {
		// TODO Auto-generated constructor stub
		this.invoices = new ArrayList<InvoiceEntity>();
	}

	public List<InvoiceEntity> getImportInvoices() {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : invoices) {
			if (invoice.getInvoiceType().getId() == 1) {
				invoices.add(invoice);
			}
		}
		return invoices;
	}

	public List<InvoiceEntity> getExportInvoices() {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : invoices) {
			if (invoice.getInvoiceType().getId() == 2) {
				invoices.add(invoice);
			}
		}
		return invoices;
	}

	public List<InvoiceEntity> getExportByType(InvoiceTypeEntity invoiceType) {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : invoices) {
			if (invoice.getInvoiceType().getId() == invoiceType.getId()) {
				invoices.add(invoice);
			}
		}
		return invoices;
	}
}
