<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<h1>이미지 올리기</h1>
	<form action="/poll/imageBoard/insertImageAction.jsp" method="post" enctype="multipart/form-data">
	<table class="w-50 table table-striped table-bordered table-hover">
		<tr>
			<th>메모</th>
			<td><input type="text" name="memo" /></td>
		</tr>
		<tr>
			<th>이미지</th>
			<td><input type="file" name="imageFile" /></td>
		</tr>
	</table>
	<button type = "submit">이미지 등록</button>
    </form>
</body>
</html>