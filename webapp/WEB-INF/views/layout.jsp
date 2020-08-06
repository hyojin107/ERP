<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>HnJ ERP</title>
  <!-- jQuery -->
  <script src="${pageContext.request.contextPath }/resources/plugins/jquery/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- IonIcons -->
  <link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/bootstrap-4.5.0-dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- 타일즈 top, left -->
	    <tiles:insertAttribute name="topMenu"/>
	  	<tiles:insertAttribute name="leftMenu"/>
	  
	  	<!-- 타일즈 contens -->
	  	<div class="content-wrapper" style="height: 100%"><!-- Content Wrapper. Contains page content -->
		    <tiles:insertAttribute name="contents"/>
		</div>
		 <!-- Main Footer -->
		 <footer class="main-footer">
		   <strong>Copyright &copy; ERP 2019~2020 <a href="#">ERP</a>.</strong>
		   All rights reserved.
		   <div class="float-right d-none d-sm-inline-block">
		     <b>Version</b> 3.0.5
		   </div>
		 </footer> 
	</div>
	
	<!-- 부트스트랩 -->
	<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script src="${pageContext.request.contextPath }/resources/dist/js/adminlte.js"></script>
	<!-- 엑셀 다운로드 -->
	<script src="${cPath }/resources/js/xlsx.core.min.js"></script>
	<script src="${cPath }/resources/js/FileSaver.min.js"></script>
	<script src="${cPath }/resources/js/tableexport.js"></script>
	
	
	<!-- OPTIONAL SCRIPTS -->
	<%-- <script src="${pageContext.request.contextPath }/resources/plugins/chart.js/Chart.min.js"></script> --%>
	<%-- <script src="${pageContext.request.contextPath }/resources/dist/js/demo.js"></script> --%>
	<%-- <script src="${pageContext.request.contextPath }/resources/dist/js/pages/dashboard3.js"></script> --%>
</body>
</html>



