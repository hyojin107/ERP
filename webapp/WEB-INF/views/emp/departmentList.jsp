<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>부서별 인사현황 </h1>  

<div>
<table class="table table-bordered  text-left">
	<thead class="table-primary">
	
		<tr>
			<td>부서 </td>
			<td>1팀 </td>
			<td>2팀 </td>
			<td>3팀 </td>
			<td>총인원 </td>
		</tr>
		
		<tr>
			<td>인사부서 </td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			
		</tr>
		<tr>
			<td>회계부서</td>
			<td> </td>
			<td></td>
			<td></td>
			<td></td>
			
		</tr>
		
		<tr>
			<td>생산부서</td>
			<td> </td>
			<td></td>
			<td></td>
			<td></td>
			
		</tr>
		
		<tr>
			<td>구매부서</td>
			<td> </td>
			<td></td>
			<td></td>
			<td></td>
			
		</tr>
		
		<tr>
			<td>자재부서</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			
		</tr>
		
		</thead>
	</tbody>
	
</table>
</div>
<tr class="row">
	<td class="col text-right">
	<input class="  mr-2" type="text" value="집계 기준일 : ${System.currentTimeMillis()}"> 
	</td>
</tr>

