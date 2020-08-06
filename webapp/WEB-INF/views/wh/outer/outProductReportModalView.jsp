<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1>출고관리 : 생산보고서 , 생산팀에서 보낸 생산보고서로 추가로 사용된 원자재를 출고시킨다.</h1>

<form:form>
	<table class="table">
	<tbody>
		<tr>
			<th>작성자</th>
			<th>작성일자</th>
			<th>생산품</th>
			<th>생산 수량</th>
			<th>창고</th>
		</tr>
		<tr>
			<td>(작성자)</td>
			<td>(작성일자)</td>
			<td>(생산품)</td>
			<td>(생산수량)</td>
			<td>
				<select>
					<option>창고선택</option>
				</select>
			</td>
		</tr>
	</tbody>
	<tr>
		<th>추가 사용된 원자재</th>
	</tr>
	<tfoot>
		<tr>
			<th>No.</th>
			<th>원자재 명</th>
			<th>원자재 수량</th>
			<th>수량 단위</th>
		</tr>
		<tr>
			<td>(No)</td>
			<td>(원자재명)</td>
			<td>(원자재수량)</td>
			<td>(수량단위)</td>
		</tr>
	</tfoot>
	</table>
</form:form>

