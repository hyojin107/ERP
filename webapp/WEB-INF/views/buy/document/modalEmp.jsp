<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 6       송효진 	          최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table id="empTable" class="table table-hover">
  <thead>
	<tr>
		<th scope="col">#</th>
		<th scope="col">사원번호</th>
		<th scope="col">사원명</th>
		<th scope="col">부서명</th>
		<th scope="col">직급</th>
	</tr>
  </thead>
  <tbody>
	<c:if test="${not empty empList }">
		<c:forEach items="${empList }" var="emp">
		<tr>
			<td>${emp.rnum }</td>
			<td class="emp_no">${emp.emp_no }</td>
			<td class="emp_name">${emp.emp_name }</td>
			<td>${emp.depVO.dep_name }</td>
			<td>${emp.posVO.pos_name }</td>
		</tr>
		</c:forEach>
	</c:if>
  </tbody>
</table>

