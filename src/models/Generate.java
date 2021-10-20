package models;

import java.util.Random;

public class Generate {
	
	public static String generateProductId(int targetStringLength) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 57; // letter '9'
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength - 1)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

		return "P" + generatedString;
	}
	
	public static String generateImageId(int targetStringLength) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 57; // letter '9'
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength - 1)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

		return "I" + generatedString;
	}
}
