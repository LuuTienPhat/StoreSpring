package models.statistics;

import java.util.Date;

public class Revenue {
	private Date date;
	private float money;

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}

	public Revenue(Date date, float money) {
		super();
		this.date = date;
		this.money = money;
	}

	public Revenue() {
		// TODO Auto-generated constructor stub
	}
}
