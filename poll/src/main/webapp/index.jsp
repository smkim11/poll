<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div><br>
	<h1>Index</h1>
	<ul style="display: table;margin: auto">
		<li>
			<a href="/poll/pollList.jsp">투표(설문)</a>
		</li>
		<li>
			<a href="/poll/board/boardList.jsp">계층형 게시판</a>
		</li>
	</ul>
</body>
</html>