package models;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.ResolverStyle;

public class DateTimeValidator {
	private static DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("uuuu-MM-dd");
	private static DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

	public static boolean isDateValid(String dateString, String dateFormat) {
		try {
			LocalDate.parse(dateString,
					DateTimeFormatter.ofPattern(dateFormat).withResolverStyle(ResolverStyle.STRICT));
			return true;
		} catch (DateTimeParseException e) {
			e.printStackTrace();
			return false;
		}
	}

	public static boolean isTimeValid(String timeString, String timeFormat) {
		try {
			LocalTime.parse(timeString,
					DateTimeFormatter.ofPattern(timeFormat).withResolverStyle(ResolverStyle.STRICT));
			return true;
		} catch (DateTimeParseException e) {
			e.printStackTrace();
			return false;
		}
	}

	public static boolean isDateValid(String dateString) {
		try {
			LocalDate.parse(dateString, dateFormatter.withResolverStyle(ResolverStyle.STRICT));
			return true;
		} catch (DateTimeParseException e) {
			e.printStackTrace();
			return false;
		}
	}

	public static boolean isTimeValid(String timeString) {
		try {
			LocalTime.parse(timeString, timeFormatter.withResolverStyle(ResolverStyle.STRICT));
			return true;
		} catch (DateTimeParseException e) {
			e.printStackTrace();
			return false;
		}
	}

	/*
	 * public static void main(String[] args) { if (isTimeValid("01:32:12",
	 * "HH:mm:ss")) { System.out.println("true"); } if (isDateValid("2021-01-01",
	 * "uuuu-MM-dd")) { System.out.println("true"); } }
	 */
}
