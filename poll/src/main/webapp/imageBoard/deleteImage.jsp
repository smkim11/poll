<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ImageDao" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	int num = Integer.valueOf(request.getParameter("num"));
	String filename = request.getParameter("filename");
	
	// db 삭제
	ImageDao id = new ImageDao();
	id.deleteImage(num);
	
	// 파일 삭제
	String path = request.getServletContext().getRealPath("upload");
	File file = new File(path,filename); // new File 경로에 파일이 없으면 빈파일 생성
	if(file.exists()){ // 빈파일 아니라면
		file.delete(); // 삭제
	}

	response.sendRedirect("/poll/imageBoard/imageList.jsp");
%>