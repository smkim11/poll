<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!--  View 존재하지 않는 프로세스: JSP일 필요가 없다 -> 다른요청이 필요하다
	 -> Backend(Server)에서 요청불가-> 브라우저에 요청 강제화 -->
<%
	int num = Integer.valueOf(request.getParameter("num"));
	String[] inumArr = request.getParameterValues("ck");
	//inumArr 개수만큼 count++ 하는 메소드 호출
	ItemDao id = new ItemDao();
	for(String inum : inumArr){
		id.updateItemCountPlus(Integer.valueOf(inum),num);
	}
	response.sendRedirect("/poll/pollList.jsp");
%>