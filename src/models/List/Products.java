package models.List;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import entities.ProductEntity;

public class Products {
	private List<ProductEntity> list;

	public Products() {
		// TODO Auto-generated constructor stub
	}

	public List<ProductEntity> getList() {
		return list;
	}

	public void setList(List<ProductEntity> products) {
		this.list = products;
	}

	public Products(List<ProductEntity> products) {
		super();
		this.list = products;
	}

	public Products sortByFavorite(String orderBy) {
		Products sortedProducts = new Products(list);

		if (orderBy.equals("DESC")) {
			Collections.sort(sortedProducts.getList(), new Comparator<ProductEntity>() {
				@Override
				public int compare(ProductEntity o1, ProductEntity o2) {
					// TODO Auto-generated method stub
					return o2.getFavoriteProducts().size() - o1.getFavoriteProducts().size();
				}

			});
		} else {
			Collections.sort(sortedProducts.getList(), new Comparator<ProductEntity>() {
				@Override
				public int compare(ProductEntity o1, ProductEntity o2) {
					// TODO Auto-generated method stub
					return o1.getFavoriteProducts().size() - o2.getFavoriteProducts().size();
				}

			});
		}
		return sortedProducts;
	}

	public Products sortByViews(String orderBy) {
		Products sortedProducts = new Products(list);

		if (orderBy.equals("DESC")) {
			Collections.sort(sortedProducts.getList(), new Comparator<ProductEntity>() {
				@Override
				public int compare(ProductEntity o1, ProductEntity o2) {
					// TODO Auto-generated method stub
					if (o1.getViews() == o2.getViews())
						return 0;
					else if (o1.getViews() > o2.getViews())
						return -1;
					else
						return 1;
				}

			});
		} else {
			Collections.sort(sortedProducts.getList(), new Comparator<ProductEntity>() {
				@Override
				public int compare(ProductEntity o1, ProductEntity o2) {
					// TODO Auto-generated method stub
					if (o1.getViews() == o2.getViews())
						return 0;
					else if (o1.getViews() > o2.getViews())
						return 1;
					else
						return -1;
				}

			});
		}
		return sortedProducts;
	}

}
