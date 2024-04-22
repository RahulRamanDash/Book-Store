package com.java.store;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.Part;
import java.io.*;
import java.util.Map;

@ManagedBean
@RequestScoped
public class FileUploadBean {
    private Part file;
    private String message;
    private String filePath;
    private String filePathNew;
    
    public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Part getFile() {
        return file;
    }

    public void setFile(Part file) {
        this.file = file;
    }
    public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

    public void upload(Part file) {
    	Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
    	
        if (file != null) {
            try (InputStream input = file.getInputStream()) {
                String fileName = getSubmittedFileName(file);
                filePathNew = "D:/DailyTask - Project/BookStoreV1/src/main/webapp/admin/uploads/" + fileName;
                filePath = "/admin/uploads/" + fileName;
                try (OutputStream output = new FileOutputStream(new File(filePathNew))) {
                    int bytesRead;
                    final byte[] CHUNK = new byte[1024];

                    while ((bytesRead = input.read(CHUNK)) != -1) {
                        output.write(CHUNK, 0, bytesRead);
                    }
                }
                System.out.println("Upload done in "+filePath);
                sessionValue.put("imgPath", filePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
        	System.out.println("File is Empty");        	
        }
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                fileName =  fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
                fileName = fileName.replace(" ", "_");
                return fileName;
            }
        }
        return null;
    }
    
}
