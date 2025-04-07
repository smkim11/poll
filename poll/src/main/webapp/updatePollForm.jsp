<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Integer num = Integer.valueOf(request.getParameter("num"));

	
	QuestionDao qd = new QuestionDao();
	Question q = qd.selectQuestionOne(num);
	
	ItemDao id = new ItemDao();
	ArrayList<Item> list = id.itemList(num);
	
	System.out.println(list.size());
	System.out.println(list.get(0).getContent());
	String value="";
	if(list.size()>=1){
		value=list.get(0).getContent();
	}else{
		value="";
	}
	System.out.println("Value:"+value);
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
	<h1>설문수정</h1>
		<form method="post" action="/poll/updatePollAction.jsp">
			<table class="table table-striped table-bordered table-hover">
			<input type="hidden" name="num" value="<%=num%>">
				<tr>
					<td>질문</td>
					<td colspan="2">
						<input type="text" name="title" value="<%=q.getTitle()%>">
					</td>
				</tr>
				
				<tr>
					<td rowspan="8">항목</td>
					<td>1:<input type="text" name="content" value="<% if (list.size() >= 1) { %><%= list.get(0).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>2:<input type="text" name="content" value="<% if (list.size() >= 2) { %><%= list.get(1).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
				<tr>
					<td>3:<input type="text" name="content" value="<% if (list.size() >= 3) { %><%= list.get(2).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>4:<input type="text" name="content" value="<% if (list.size() >= 4) { %><%= list.get(3).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
				<tr>
					<td>5:<input type="text" name="content" value="<% if (list.size() >= 5) { %><%= list.get(4).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>6:<input type="text" name="content" value="<% if (list.size() >= 6) { %><%= list.get(5).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
				<tr>
					<td>7:<input type="text" name="content" value="<% if (list.size() >= 7) { %><%= list.get(6).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>8:<input type="text" name="content" value="<% if (list.size() >= 8) { %><%= list.get(7).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
		
				<tr>
					<td>시작일</td>
					<td><input type="date" name="startdate" value="<%=q.getStartdate()%>"></td>
				</tr>
				<tr>
					<td>종료일</td>
					<td><input type="date" name="enddate" value="<%=q.getEnddate()%>"></td>
				</tr>
				<tr>
					<td>복수투표</td>
					<td>
						<%
							if(q.getType()==1){
						%>
								<input type="radio" name="type" value="1" checked >yes
								<input type="radio" name="type" value="0">no
								
						<% 
							}else{
						%>
								<input type="radio" name="type" value="1" >yes
								<input type="radio" name="type" value="0" checked>no
						<% 	
							}
						%>
					</td>
				</tr>
			</table>
			<button type="submit">수정하기</button>
		</form>
</body>
</html>