<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	int num = Integer.valueOf(request.getParameter("num"));

	BoardDao bd = new BoardDao();
	Board b = bd.selectBoardOne(num);
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
	<h1>글 수정</h1>
	<form action="/poll/board/updateBoardReplyAction.jsp">
	<table class="w-50 table table-striped table-bordered table-hover">
	<input type="hidden" name="num" value="<%=b.getNum()%>">
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" value="<%=b.getName()%>"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="subject" value="<%=b.getSubject()%>"></td>
		</tr>
		<tr>
			<td>글</td>
			<td><textarea name="content" rows="5" cols="50"><%=b.getContent()%></textarea></td>
		</tr>
	</table>
	<button type="submit">수정</button>
	</form>
</body>
</html>