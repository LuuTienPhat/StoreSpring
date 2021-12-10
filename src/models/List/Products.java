package models.List;

import java.util.List;

import entities.ProductEntity;

public class Products {
	private List<ProductEntity> products;

	public Products() {
		// TODO Auto-generated constructor stub
	}

	public List<ProductEntity> getProducts() {
		return products;
	}

	public void setProducts(List<ProductEntity> products) {
		this.products = products;
	}

	public Products(List<ProductEntity> products) {
		super();
		this.products = products;
	}

}
