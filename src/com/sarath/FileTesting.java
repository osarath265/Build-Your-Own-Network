package com.sarath;

import java.io.File;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@WebServlet(urlPatterns ="/filetest", name = "FileTesting")

public class FileTesting extends HttpServlet{
   
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException
	{
		
		try
		{
		ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
	    List<FileItem> mutiple = sf.parseRequest(req);
	    for(FileItem item:mutiple)
	    {
	    	String imgloc ="C:\\Users\\sarath\\Documents\\Uploadedimages\\"+ item.getName();
	    	item.write(new File("C:\\Users\\sarath\\Documents\\Uploadedimages\\"+ item.getName()));
	    	System.out.println("upload successful");
	    	HttpSession session = req.getSession();
			session.setAttribute("imgloc",imgloc);
			res.sendRedirect("home.jsp");
	    }
		}
		catch(Exception e)
		{
			System.out.println("Exceptin occured" + e);
			
		}
	    
			
	}
}
