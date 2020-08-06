<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 10       송효진 	          최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table id="buyerTable" class="table table-hover">
  <thead>
	<tr>
		<th scope="col">#</th>
		<th scope="col">거래처코드</th>
		<th scope="col">거래처명</th>
		<th scope="col">업종</th>
		<th scope="col">대표자명</th>
		<th scope="col">거래처 주소</th>
	</tr>
  </thead>
  <tbody>
	<c:if test="${not empty buyerList }">
		<c:forEach items="${buyerList }" var="buyer">
		<tr>
			<td>${buyer.rnum }</td>
			<td class="buyer_no">${buyer.buyer_no }</td>
			<td class="buyer_name">${buyer.buyer_name }</td>
			<td>${buyer.buyer_sector }</td>
			<td>${buyer.buyer_rep }</td>
			<td>${buyer.buyer_addr }</td>
		</tr>
		</c:forEach>
	</c:if>
  </tbody>
</table>
