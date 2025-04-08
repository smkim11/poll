<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	int num = Integer.valueOf(request.getParameter("num"));

	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
	
	// 조회수 증가
	boardDao.upCount(num);
%>
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	body{
	text-align:center
	}
	
	table{
	margin:auto;
	width: 40%
	}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div><br>
	<h1>상세보기</h1>
	<table class="w-75 table table-striped table-bordered table-hover">
		<tr>
			<td>번호</td>
			<td><%=b.getNum() %></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=b.getName() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=b.getSubject() %></td>
		</tr>
		<tr>
			<td>글</td>
			<td><%=b.getContent() %></td>
		</tr>
		<tr>
			<td>pos, ref, depth</td>
			<td><%=b.getPos() %>, <%=b.getRef() %>, <%=b.getDepth() %></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=b.getRegdate() %></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=b.getCount() %></td>
		</tr>
	</table>
	<a href="/poll/board/updateBoardReplyForm.jsp?num=<%=b.getNum()%>">수정</a>
	<a href="/poll/board/deleteBoardForm.jsp?num=<%=b.getNum()%>&ref=<%=b.getRef()%>">삭제</a>
	<a href="/poll/board/insertBoardReplyForm.jsp?ref=<%=b.getRef() %>&pos=<%=b.getPos()%>&depth=<%=b.getDepth()%>">답글</a>
</body>
</html>