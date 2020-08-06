<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Eventually by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Eventually by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${cPath}/resources/assets/css/main.css" /> 
	</head>
	<body class="is-preload">

		<!-- Header -->
			<header id="header">
				<h1>HnJ ERP</h1>
				<h2>로그인</h2>
				
			</header>

		<!-- Signup Form -->
			<form id="signup-form" method="post" action="${cPath }/main">
				<input type="text" name="emp_no" id="emp_no" placeholder="사원 아이디" />
				<input type="password" name="emp_pass" id="emp_pass" placeholder="비밀번호" />
				<input type="submit" value="로그인" />
				<a href="${cPath}/loginForm/passWordSearch">비밀번호 찾기</a>
			</form>

	
		<!--  Footer 
			<footer id="footer">
				<ul class="icons">
					<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
					<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
					<li><a href="#" class="icon brands fa-github"><span class="label">GitHub</span></a></li>
					<li><a href="#" class="icon fa-envelope"><span class="label">Email</span></a></li>
				</ul>
				<ul class="copyright">
					<li>&copy; Untitled.</li><li>Credits: <a href="http://html5up.net">HTML5 UP</a></li>
				</ul>
			</footer>
 -->
		<!-- Scripts -->
			<script src="${cPath}/resources/assets/js/main.js"></script>

	</body>
</html>