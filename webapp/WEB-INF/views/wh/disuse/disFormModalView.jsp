<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    
    <%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2020. 7. 6      작성자명 박정민
      최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>



<table class="table table-striped" data-order="${pductlist.porder_no}" >

	<tr>
	<th>오더 데이터</th>
	<td>${pductlist.rep_date } </td>
	</tr>
	
	<tr>
	<th>요청한 사원</th>
	<td>${pductlist.emp_name }</td> 
	</tr>
	<tr>
	
		</table>
<table class="table table-striped">
<thead>
 <tr>
  <th>원자재 이름</th>
  <th>원자재 번호</th>
  <th>사용될 원자재</th>
 </tr>
</thead>

<c:set var="Pitem" value="${pductlist.meterial }"/>

<c:forEach items="${Pitem }" var="item">
<tr>
<td>${item.mat_name }</td>
<td>${item.mat_no }</td>
<td>${item.mat_cnt }</td>

</tr>
</c:forEach>

</table>


