<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import ="dto.*" %>
<%
	int num = Integer.valueOf(request.getParameter("num"));
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	BoardDao bd = new BoardDao();
	
	Board b = new Board();
	b.setNum(num);
	b.setName(name);
	b.setSubject(subject);
	b.setContent(content);
	
	bd.updateBoard(b);
	
	response.sendRedirect("/poll/board/boardOne.jsp?num="+num);
%>
