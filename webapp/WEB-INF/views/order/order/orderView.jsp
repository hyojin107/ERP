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

<table class="table">
	<thead>
		<tr>
			<th><spring:message code="date" /></th>
			<td>${order.or_date }</td>
		</tr>
		<tr>
			<th><spring:message code="order.or_no" /> </th>
			<td>${order.or_no }</td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" /> </th>
			<td>${order.buyer_name }</td>
		</tr>
		<tr>
			<th><spring:message code="emp.emp_name" /> </th>
			<td>${order.emp_name }</td>
		</tr>
		
		<tr>
			<th><spring:message code="buyer.buyer_zip" /> </th>
			<td>바이어우편번호</td>
		</tr>
		
		<tr>
			<th><spring:message code="buyer.buyer_addr" /> </th>
			<td>바이어주소</td>
		</tr>
		
		<tr>
			<th><spring:message code="order.or_req_date" /> </th>
			<td>${order.or_req_date }</td>
		</tr>
		
	</thead>
	<tbody id="listBody">
		<tr>
			
			<th><spring:message code="prod_code" /></th>
			<th><spring:message code="prod_name" /></th>
			<th><spring:message code="prod_standard" /></th>
			<th><spring:message code="prod_qty" /></th>
			<th><spring:message code="prod_price" /></th>
			<th><spring:message code="prod_validity" /></th>
			<th><spring:message code="prod_totalprice" /></th>
		</tr>
		<tr>	
<%-- 			<c:set var="allProd" value="${pagingVO.dataList }"/> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${not empty estimate.estimateList.prodList }"> --%>
<%-- 					<c:forEach var="prod" items="${prod }"> --%>
						
<%-- 					</c:forEach> --%>
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
			<c:if test="${order!=null }">
			<c:forEach items="${order.orderList}" var="list">
				<c:if test="${list.prodList!=null }">
				<c:forEach items="${list.prodList }"  var="pList">
					<tr>
						<td>${pList.prod_no }</td>
						<td>${pList.prod_name }</td>
						<td>${list.orp_qty }</td>
						<td>${pList.prod_stand_size }</td>
						<td>${pList.prod_out_price }</td>
						<td>${pList.prod_validity }</td>
						<td>${orderList.orp_price }</td>
					</tr>
				</c:forEach>
				</c:if>
			</c:forEach>
			</c:if>
		</tr>
	</tbody>

</table>

