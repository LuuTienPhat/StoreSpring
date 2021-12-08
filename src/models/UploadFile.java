package models;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.web.multipart.MultipartFile;

public class UploadFile {
	private String uploadServerPath;
	private String uploadResourcePath;

	// GET ABSOLUTE PATH OF RESOURCE UPLOAD FOLDER ON METADATA
	public String getUploadPathOnServer(ServletContext context) {
		return context.getRealPath("resources/uploads/");
	}

	// GET ABSOLUTE PATH OF RESOURCE UPLOAD FOLDER
	public String getUploadPath() {
		return uploadResourcePath;
	}

	// GET RELATIVE PATH OF RESOURCE UPLOAD FOLDER
	public String getRelativeUploadPath() {
		return "resources/uploads/";
	}

	public void setUploadResourcePathOnServer(ServletContext context) {
		this.uploadServerPath = context.getRealPath("resources/uploads/");
	}

	public void setUploadResourcePath(String uploadResourcePath) {
		this.uploadResourcePath = uploadResourcePath;
	}

	// GET FILE EXTENSION
	public static String getExtension(String path) {
		try {
			int lastIndexOf = path.lastIndexOf(".");
			if (lastIndexOf == -1) {
				return ""; // empty extension
			}
			return path.substring(lastIndexOf);
		}
		catch (Exception e) {
			// TODO: handle exception
			return "jpg";
		}
	}

	// WRITE FILE
	public static void writeFile(File file, MultipartFile image) throws IOException {
		BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(file), 99999999);
		stream.write(image.getBytes());
		stream.close();
	}

	// DELETE DIRECTORY HAS CONTENTS
	public static boolean deleteDirectory(File dir) {
		if (dir.isDirectory()) {
			File[] children = dir.listFiles();
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDirectory(children[i]);
				if (!success) {
					return false;
				}
			}
		}
		// either file or an empty directory
		System.out.println("removing file or directory : " + dir.getName());
		return dir.delete();
	}
}
