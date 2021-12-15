package models.validator;

public class InputValidator {
	public static Boolean isInputValid(String input) {
		if(input == null) return false;
		input = input.trim();
		if (input.isEmpty())
			return false;
		return true;
	}

	public static Boolean isInputNumberValid(String input) {
		input = input.trim();
		if (input.isEmpty()) {
			return false;
		} else if (Integer.parseInt(input) < 0) {
			return false;
		}
		return true;
	}

	public static Boolean isPhoneValid(String phone) {
		phone = phone.trim();
		if (phone.isEmpty())
			return false;
		String regex = "(([03+[2-9]|05+[6|8|9]|07+[0|6|7|8|9]|08+[1-9]|09+[1-4|6-9]]){3})+[0-9]{7}\\b";
		return phone.matches(regex);
	}

	public static Boolean isEmailValid(String email) {
		email = email.trim();
		if (email.isEmpty())
			return false;
		String regex = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
		return email.matches(regex);
	}

	public static Boolean isFirstnameValid(String firstname) {
		firstname = firstname.trim();
		if (firstname.isEmpty())
			return false;
		String[] a = firstname.split(" ");
		return a.length == 1 ? true : false;
	}

	public static Boolean isGenderValid(String gender) {
		gender = gender.trim();
		if (gender.isEmpty())
			return false;
		if (!gender.equals("0") && !gender.equals("1"))
			return false;
		return true;
	}
}
