package entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Category")
public class CategoryEntity {
	@Id
	private String id;
	@Column(name = "name")
	private String name;
	@Column(name = "image")
	private String image;
	@Column(name = "description")
	private String description;

	@OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<ProductEntitiy> products;

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

	public List<ProductEntitiy> getProducts() {
		return products;
	}

	public void setProducts(List<ProductEntitiy> products) {
		this.products = products;
	}

	public CategoryEntity(String id, String name, String image, String description, List<ProductEntitiy> products) {
		super();
		this.id = id;
		this.name = name;
		this.image = image;
		this.description = description;
		this.products = products;
	}

	public CategoryEntity() {
		super();
	}
		
}
