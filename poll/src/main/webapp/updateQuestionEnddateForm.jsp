<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Integer num = Integer.valueOf(request.getParameter("num"));

	Question q = new Question();
	QuestionDao qd = new QuestionDao();
	q = qd.selectQuestionOne(num);
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
	width: auto
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
<h1>종료일수정</h1>
<form method = "post" action="/poll/updateQuestionEnddateAction.jsp">
	<table class="w-50 table table-striped table-bordered table-hover">
		<tr>
			<input type="hidden" name="num" value="<%=num%>">
			<td>종료일</td>
			<td><input type="date" name="enddate" value="<%=q.getEnddate()%>"></td>
		</tr>
	</table>
	<button type="submit">수정</button>
</form>		
</body>
</html>