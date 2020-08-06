<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<meta charset="utf-8">
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
<title>Bar Chart Race</title>
<link rel="stylesheet" type="text/css" href="./inspector.css">
<body>
<h1>상품별매출현황</h1><br>
<table>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<text>년도</text>
					<select name="searchType" class="form-control mr-2">
					</select>
					<input class="btn btn-success mr-2" type="button" value="검색" id="searchBtn">
				</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<script type="module">

import define from "./index.js";
import {Runtime, Library, Inspector} from "./runtime.js";

const runtime = new Runtime();
const main = runtime.module(define, Inspector.into(document.body));

</script>

