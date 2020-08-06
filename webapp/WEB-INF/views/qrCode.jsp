<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Eventually by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${cPath}/resources/assets/css/main.css" /> 
	</head>
	<body class="is-preload">
		<header id="header">
			<h1>HnJ ERP</h1>
			<h2>로그인</h2>
		</header>
		<form id="signup-form" method="post" action="${cPath }/qrCode">
			<input type="text" name="emp_no" id="emp_no" placeholder="사원 아이디" />
			<input type="password" name="emp_pass" id="emp_pass" placeholder="비밀번호" />
			<input type="submit" value="로그인" />
			<a href="${cPath}/loginForm/passWordSearch">비밀번호 찾기</a>
		</form>

		<script src="${cPath}/resources/assets/js/main.js"></script>
	</body>
</html>

