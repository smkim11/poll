<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// question 테이블 리스트 -> 페이징 -> title링크(startdate<=오늘날짜<=enddate) -> 투표프로그램
	// QuestionDao.selectQuestionList(Paging)
	int currentPage=1;
	if(request.getParameter("currentPage") !=null){
		currentPage = Integer.valueOf(request.getParameter("currentPage"));
	}
	int rowPerPage = 3;
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	int lastPage = paging.getLastPage(questionDao.questionTotalRow());
	
	Calendar c = Calendar.getInstance();
	int todayYear = c.get(Calendar.YEAR);
	int todayMonth = c.get(Calendar.MONTH)+1;
	int todayDate = c.get(Calendar.DATE);
	System.out.println(todayMonth);
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
	width: 50%
	}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>설문리스트</h1>
	<!--  foreach문 ArrayList<Question> list 출력 title
	링크(startdate <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기 -->
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>투표</th>
		</tr>
		<%
			for(Question q : list){
				
		%>
				<tr>
					<td><%=q.getNum() %></td>
					<td><%=q.getTitle() %></td>
					<td><%=q.getStartdate() %></td>
					<td><%=q.getEnddate() %></td>
					<td>
					<%
						if((Integer.valueOf(q.getStartdate().substring(0,4))<=todayYear 
						&& Integer.valueOf(q.getStartdate().substring(5,7))<=todayMonth
						&& Integer.valueOf(q.getStartdate().substring(8))<=todayDate) ||
						 (todayYear<=Integer.valueOf(q.getEnddate().substring(0,4))
						&&todayMonth<=Integer.valueOf(q.getEnddate().substring(5,7))
						&&todayDate<=Integer.valueOf(q.getEnddate().substring(8)))){
					%>
							<a href="/poll/pollList.jsp">투표하기</a>
					<% 
						}else{
					%>
							투표기간X
					<% 
						}
					%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	<%
		if(currentPage>1){
	%>
			<a href="/poll/pollList.jsp?currentPage=1">[처음]</a>
			<a href="/poll/pollList.jsp?currentPage=<%=currentPage-1 %>">[이전]</a>
	<% 
		}
	%>
	<%
		if(currentPage<lastPage){
	%>
			<a href="/poll/pollList.jsp?currentPage=<%=currentPage+1 %>">[다음]</a>
			<a href="/poll/pollList.jsp?currentPage=<%=lastPage%>">[마지막]]</a>
	<% 
		}
	%>
	
</body>
</html>