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
	
	// question테이블의 정보와 item테이블의 qnum별 투표수 총합을 list에 저장
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = questionDao.selectQuestionList(paging);
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
	<h1>설문리스트</h1><br>
	<!--  foreach문 ArrayList<Question> list 출력 title
	링크(startdate <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기 -->
	<table class="table table-striped table-bordered table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>복수투표</th>
			<th>참여횟수</th>
			<th>투표</th>
			<th>삭제</th>
			<th>수정</th>
			<th>종료일수정</th>
			<th>결과</th>
		</tr>
		<%
			
			for(HashMap<String,Object> map : list){
		%>
				<tr>
					<td><%=map.get("num") %></td>
					<td><%=map.get("title") %></td>
					<td><%=map.get("startdate") %></td>
					<td><%=map.get("enddate") %></td>
					<td>
						<%
							if((Integer)map.get("type")==0){
						%>
								불가능
						<% 
							}else{
						%>	
								가능
						<% 
							}
						%>
					</td>
					<td><%=map.get("cnt") %>번</td>
					<td>
					<!-- 오늘날짜가 투표기간안에 들어가면 투표하기 링크 표시 -->
					<%
						LocalDate startDate = LocalDate.parse((String)(map.get("startdate")), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
						LocalDate endDate = LocalDate.parse((String)(map.get("enddate")), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
						if(today.compareTo(startDate) < 0){
					%>
							투표전
					<% 
						}else if(today.compareTo(endDate)>0){
					%>
							투표종료
					<% 
						}else{
					%>
							<a href="/poll/updateItemForm.jsp?num=<%=map.get("num")%>" class="btn btn-outline-primary">투표하기</a>
					<% 
						}
					%>
					</td>
					<td>
					<!-- count값이 0이면 삭제링크 표시 -->
					<%
						if((Integer)(map.get("cnt"))==0){
					%>
							<a href="/poll/deletePoll.jsp?num=<%=map.get("num")%>" class="btn btn-outline-danger">삭제</a>
					<% 
						}else{
					%>
							삭제불가
					<% 
						}
					%>
						
					</td>
					<td>
					<!-- 참여자가 있거나 투표기간이 지났으면 수정 불가 -->
						<%
							if((Integer)(map.get("cnt")) == 0 
								&& (startDate.isBefore(today) || startDate.isEqual(today))
								&& (endDate.isAfter(today)|| endDate.isEqual(today))){
						%>
								<a href="/poll/updatePollForm.jsp?num=<%=map.get("num")%>" class="btn btn-outline-primary">수정</a>
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
						if(endDate.compareTo(today)>=0){
					%>
							<a href="/poll/updateQuestionEnddateForm.jsp?num=<%=map.get("num")%>" class="btn btn-outline-primary" >종료일수정</a>
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
						if(endDate.compareTo(today)<0){
					%>
							<a href="/poll/questionOneResult.jsp?num=<%=map.get("num")%>" class="btn btn-outline-primary ">보기</a>
					<% 
						}else if(today.compareTo(startDate)<0){
					%>
							투표전
					<% 
						}else{
					%>
							투표진행중
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
			<a href="/poll/pollList.jsp?currentPage=<%=lastPage%>">[마지막]</a>
	<% 
		}
	%>
	
</body>
</html>