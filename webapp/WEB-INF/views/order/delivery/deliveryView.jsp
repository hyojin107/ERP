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


<h1>출하지시서 리스트뷰 : 해당 주문서를 선택하면 나오는 상세보기 모달창, 수정도 가능 </h1>


<table class="table">
	<thead>
		<tr>
			<th><spring:message code="order.or_no" /></th>
			<td>${delivery.or_no }</td>
		</tr>
		<tr>
			<th><spring:message code="delivery.deliv_no" /></th>
			<td>${delivery.deliv_no }</td>
		</tr>
		<tr>
			<th><spring:message code="date" /></th>
			<td>${delivery.deliv_date }</td>
		</tr>
		<tr>
			<th><spring:message code="emp.emp_name" /></th>
			<td>${delivery.emp_name }</td>
		</tr>
		<tr>
			<th><spring:message code="delivery.deliv_schd" /></th>
			<td>${delivery.deliv_schd }</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>#</th>
			<th><spring:message code="prod_code" /></th>
			<th><spring:message code="prod_name" /></th>
			<th><spring:message code="prod_standard" />단위</th>
			<th><spring:message code="prod_qty" /></th>
		</tr>
		<tr>
			<c:if test="${delivery!=null }">
				<c:forEach items="${delivery.order }" var="order">
					<c:if test="${order.orderList!=null }">
					<c:forEach items="${order.orderList }" var="oList">
						<c:if test="${oList.prodList!=null }">
						<c:forEach items="${oList.prodList }" var="pList">
							<tr>
								<td>#</td>
								<td>${pList.prod_no }</td>
								<td>${pList.prod_name }</td>
								<td>${pList.prod_standard }${pList.prod_stand_size }</td>
								<td>${oList.orp_qty }</td>
							</tr>
						</c:forEach>
						</c:if>
					</c:forEach>
					</c:if>
				</c:forEach>
				</c:if>			
		</tr>
	
	</tbody>

</table>

