package models;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.support.PagedListHolder;
import org.springframework.web.bind.ServletRequestUtils;

import entities.CategoryEntity;
import entities.CustomerEntity;
import entities.InvoiceEntity;
import entities.OrderEntity;
import entities.ProductEntity;

public class Pagination {
	public static PagedListHolder productsPagination(HttpServletRequest request, List<ProductEntity> products,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	public static PagedListHolder categoriesPagination(HttpServletRequest request, List<CategoryEntity> categories,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	public static PagedListHolder customersPagination(HttpServletRequest request, List<CustomerEntity> customers,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(customers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	public static PagedListHolder ordersPagination(HttpServletRequest request, List<OrderEntity> orders,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(orders);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}

	public static PagedListHolder invoicesPagination(HttpServletRequest request, List<InvoiceEntity> invoices,
			int maxLinkedPages, int pageSize) {
		PagedListHolder pagedListHolder = new PagedListHolder(invoices);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(maxLinkedPages);
		pagedListHolder.setPageSize(pageSize);
		return pagedListHolder;
	}
}
