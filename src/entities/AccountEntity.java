package entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name = "Account")
public class AccountEntity {
	@Id
	@Column(name = "admin_id")
	private String id;
	@NotBlank(message = "Không được để trống")
	@Column(name = "username", unique = true)
	private String username;
	@NotBlank(message = "Không được để trống")
	@Column(name = "password")
	private String password;
	@Column(name = "recovery")
	private String recovery;
	
	@OneToOne(mappedBy = "account", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
	private AdminEntity admin;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRecovery() {
		return recovery;
	}
	public void setRecovery(String recovery) {
		this.recovery = recovery;
	}
	
	public AdminEntity getAdmin() {
		return admin;
	}
	public void setAdmin(AdminEntity admin) {
		this.admin = admin;
	}
	public AccountEntity() {
		// TODO Auto-generated constructor stub
		super();
	}
	
}