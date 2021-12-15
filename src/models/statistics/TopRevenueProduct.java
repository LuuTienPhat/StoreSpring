package models.statistics;

import entities.ProductEntity;

public class TopRevenueProduct {
	private ProductEntity product;
	private float thisMonthRevenue;
	private float growthRatePercentage;
	private float allTimeRevenue;

	public TopRevenueProduct() {
		// TODO Auto-generated constructor stub
	}

	public TopRevenueProduct(ProductEntity product, float thisMonthRevenue, float growthRatePercentage,
			float allTimeRevenue) {
		super();
		this.product = product;
		this.thisMonthRevenue = thisMonthRevenue;
		this.growthRatePercentage = growthRatePercentage;
		this.allTimeRevenue = allTimeRevenue;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}

	public float getThisMonthRevenue() {
		return thisMonthRevenue;
	}

	public void setThisMonthRevenue(float thisMonthRevenue) {
		this.thisMonthRevenue = thisMonthRevenue;
	}

	public float getGrowthRatePercentage() {
		return growthRatePercentage;
	}

	public void setGrowthRatePercentage(float growthRatePercentage) {
		this.growthRatePercentage = growthRatePercentage;
	}

	public float getAllTimeRevenue() {
		return allTimeRevenue;
	}

	public void setAllTimeRevenue(float allTimeRevenue) {
		this.allTimeRevenue = allTimeRevenue;
	}

}
