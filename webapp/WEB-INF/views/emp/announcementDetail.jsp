<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  

<div>
<table class="table table-bordered  text-left" border="1">
	<thead class="">
		<tr>
	
		
			<td colspan="2" rowspan="2"><img id="emp_img" style="width: 150px; max-heigth: 100px;" alt="" src="${cPath }/resources/empImg/${emp.emp_no}"></td>
		
	
		
			<td > 사원id </td>
			<td colspan="3" >${emp.emp_no}</td>	
		</tr>
		<tr>			
			<td>성명 </td>
			<td colspan="3" >${emp.emp_name}</td>
			
		</tr>
		<tr>
			
			<td>소속</td>	
			<td>${emp.dep_no}</td> 
			<td>직급</td>	
			<td>${emp.pos_no}</td> 
			<td>발령등록일</td>	
			<td>${emp.today_ann}</td> 
			
		</tr>
		<tr>
			<td>발령구분</td> 
			<td>${emp.remark}</td>
			<td>발령상태</td>
			<td>${emp.name}</td>
			<td>발령일</td> 
			<td>${emp.ann_date}</td>	
			
		</tr>
		</thead>
	
</table>
</div>
<script type="text/javascript">
console.log("${emp.st_before}")
</script>
