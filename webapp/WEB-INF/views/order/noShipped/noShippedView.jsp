<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 5      	이제경       	최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<h1>미출하현황리스트뷰 : 해당 주문서를 선택하면 나오는 상세보기 모달창, 수정도 가능 </h1>

<table>
	<tr>
		<th>원자재 코드</th>
		<th>원자재 명</th>
		<th>규격</th>
		<th>규격 단위</th>
		<th>창고</th>
		<th>창고 구역</th>
		<th>유효기간</th>
		<th>현재재고량</th>
		<th>안전재고량</th>
		<th>수량단위</th>
	</tr>
	<tr>
		<td>M00001</td>
		<td>원자재1</td>
		<td>50</td>
		<td>cm</td>
		<td>A</td>
		<td>a</td>
		<td>20220701</td>
		<td>0</td>
		<td>50</td>
		<td>개</td>
	</tr>
</table>
