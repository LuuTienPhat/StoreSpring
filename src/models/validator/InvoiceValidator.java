package models.validator;

import java.util.List;

import entities.InvoiceEntity;
import models.Generate;

public class InvoiceValidator {
	public static Boolean isExportQuantityValid(int oldQuantity, int newQuantity) {
		return newQuantity > oldQuantity ? false : true;
	}

	public static Boolean isInvoiceIdValid(String invoiceId, List<InvoiceEntity> invoices) {
		invoiceId = invoiceId.trim();
		InvoiceEntity invoice = Generate.searchInvoice(invoices, invoiceId);
		return invoice == null ? true : false;
	}
}
