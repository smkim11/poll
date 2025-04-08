<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="model.*" %>
<%@ page import ="dto.*" %>
<%
	int ref = Integer.valueOf(request.getParameter("ref"));
	int pos = Integer.valueOf(request.getParameter("pos"));
	int depth = Integer.valueOf(request.getParameter("depth"));
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	
	Board b = new Board();
	b.setRef(ref);
	b.setPos(pos);
	b.setDepth(depth);
	b.setName(name);
	b.setSubject(subject);
	b.setContent(content);
	b.setPass(pass);
	b.setIp(request.getRemoteAddr()); // IP받아오는 API(다른 API를 이용하여 IP를 구하는 경우가 많음)

	// logging(디버깅)
	System.out.println(b.toString()); // System.out.println(board);
 	
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoardReply(b);
	
	response.sendRedirect("/poll/board/boardList.jsp");
		
%>