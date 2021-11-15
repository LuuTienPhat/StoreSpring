package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Image")
public class ImageEntity {
	@Id
	@Column(name = "id")
	@GeneratedValue
	private int id;

	@ManyToOne()
	@JoinColumn(name = "product_id")
	private ProductEntity product;

	@Column(name = "image")
	private String image;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}

	public ImageEntity() {
		// TODO Auto-generated constructor stub
	}
}
