<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
   
<table class = "table">
<thead>
<tr>
<td>물품 이름</td>
<td>물품 갯수</td>
<td>물품 단위</td>
<td>위치 섹터</td>
</tr>
</thead>

<tbody>
<c:forEach items="${stufflist }" var="stuff">
<tr>
<td>${stuff.stuff_name }</td>
<td>${stuff.stuff_cnt }</td>
<td>${stuff.stuff_size }</td>
<td>${stuff.sector_no }</td>
</tr>

</c:forEach>


</tbody>
</table>