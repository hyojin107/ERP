<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>입고관리 : 생산보고서 모달창으로 상세보기 후 생산품 바로 입고 처리 하기 </h1>
<table class="table">
	<thead>
		<tr>
			<th>작성자</th>
			<td>(작성자)</td>
		</tr>
		<tr>
			<th>문서번호</th>
			<th>(문서번호)</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>No.</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>생산수량</th>
			<th>분류</th>
			<th>입고창고</th>
		</tr>
		<tr>
			<td>(No)</td>
			<td>(상품코드)</td>
			<td>(상품명)</td>
			<td>(생산수량)</td>
			<td>(입고)</td>
			<td>
				<select>
					<option>창고</option>
				</select>
			</td>
		</tr>
	</tbody>
	
</table>

