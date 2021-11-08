package models;

import java.util.Arrays;
import java.util.Date;

public class OrderModel {
	private String id;
	private String customerId;
	private float orderTotal;
	private Date orderDate;
	private Date shippedDate;
	private String shipName;
	private String shipPhone;
	private String shipEmail;
	private String shipAddress;
	private String shipCity;
	private int state;
	private String[] productIds;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public float getOrderTotal() {
		return orderTotal;
	}
	public void setOrderTotal(float orderTotal) {
		this.orderTotal = orderTotal;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public Date getShippedDate() {
		return shippedDate;
	}
	public void setShippedDate(Date shippedDate) {
		this.shippedDate = shippedDate;
	}
	public String getShipName() {
		return shipName;
	}
	public void setShipName(String shipName) {
		this.shipName = shipName;
	}
	public String getShipPhone() {
		return shipPhone;
	}
	public void setShipPhone(String shipPhone) {
		this.shipPhone = shipPhone;
	}
	public String getShipAddress() {
		return shipAddress;
	}
	public void setShipAddress(String shipAddress) {
		this.shipAddress = shipAddress;
	}
	public String getShipCity() {
		return shipCity;
	}
	public void setShipCity(String shipCity) {
		this.shipCity = shipCity;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String[] getProductIds() {
		return productIds;
	}
	public String shipNote;
	public void setProductIds(String[] productIds) {
		this.productIds = productIds;
	}

	@Override
	public String toString() {
		return "OrderModel [id=" + id + ", customerId=" + customerId + ", orderTotal=" + orderTotal + ", orderDate="
				+ orderDate + ", shippedDate=" + shippedDate + ", shipName=" + shipName + ", shipPhone=" + shipPhone
				+ ", shipEmail=" + shipEmail + ", shipAddress=" + shipAddress + ", shipCity=" + shipCity + ", state="
				+ state + ", productIds=" + Arrays.toString(productIds) + ", shipNote=" + shipNote + "]";
	}
	public String getShipEmail() {
		return shipEmail;
	}
	public void setShipEmail(String shipEmail) {
		this.shipEmail = shipEmail;
	}
	public String getShipNote() {
		return shipNote;
	}
	public void setShipNote(String shipNote) {
		this.shipNote = shipNote;
	}
	
}
