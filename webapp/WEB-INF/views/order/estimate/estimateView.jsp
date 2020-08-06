<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 5      	이제경       	최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<h1>견적서 리스트뷰 : 해당 견적서를 선택하면 나오는 상세보기 모달창, 수정도 가능</h1>

<table class="table">
	<thead>
		<tr>
			<th><spring:message code="date" /></th>
			<td>${estimate.est_date }</td>
		</tr>
		<tr>
			<th><spring:message code="estimate.est_no" /></th>
			<td>${estimate.est_no }</td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" /> </th>
			<td>${estimate.buyer_name }</td>
		</tr>
		<tr>
			<th><spring:message code="emp.emp_name" /> </th>
			<td>${estimate.emp_name }</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>#</th>
			<th><spring:message code="prod_name" /></th>
			<th><spring:message code="prod_standard" />단위</th>
			<th><spring:message code="prod_qty" /></th>
			<th><spring:message code="prod_price" /></th>
			<th><spring:message code="prod_validity" /></th>
			<th><spring:message code="prod_totalprice" /></th>
			<th>비고</th>
		</tr>
<%-- 			<c:set var="allProd" value="${pagingVO.dataList }"/> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${not empty estimate.estimateList.prodList }"> --%>
<%-- 					<c:forEach var="prod" items="${prod }"> --%>
						
<%-- 					</c:forEach> --%>
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
			<c:if test="${estimate!=null }">
			<c:forEach items="${estimate.estimateList }" var="list">
				<c:if test="${list.prodList!=null }">
				<c:forEach items="${list.prodList }" var="pList">
				<tr>
					<td>#</td>
					<td>${pList.prod_name }</td>
					<td>${pList.prod_standard }${pList.prod_stand_size }</td>
					<td>${list.est_qty }</td>
					<td>${pList.prod_out_price }</td>
					<td>${pList.prod_validity }</td>
					<td>${list.est_qty*pList.prod_out_price }</td>
					<td><input type="text"></td>
				</tr>
				</c:forEach>
				</c:if>
			</c:forEach>
			</c:if>
	</tbody>

</table>


