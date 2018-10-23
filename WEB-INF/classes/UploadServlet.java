package com.auth;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 2097152, maxFileSize = 10485760L, maxRequestSize = -176L)


public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	private static final String SAVE_DIR = "uploadedFiles";
	private static final String SAVE_DIR_IMAGE = "uploadedPhotos";
	
	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}
	String appName=null,appDescription=null,emailID=null;
	int price=0;
	
	private String getFileNameWithoutExtention(final String fileName){
		final int pos = fileName.lastIndexOf('.');
		if(pos > 0){
			return fileName.substring(0, pos);
		}
		return "";
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		appDescription=request.getParameter("appDescription");
		appName=request.getParameter("appName");
		//Replacing spaces in string with underscores to open app in web browser easily
		appName = appName.replaceAll(" ", "_");
		System.out.println(appName);
		emailID=request.getParameter("emailID");
		System.out.println(appDescription+"123"+emailID);
		price=Integer.parseInt(request.getParameter("price"));
		System.out.println(price);

		// Get absolute path of this running web application
		String appPath = request.getServletContext().getRealPath("");
		// Create path to the directory to save uploaded file
		/* + File.separator + emailID*/;
		final String savePath = appPath + File.separator + SAVE_DIR;
		/*+File.separator+emailID*/;
		final String savePathPhotos = appPath + File.separator + SAVE_DIR_IMAGE;
		// Create the save directory if it does not exist
		// 1. First Make the Upload Directory for WAR files
		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists())
			fileSaveDir.mkdir();
		// 2. Then Make the Upload Directory for email in the fileSaveDir location
		final String savePathEmail = savePath + File.separator+emailID;
		File fileSaveDirEmail = new File(savePathEmail);
		if(!fileSaveDirEmail.exists())
			fileSaveDirEmail.mkdir();
		String fileNameWithExtension=null;
		
		//Writing the war file in $savePath
		final List<Part> fileParts=request.getParts().stream().filter(part ->"file".equals(part.getName())).collect(Collectors.toList());
		for(final Part part2: fileParts){
			final String fileName=this.extractFileName(part2);
			fileNameWithExtension=fileName;
			part2.write(savePathEmail + File.separator + fileName);
			final String jarPath = savePathEmail + File.separator + fileName;
			final String destdir = savePathEmail + File.separator + this.getFileNameWithoutExtention(fileName);
			System.out.println(jarPath);
			System.out.println(destdir);
			//Extract Jar Files
		}
		
		final Part photoPart = request.getPart("appIcon");
		//Image Upload Directory
		File photoSaveDir = new File(savePathPhotos);
		if(!photoSaveDir.exists()){
			photoSaveDir.mkdir();
		}
		final String savePathPhotosEmail = savePathPhotos + File.separator + emailID;
		File fileSavePhotoDirEmail = new File(savePathPhotosEmail);
		if(!fileSavePhotoDirEmail.exists())
			fileSavePhotoDirEmail.mkdir();
		
		String photoName="";
		if(photoPart!=null){
			photoName = this.extractFileName(photoPart);
			photoPart.write(fileSavePhotoDirEmail+File.separator+photoName);
			System.out.println(photoName);
			System.out.println("photos: "+fileSavePhotoDirEmail+File.separator+photoName);
		}
		
		
		System.out.println("files uploaded successfully!");
		
		request.setAttribute("appPath", appPath);
		request.setAttribute("emailID", emailID); //Developer Email
		request.setAttribute("appName", appName); //App Name: to be displayed to users
		request.setAttribute("appDescription", appDescription); //Add Description
		request.setAttribute("photoName", photoName); //Name of the photo with extention
		request.setAttribute("photoPath", savePathPhotosEmail); //Complete path of the image upload directory with the developer's email folder
		System.out.println(fileNameWithExtension);
		request.setAttribute("fileName", fileNameWithExtension);
		request.setAttribute("filePath", savePathEmail/*fileSaveDirEmail*/);
		request.setAttribute("price", price);
		
		request.getRequestDispatcher("AddAppDatabase").forward(request, response);
	}

}
