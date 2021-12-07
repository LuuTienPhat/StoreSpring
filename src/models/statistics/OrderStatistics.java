package models.statistics;

import java.util.Date;

public class OrderStatistics {
	private Date date;
	private int number;

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public OrderStatistics() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderStatistics(Date month, int number) {
		super();
		this.date = month;
		this.number = number;
	}

}
