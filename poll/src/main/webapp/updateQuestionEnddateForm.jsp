<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Integer num = Integer.valueOf(request.getParameter("num"));

	Question q = new Question();
	QuestionDao qd = new QuestionDao();
	ArrayList<Question> list = qd.questionList(num);
%>
<!DOCTYPE html>
<html>
<head>
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
<h1>종료일수정</h1>
<form method = "post" action="/poll/updateQuestionEnddateAction.jsp">
<table border="1">

	<%
		for(Question question : list){
	%>
			<tr>
				<input type="hidden" name="num" value="<%=num%>">
				<td>종료일</td>
				<td><input type="date" name="enddate" value="<%=question.getEnddate()%>"></td>
			</tr>
	<% 
		}
	%>
</table>
<button type="submit">수정</button>
</form>		
</body>
</html>