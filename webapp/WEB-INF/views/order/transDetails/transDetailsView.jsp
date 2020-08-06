<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 18      	이제경       	최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>거래명세서 상세페이지 </h1>

<table class="table">
	<thead>
		<tr>
			<th>거래명세서번호</th>
			<td>${transDetails.tran_no }</td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_no" /></th>
			<td>${transDetails.buyerList[0].buyer_no }</td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" /></th>
			<td>${transDetails.buyerList[0].buyer_name }</td>
		</tr>
		<tr>
			<th>작성일자</th>
			<td>${transDetails.tran_date }</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>#</th>
			<th><spring:message code="prod_code" /></th>
			<th><spring:message code="prod_name" /></th>
			<th><spring:message code="prod_standard" /></th>
			<th><spring:message code="prod_qty" /></th>
			<th><spring:message code="prod_price" /></th>
			<th><spring:message code="summary" /></th>
		</tr>
		<tr>
		<c:if test="${transDetails.prod!=null }">
		<c:forEach items="${transDetails.prod }" var="pList" begin="0" step="1" varStatus="i">
				<tr>
					<td></td>
					<td>${pList.prod_name }</td>
					<td>${pList.prod_standard }</td>
					<td>${transDetails.orderList[i.count-1].orp_qty }</td>
					<td>${transDetails.orderList[i.count-1].orp_price}</td>
					<td>${pList.prod_out_price }</td>
					<td><input type="text" id="summary"></td>
				</tr>
		</c:forEach>
		</c:if>
		</tr>
	
	</tbody>

</table>