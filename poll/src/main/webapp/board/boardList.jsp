<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.valueOf(request.getParameter("currentPage"));
	}
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
	
	BoardDao boardDao = new BoardDao();
	ArrayList<Board> list = boardDao.selectBoardList(p);
	int totalRow = boardDao.totalBoard();
	int lastPage = p.getLastPage(totalRow);
%>
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div><br>
	<h1>게시판</h1>
	<div>
	
	</div>
	<!-- boardList table... -->
	<table class="w-75 table table-striped table-bordered table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>이름</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
			<%
				for(Board b : list){
			%>
					<tr>
						<td><%=b.getNum() %></td>
						<td>
							<%
								for(int i=0; i<=b.getDepth(); i++){
							%>
										&nbsp;&nbsp;&nbsp;
							<% 
								}
							%>
							<a href="/poll/board/boardOne.jsp?num=<%=b.getNum() %>">
								<%=b.getSubject() %>
							</a>
						</td>
						<td><%=b.getName() %></td>
						<td><%=b.getRegdate() %></td>
						<td><%=b.getCount() %></td>
					</tr>
			<% 
				}
			%>
	</table>
	<%
		if(currentPage > 1){
	%>
			<a href="/poll/board/boardList.jsp?currentPage=1">[처음]</a>
			<a href="/poll/board/boardList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
	<% 
		}
	%>
	<%=currentPage %>/<%=lastPage %>
	<%
		if(currentPage<lastPage){
	%>
			<a href="/poll/board/boardList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
			<a href="/poll/board/boardList.jsp?currentPage=<%=lastPage%>">[마지막]</a>
	<% 
		}
	%>
</body>
</html>