<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// controller(1.요청값 분석, 2.모델 호출)
	// 1.요청값 분석
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.valueOf(request.getParameter("type"));
	
	// item.content
	String[] content = request.getParameterValues("content");
	// content들 중 공백요소 제거 후 새로운 배열(contentList)에 저장
	// ex) "a", "b", "c", 
	ArrayList<String> contentList = new ArrayList<>();
	for(String c : content){
		if(!c.equals("")){
			contentList.add(c);
		}
	}
	System.out.println(contentList);
	
	Question question = new Question();
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(type);
		
	// 2. Question 모델(DAO메소드) 호출
	QuestionDao questionDao = new QuestionDao();
	// question값들을 입력하고 pk값을 qnum에 저장
	int qnum = questionDao.insertQuestion(question);
	
	// item값을 저장하기위해 itemList생성 순서대로 inum-1에는 첫번째 content, inum-2에는 두번째 content...
	ArrayList<Item> itemList = new ArrayList<>();
	int i=1;
	for(String c : contentList){
		Item item = new Item();
		item.setContent(c);
		item.setQnum(qnum);
		item.setInum(i);
		
		itemList.add(item);
		i++;
	}

	// 2-1. Item 모델(DAO메소드) 호출
	ItemDao itemDao = new ItemDao();
	// content 개수만큼 추가
	for(Item item : itemList){
		itemDao.insertItem(item);
	}
	
	// view가 필요가 없다 -> 새로운 요청 pollList.jsp
	response.sendRedirect("/poll/pollList.jsp");
%>