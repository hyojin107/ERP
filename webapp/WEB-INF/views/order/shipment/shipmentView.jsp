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


<h1>출하 리스트뷰 : 해당 주문서를 선택하면 나오는 상세보기 모달창, 수정도 가능 </h1>

<table class="table">
	<thead>
		<tr>
			<th>출하번호</th>
			<td>${shipment.ship_no }</td>
		</tr>
		<tr>
			<th><spring:message code="delivery.deliv_no" /></th>
			<td>${shipment.deliv_no }</td>
		</tr>
		<tr>
			<th><spring:message code="delivery.deliv_schd" /></th>
			<td>${shipment.deliveryList[0].deliv_schd }</td>
		</tr>
		<tr>
			<th>작성일자</th>
			<td>${shipment.ship_date }</td>
		</tr>
		<tr>
			<th><spring:message code="emp.emp_name" /></th>
			<td>${shipment.emp_name }</td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" /></th>
			<td>${shipment.buyer_name }</td>
		</tr>
		<tr>
			<th>출하일</th>
			<td>${shipment.ship_p_date }</td>
		</tr>
		<tr>
			<th><spring:message code="status" /></th>
			<td>${shipmnet.ship_prog }</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>#</th>
			<th><spring:message code="prod_code" /></th>
			<th><spring:message code="prod_name" /></th>
			<th><spring:message code="prod_standard" /></th>
			<th><spring:message code="prod_qty" /></th>
			<th><spring:message code="summary" /></th>
		</tr>
		<tr>
		<c:if test="${shipment!=null }">
		<c:forEach items="${shipment.deliveryList }" var="delivery">
			<c:if test="${delivery!=null }">
			<c:forEach items="${delivery.order }" var="order">
				<c:if test="${order!=null }">
				<c:forEach items="${order.orderList }" var="list">
					<c:if test="${list.prodList!=null }">
					<c:forEach items="${list.prodList }" var="pList">
						<tr>
							<td>${pList.prod_no }</td>
							<td>${pList.prod_name }</td>
							<td>${pList.prod_standard }</td>
							<td>${list.orp_qty }</td>
							<td><input type="text" id="summary"></td>
						</tr>
					</c:forEach>
					</c:if>
				</c:forEach>
				</c:if>
			</c:forEach>
			</c:if>
		</c:forEach>
		</c:if>
		</tr>
	
	</tbody>

</table>