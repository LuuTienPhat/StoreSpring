package models.List;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import entities.InvoiceEntity;
import entities.InvoiceTypeEntity;
import entities.OrderEntity;
import models.validator.DateTimeValidator;

public class Invoices {
	private List<InvoiceEntity> list;

	public List<InvoiceEntity> getList() {
		return list;
	}

	public void setList(List<InvoiceEntity> invoices) {
		this.list = invoices;
	}

	public Invoices(List<InvoiceEntity> invoices) {
		super();
		this.list = invoices;
	}

	public Invoices() {
		// TODO Auto-generated constructor stub
		this.list = new ArrayList<InvoiceEntity>();
	}

	public List<InvoiceEntity> getImportInvoices() {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : list) {
			if (invoice.getInvoiceType().getId() == 1) {
				invoices.add(invoice);
			}
		}
		return invoices;
	}

	public List<InvoiceEntity> getExportInvoices() {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : list) {
			if (invoice.getInvoiceType().getId() == 2) {
				invoices.add(invoice);
			}
		}
		return invoices;
	}

	public List<InvoiceEntity> getInvoicesByType(InvoiceTypeEntity invoiceType) {
		List<InvoiceEntity> invoices = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : invoices) {
			if (invoice.getInvoiceType().getId() == invoiceType.getId()) {
				invoices.add(invoice);
			}
		}
		return invoices;
	}

	public float getTotalValue() {
		float value = 0;
		for (InvoiceEntity invoice : list) {
			value += invoice.getTotalPrice();
		}
		return value;
	}

	public static Invoices getInvoices(LocalDate beginDate, LocalDate endDate, Invoices invoices) {
		List<InvoiceEntity> list = new ArrayList<InvoiceEntity>();
		for (InvoiceEntity invoice : invoices.getList()) {
			LocalDate date = DateTimeValidator.convertToLocalDate(invoice.getDate());
			if (date.isAfter(beginDate) && date.isBefore(endDate)) {
				list.add(invoice);
			}
		}
		return new Invoices(list);
	}

	public static float getTotalValue(Invoices invoices) {
		float value = 0;
		for (InvoiceEntity invoice : invoices.getList()) {
			value += invoice.getTotalPrice();
		}
		return value;
	}
}
