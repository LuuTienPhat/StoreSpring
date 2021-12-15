package models.validator;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.ResolverStyle;
import java.util.Date;

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

	public static LocalDateTime convertToLocalDateTimeViaInstant(Date dateToConvert) {
		return dateToConvert.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
	}

	public static LocalDate convertToLocalDateViaInstant(Date dateToConvert) {
		return dateToConvert.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	}

	public static LocalDate convertToLocalDate(String dateToConvert) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate date = LocalDate.parse(dateToConvert, formatter);
		return date;
	}
}
