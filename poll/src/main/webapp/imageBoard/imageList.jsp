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
	p.setRowPerPage(3);
	
	ImageDao id = new ImageDao();
	ArrayList<Image> list = id.selectImageList(p);
	
	int totalCount = id.totalCount();
	int lastPage = p.getLastPage(totalCount);
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
	<h1>이미지 게시판</h1>
	<%
		for(Image i : list){
	%>
			<table class="w-75 table table-striped table-bordered table-hover">
				<tr>
					<td><%=i.getMemo() %></td>
				</tr>
				<tr>
					<td>
						<img src="/poll/upload/<%=i.getFilename() %>">
					</td>
				</tr>
				<tr>
					<td>
						<a href="/poll/imageBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFilename()%>">삭제</a>
					</td>
				</tr>
			</table>
			<hr>
	<% 
		}
	%>
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