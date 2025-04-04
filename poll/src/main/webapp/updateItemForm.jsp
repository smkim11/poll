<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// ?번 문제와 아이템들 출력
	// type=1 아이템의 타입을 checkbox (중복투표 O)
	// type=0 아이템의 타입을 radio    (중복투표 X)
	
	// Controller Layer (request분석 + Model Layer 호출/반환)
	int num = Integer.valueOf(request.getParameter("num"));
	// 1) qnum에 해당하는 질문
	QuestionDao qd = new QuestionDao();
	Question q = qd.selectQuestionOne(num);
	// 2) 1)의 items
	ItemDao id = new ItemDao();
	ArrayList<Item> list = id.itemList(num);
%>

<!-- View Layer -->
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
	<h1>투표하기</h1>
	<form action="/poll/updateItemAction.jsp" method="post">
	<table border="1">
	<input type="hidden" name="num" value="<%=num%>">
		<tr>
			<td>
				Q: <%=q.getTitle() %>
				(<%=q.getType() == 1 ? "복수투표가능" : "복수투표불가" %>)
			</td>
		</tr>
		<tr>
			<td>
				<%
					for(Item i : list){
				%>
						<div>
							<%
								if(q.getType() ==0){ // type = radio (중복투표 X)
							%>
									<input type="radio" name="ck" value="<%=i.getInum() %>">
							<% 		
								}else{ // type = checkbox (중복투표 O)
							%>
									<input type="checkbox" name="ck" value="<%=i.getInum() %>">
							<% 		
								}
							%>
							<%=i.getContent() %>
						</div>
				<% 
					}
				%>
			</td>
		</tr>
	</table>
	<button type="submit">투표</button>
	</form>
</body>
</html>