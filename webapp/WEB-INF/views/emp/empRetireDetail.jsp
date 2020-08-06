<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  

<div>
<table class="table table-bordered  text-left">
	<thead class="">
	
		<tr>
			<td> 소속 </td>
			<td>${emp.dep_no}</td>
			<td> 직급 </td>
			<td>${emp.pos_no}</td>			
			<td>사원ID </td>
			<td> ${emp.emp_no}</td>
			<td> 성명 </td>
			<td>${emp.emp_name}</td>
		</tr>
		<tr>
			<td>입사일</td> 
			<td>${emp.hire_date }</td>	
			<td>구분</td> 
			<td>${emp.name }</td>	
			<td>퇴사날짜</td> 
			<td>${emp.retire_date }</td>	
			<td>퇴사사유</td> 
		    <td>${emp.retire_reason}</td>
			
		</tr>
		<tr>
			<td>성별</td> 
			<td>${emp.emp_gen }</td>
			<td> 전화번호 </td>
			<td>${emp.emp_phone}</td>
			<td>이메일</td> 
			<td>${emp.emp_email }</td>	
			<td>주소</td> 
		    <td>${emp.emp_addr}</td>
			
		</tr>
		</thead>
	
</table>
</div>
