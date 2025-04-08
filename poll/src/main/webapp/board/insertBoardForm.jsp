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
	
	table{
	margin:auto;
	width: 40%
	}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body class="container">
<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div><br>
	<h1>글입력</h1>
	<form method="post" action="/poll/board/insertBoardAction.jsp">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<td>name</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>subject</td>
				<td><input type="text" name="subject"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><textarea name="content" rows="5" cols="50"></textarea></td>
			</tr>
			<tr>
				<td>pass</td>
				<td><input type="password" name="pass"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-outline-primary">입력</button>
	</form>
</body>
</html>