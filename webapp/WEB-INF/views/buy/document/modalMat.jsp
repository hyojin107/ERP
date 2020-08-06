<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 7       송효진 	          최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table id="matTable" class="table table-hover">
  <thead>
	<tr>
		<th scope="col">#</th>
		<th scope="col">품목코드</th>
		<th scope="col">품목명</th>
		<th scope="col">분류명</th>
		<th scope="col">규격단위</th>
	</tr>
  </thead>
  <tbody>
	<c:if test="${not empty matList }">
		<c:forEach items="${matList }" var="mat">
		<tr>
			<td><input type="checkbox" name="checkMat" value="${mat.mat_no }" class="checkMat" style="width:40px;"/>&nbsp;&nbsp;&nbsp;${mat.rnum }</td>
			<td class="mat_no">${mat.mat_no }</td>
			<td class="mat_name">${mat.mat_name }</td>
			<td class="lprod_name">${mat.lprodVO.lprod_name }</td>
			<td class="mat_stand_size">${mat.mat_stand_size }</td>
		</tr>
		</c:forEach>
	</c:if>
  </tbody>
</table>

<script type="text/javascript">
	$(document).on("click", "#matTable td", function(){
		let check = $(this).parent().find(".checkMat").prop("checked");
		if(check==false){
			$(this).parent().find(".checkMat").prop("checked", true);			
		}else{
			$(this).parent().find(".checkMat").prop("checked", false);
		}
	});
</script>


