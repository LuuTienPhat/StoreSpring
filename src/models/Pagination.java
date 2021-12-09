package models;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.support.PagedListHolder;
import org.springframework.web.bind.ServletRequestUtils;

import entities.CategoryEntity;
import entities.CustomerEntity;
import entities.InvoiceDetailEntity;
import entities.InvoiceEntity;
import entities.OrderDetailEntity;
import entities.OrderEntity;
import entities.ProductEntity;

public class Pagination {

	// PRODUCT PAGINATION
	public static PagedListHolder productPagination(HttpServletRequest request, List<ProductEntity> products,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// CATEGORY PAGINATION
	public static PagedListHolder categoryPagination(HttpServletRequest request, List<CategoryEntity> categories,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// CUSTOMER PAGINATION
	public static PagedListHolder customerPagination(HttpServletRequest request, List<CustomerEntity> customers,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(customers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// ORDER PAGINATION
	public static PagedListHolder ordersPagination(HttpServletRequest request, List<OrderEntity> orders,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(orders);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// ORDER PAGINATION
	public static PagedListHolder orderDetailPagination(HttpServletRequest request,
			List<OrderDetailEntity> orderDetails, int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(orderDetails);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// INVOICE PAGINATION
	public static PagedListHolder invoicePagination(HttpServletRequest request, List<InvoiceEntity> invoices,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(invoices);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// INVOICE DETAIL PAGINATION
	public static PagedListHolder invoiceDetailPagination(HttpServletRequest request,
			List<InvoiceDetailEntity> invoiceDetails, int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(invoiceDetails);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	// LIST PAGINATION
	public static PagedListHolder listPagination(HttpServletRequest request, List list, int maxLinkedPages,
			int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}
}
