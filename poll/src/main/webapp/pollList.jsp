<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
	
	Item i = new Item();
	
	ItemDao id = new ItemDao();
	
	// 오늘 날짜
	LocalDate today = LocalDate.now();
	
	System.out.println(today);
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
	<a href="/poll/insertPollForm.jsp">투표작성하기</a>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>투표</th>
			<th>삭제</th>
			<th>수정</th>
			<th>종료일수정</th>
			<th>결과</th>
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
					<!-- 오늘날짜가 투표기간안에 들어가면 투표하기 링크 표시 -->
					<%
						LocalDate startDate = LocalDate.parse(q.getStartdate(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
						LocalDate endDate = LocalDate.parse(q.getEnddate(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
						if((startDate.isBefore(today) || startDate.isEqual(today))
							&& (endDate.isAfter(today)|| endDate.isEqual(today))){
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
					<td>
					<!-- count값이 0이면 삭제링크 표시 -->
					<%
						i.setQnum(q.getNum());
						if(id.sumCount(i)==0){
					%>
							<a href="/poll/deletePoll.jsp?num=<%=q.getNum()%>">삭제</a>
					<% 
						}else{
					%>
							삭제불가
					<% 
						}
					%>
						
					</td>
					<td>
						<%
							if(id.sumCount(i) == 0){
						%>
								<a href="/poll/updatePollForm.jsp?num=<%=q.getNum()%>">수정</a>
						<% 
							}else{
						%>
								수정불가
						<% 
							}
						%>
						
					</td>
					<td>
					<!-- 종료날짜가 지나지 않았으면 수정 링크 표시 -->
					<%
						if(endDate.isAfter(today)|| endDate.isEqual(today)){
					%>
							<a href="/poll/updateQuestionEnddateForm.jsp?num=<%=q.getNum()%>">종료일수정</a>
					<% 
						}else{
					%>
							수정 불가
					<% 
						}
					%>
						
					</td>
					<td>
					<!-- 종료날짜가 지났으면 링크 표시 -->
					<%
						if(today.isAfter(endDate)){
					%>
							<a href="/poll/pollList.jsp">보기</a>
					<% 
						}else{
					%>
							
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