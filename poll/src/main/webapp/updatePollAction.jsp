<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Integer num = Integer.valueOf(request.getParameter("num"));
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.valueOf(request.getParameter("type"));
	String[] content = request.getParameterValues("content");

	// content 값이 비어있지 않으면 리스트에 추가
	ArrayList<String> contentList = new ArrayList<>();
	for(String c : content){
		if(!c.equals("")){
			contentList.add(c);
		}
	}
	
	Question q = new Question();
	q.setNum(num);
	q.setTitle(title);
	q.setStartdate(startdate);
	q.setEnddate(enddate);
	q.setType(type);
	
	// question 수정
	QuestionDao qd = new QuestionDao();
	qd.updateQuestion(q);
	
	
	ArrayList<Item> itemList = new ArrayList<>();
	int n=1;
	for(String c : contentList){
		Item i = new Item();
		i.setContent(c);
		i.setQnum(num);
		i.setInum(n);
		
		itemList.add(i);
		n++;
	}
	
	// item 삭제
	ItemDao id = new ItemDao();
	id.deleteItem(num);
	
	// item 생성
	for(Item item : itemList){
		id.insertItem(item);
	}
	

	response.sendRedirect("/poll/pollList.jsp");
	
%>