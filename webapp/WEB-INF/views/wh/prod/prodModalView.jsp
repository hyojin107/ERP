<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>상품관리 : 상품 상세보기 모달창</h1>

<table class="table">
		<thead>
			<tr>
				<th>
					<spring:message code="prod.prod_no"/>
				</th>
				<td>${prod.prod_no }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_name"/>
				</th>
				<td>${prod.prod_name }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.lprod_no"/>
				</th>
				<td>${prod.lprod_no }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_use"/>
				</th>
				<td>${prod.prod_use eq 'G003' ? '생산중' : '생산중지' }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_stock"/>
				</th>
				<td>${prod.prod_stock }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_safe_stock"/>
				</th>
				<td>${prod.prod_safe_stock }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_stock_size"/>
				</th>
				<td>${prod.prod_stock_size }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_out_price"/>
				</th>
				<td>${prod.prod_out_price}</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_standard"/>
				</th>
				<td>${prod.prod_standard }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_stand_size"/>
				</th>
				<td>${prod.prod_stand_size }</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.prod_img"/>
				</th>
				<td>
					<img style="width: 300px; height: 300px;" src="${cPath }/resources/prodImg/${prod.prod_no }">
				</td>
			</tr>
			
		</thead>
		<tbody>
			<tr>
				<th>
					<spring:message code="bom.mat_no"/>
				</th>
				<th>
					<spring:message code="mat.mat_name"/>
				</th>
				<th>
					<spring:message code="bom.mat_number"/>
				</th>
				<th>
					<spring:message code="bom.mat_size"/>
				</th>
			</tr>
			<c:choose>
				<c:when test="${not empty prod.bomlist}">
					<c:forEach items="${prod.bomlist }" var="bom">
						<tr>
							<td>${bom.mat_no}</td>
							<td>${bom.matVO.mat_name }</td>
							<td>${bom.mat_number }</td>
							<td>${bom.mat_size }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<th></th>
						<th colspan="3">BOM 정보 없음</th>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
</table>
