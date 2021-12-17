package entities;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Category")
public class CategoryEntity {
	@Id
	@Column(name = "id", updatable = false)
	private String id;
	@Column(name = "name")
	private String name;
	@Column(name = "image")
	private String image;
	@Temporal(TemporalType.DATE)
	@Column(name = "date_added", updatable = false)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date dateAdded;
	@Column(name = "description")
	private String description;

	@OneToMany(mappedBy = "category", cascade = CascadeType.PERSIST, fetch = FetchType.EAGER)
	private List<ProductEntity> products;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<ProductEntity> getProducts() {
		return products;
	}

	public void setProducts(List<ProductEntity> products) {
		this.products = products;
	}

	public CategoryEntity() {
		super();
	}

	public Date getDateAdded() {
		return dateAdded;
	}

	public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
	}
}
