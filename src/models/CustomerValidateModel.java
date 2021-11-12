package models;

import java.util.Date;

import javax.persistence.Column;

public class CustomerValidateModel {
	private String id;
	private String username;
	private String password;
	private String confirmPassword;
	private String firstName;
	private String lastName;
	private String telephone;
	private String city;
//	private String dateofbirth;
	private String district;
	private String commune;
	private String specificAddress;
	private String address;
	private String email;
	
	private String fullAddress;
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
//	public String getDateofbirth() {
//		return dateofbirth;
//	}
//	public void setDateofbirth(String dateofbirth) {
//		this.dateofbirth = dateofbirth;
//	}
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
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getSpecificAddress() {
		return specificAddress;
	}
	public void setSpecificAddress(String specificAddress) {
		this.specificAddress = specificAddress;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCommune() {
		return commune;
	}
	public void setCommune(String commune) {
		this.commune = commune;
	}
	public String getFullAddress() {
		return fullAddress;
	}
	public void setFullAddress(String fullAddress) {
		this.fullAddress = fullAddress;
	}
	
}
