<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Integer num = Integer.valueOf(request.getParameter("num"));

	
	QuestionDao qd = new QuestionDao();
	ArrayList<Question> list = qd.questionList(num);
	
	ItemDao id = new ItemDao();
	ArrayList<Item> list2 = id.itemList(num);
	
	System.out.println(list2.size());
	System.out.println(list2.get(0).getContent());
	String value="";
	if(list2.size()>=1){
		value=list2.get(0).getContent();
	}else{
		value="";
	}
	System.out.println("Value:"+value);
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
	width: 40%
	}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>설문수정</h1>
	<%
		for(Question question : list){
			
	%>
		<form method="post" action="/poll/updatePollAction.jsp">
			<table border="1">
			<input type="hidden" name="num" value="<%=num%>">
				<tr>
					<td>질문</td>
					<td colspan="2">
						<input type="text" name="title" value="<%=question.getTitle()%>">
					</td>
				</tr>
		
				<tr>
					<td rowspan="8">항목</td>
					<td>1:<input type="text" name="content" value="<% if (list2.size() >= 1) { %><%= list2.get(0).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>2:<input type="text" name="content" value="<% if (list2.size() >= 2) { %><%= list2.get(1).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
				<tr>
					<td>3:<input type="text" name="content" value="<% if (list2.size() >= 3) { %><%= list2.get(2).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>4:<input type="text" name="content" value="<% if (list2.size() >= 4) { %><%= list2.get(3).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
				<tr>
					<td>5:<input type="text" name="content" value="<% if (list2.size() >= 5) { %><%= list2.get(4).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>6:<input type="text" name="content" value="<% if (list2.size() >= 6) { %><%= list2.get(5).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
				<tr>
					<td>7:<input type="text" name="content" value="<% if (list2.size() >= 7) { %><%= list2.get(6).getContent() %><% } else { %><%="" %><% } %>"></td>
					<td>8:<input type="text" name="content" value="<% if (list2.size() >= 8) { %><%= list2.get(7).getContent() %><% } else { %><%="" %><% } %>"></td>
				</tr>
		
				<tr>
					<td>시작일</td>
					<td><input type="date" name="startdate" value="<%=question.getStartdate()%>"></td>
				</tr>
				<tr>
					<td>종료일</td>
					<td><input type="date" name="enddate" value="<%=question.getEnddate()%>"></td>
				</tr>
				<tr>
					<td>복수투표</td>
					<td>
						<%
							if(question.getType()==1){
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
	<%
		}
	%>
</body>
</html>