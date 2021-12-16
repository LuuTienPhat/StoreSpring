package models.dao;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;

@Transactional
public abstract class DAO{
	protected SessionFactory factory;

	public DAO(SessionFactory factory) {
		this.factory = factory;
	}

	public SessionFactory getFactory() {
		return factory;
	}

	public void setFactory(SessionFactory factory) {
		this.factory = factory;
	}
}
