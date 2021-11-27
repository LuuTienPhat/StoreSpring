package models.validator;

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
	 * public static String getlastDayOfMonth(LocalDate date) {
	 * 
	 * }
	 * 
	 * public static String getfirstDayOfMonth(LocalDate date) {
	 * 
	 * }
	 */
	 
}
