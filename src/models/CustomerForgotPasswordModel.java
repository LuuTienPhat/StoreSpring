package models;

public class CustomerForgotPasswordModel {
	private String username;
	private String email;
	private String recoveryCode;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}
	public String getRecoveryCode() {
		return recoveryCode;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setRecoveryCode(String recoveryCode) {
		this.recoveryCode = recoveryCode;
	}
}
