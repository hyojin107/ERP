<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<form:form  method="post">
<table class="table table-bordered text-center">
	<tr>
		<td>날짜</td>
		<td>소속</td>
		<td>직급</td>
		<td>이름</td>
		<td>사원번호</td>
		<td>출근시간</td>
		<td>퇴근시간 </td>		
	</tr>	
	<tr>
		<td>${work.work_date}</td>
		<td>${work.dep_no}</td>
		<td>${work.pos_no}</td>
		<td>${work.emp_name}</td>
		<td id="emp_no">${work.emp_no}</td>
		<td><input type="text" name="wokr_time" value="${work.work_time}" readonly /></td>
		<td><input type="text" name= "offwork_time" value="${work.offwork_time}" readonly/></td>		
	</tr>	
</table>
</form:form>
<script type="text/javascript">

</script>
