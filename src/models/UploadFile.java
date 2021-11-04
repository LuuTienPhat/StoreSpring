package models;

public class UploadFile {
	private String basePath;
	
	public String getBasePath() {
		return basePath;
	}

	public void setBasePath(String basePath) {
		this.basePath = basePath;
	}
	
	public static String getExtension(String path) {
	    int lastIndexOf = path.lastIndexOf(".");
	    if (lastIndexOf == -1) {
	        return ""; // empty extension
	    }
	    return path.substring(lastIndexOf);
	}
	
	public static String getCategoryBasePath() {
	    return "resources/upload/categories/";
	}
	
	public static String getProductBasePath() {
	    return "resources/upload/products/";
	}
	
	public static String getProjectPath() {
	    return "D:/eclipse-workspace/StoreSpring/";
	}
	
	public static String getResourcePath() {
	    return "D:/eclipse-workspace/StoreSpring/";
	}
	
	public static String getUploadPath() {
	    return "D:/eclipse-workspace/StoreSpring/";
	}
}
