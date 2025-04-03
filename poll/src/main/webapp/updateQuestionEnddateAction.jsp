<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String enddate = request.getParameter("enddate");
	Integer num = Integer.valueOf(request.getParameter("num"));
	
	Question q = new Question();
	q.setEnddate(enddate);
	q.setNum(num);
	
	QuestionDao qd = new QuestionDao();
	qd.updateEnddate(q);
	
	response.sendRedirect("/poll/pollList.jsp");
%>
