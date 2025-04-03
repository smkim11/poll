<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Integer num = Integer.valueOf(request.getParameter("num"));

	Question q = new Question();
	Item i = new Item();

	QuestionDao qd = new QuestionDao();
	ItemDao id = new ItemDao();
	
	// 자식 테이블 먼저 삭제 후 부모 테이블 삭제
	id.deleteItem(num);
	qd.deleteQuestion(num);
	
	
	response.sendRedirect("/poll/pollList.jsp");
%>