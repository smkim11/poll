<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
	int num = Integer.valueOf(request.getParameter("num"));
	int ref = Integer.valueOf(request.getParameter("ref"));
	String pass = request.getParameter("pass");
	
	Board b = new Board();
	b.setNum(num);
	b.setRef(ref);
	b.setPass(pass);
	
	BoardDao bd = new BoardDao();
	bd.deleteBoard(b);
	
	response.sendRedirect("/poll/board/boardList.jsp");
%>