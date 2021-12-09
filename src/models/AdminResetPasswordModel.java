package models;

public class AdminResetPasswordModel {
	private String recoveryCode;
	private String newPassword;
	private String rePassword;

	public String getRecoveryCode() {
		return recoveryCode;
	}

	public void setRecoveryCode(String recoveryCode) {
		this.recoveryCode = recoveryCode;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getRePassword() {
		return rePassword;
	}

	public void setRePassword(String rePassword) {
		this.rePassword = rePassword;
	}

	public AdminResetPasswordModel(String recoveryCode, String newPassword, String rePassword) {
		super();
		this.recoveryCode = recoveryCode;
		this.newPassword = newPassword;
		this.rePassword = rePassword;
	}

	public AdminResetPasswordModel() {
		// TODO Auto-generated constructor stub
	}
}
