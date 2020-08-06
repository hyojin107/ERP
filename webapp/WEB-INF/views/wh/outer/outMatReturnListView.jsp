<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>출고관리 : 원자재 반품 의뢰서 목록 보여주기 </title>
</head>
<body>
<h1>출고관리 : 원자재 반품신청했던 목록들을 보여준다.</h1>
<h1>반품의뢰서 작성 버튼을 누르면 신규 작성폼으로 이동한다.</h1>

<br/>
<div>
	<form:form id="searchForm" action="${pageContext.request.contextPath }/ware/mat" method="get">
		<table border="1" class="table table-striped">
			<tr>
				<th>
					작성자
				</th>
				<td><input type="text" name="mat_name"/></td>
				<th>
					<spring:message code="mat.mat_no"/>
				</th>
				<td><input type="text" name="mat_no"/></td>
				<td><input type="button" value="검색" id="searchBtn"/></td>
			</tr>
			<tr>
				<th>
					작성기간
				</th>
				<td colspan="3">
					<input type="number"/>~<input type="number"/>
				</td>
				
			</tr>
		</table>
	</form:form>
</div>
<br/><br/>
<table border="1" class="table table-striped">
	<tr>
		<td colspan="4"></td>
		<td><input type="button" value="반품의뢰서 작성" onclick="location.href='${cPath}/outer/matreturn/insert'"/></td>
	</tr>	
	<tr>
		<th>No.</th>
		<th>부서</th>
		<th>작성자</th>
		<th>요청일자</th>
	</tr>
	<tbody id="listbody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4">
				<nav id="pagingArea">${pagingVO.pagingHTML }</nav>
			</td>
		</tr>
	</tfoot>
</table>

</body>
</html>