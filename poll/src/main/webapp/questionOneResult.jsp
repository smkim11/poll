<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// Controller : request 분석, model 호출
	int num = Integer.valueOf(request.getParameter("num"));

	//1) qnum에 해당하는 질문
	QuestionDao qd = new QuestionDao();
	Question q = qd.selectQuestionOne(num);
	// 2) 1)의 items
	ItemDao id = new ItemDao();
	ArrayList<Item> list = id.itemList(num);
	// 3) 총투표수
	int totalCount = id.selectItemCountByQnum(num);
%>



<!-- View -->
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
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
<body>
	
	<h1><%=num %>번 설문 투표결과</h1>
	<table class="table table-striped table-bordered table-hover">
		<tr>
			<td colspan="4">
				Q : <%=q.getTitle() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				총 투표수 : <%=totalCount %>
			</td>
		</tr>
		<tr>
			<td>번호</td><td>내용</td><td>카운트(차트)</td><td>카운트</td>
		</tr>
		<%
			for(Item i : list){
		%>
				<tr>
					<td><%=i.getInum() %></td>
					<td><%=i.getContent() %></td>
					<td>
						<!-- 각 count값에 대한 백분율 값 -->
						<% 
							int percentage = (int)(Math.round((double)i.getCount() / (double)totalCount *100));
							
							for(int n=1;n<=percentage; n++){
						%>
								*
						<% 
							}
						%>
					</td>
					<td><%=i.getCount() %></td>
				</tr>
		<% 
			}
		%>
	</table>
</body>
</html>