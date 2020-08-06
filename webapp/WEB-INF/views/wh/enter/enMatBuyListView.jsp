<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<h1>입고관리 : 자재팀이 작성한 원자재 구매요청서 목록 보여주기</h1>
<div>
	<input type="button" value="원자재목록"  onclick="location.href='${cPath}/enter/mat/matlist'"/>
	<input type="button" value="구매요청서목록" onclick="location.href='${cPath}/enter/mat/buyorder/buyrequestlist'"/>
</div>
<br/>
<div>
	<form:form id="searchForm" action="${pageContext.request.contextPath }/ware/mat" method="get">
		<table border="1" class="table table-striped">
			<tr>
				<th>
					작성자
				</th>
				<td><input type="text" name=""/></td>
				<td><input type="button" value="검색" id="searchBtn"/></td>
			</tr>
			<tr>
				<th>
					요청일자
				</th>
				<td colspan="2"><input type="date" name=""/></td>
			</tr>
		</table>
	</form:form>
</div>
<br/><br/>
<table border="1"  class="table table-striped">
	<tr>
		<th>No.</th>
		<th>문서코드</th>
		<th>부서</th>
		<th>작성자</th>
		<th>제목</th>
	</tr>
	<tbody id="listbody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="13">
				<nav id="pagingArea">${pagingVO.pagingHTML }</nav>
			</td>
		</tr>
	</tfoot>
</table>
