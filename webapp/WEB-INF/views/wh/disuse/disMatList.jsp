<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>

<thead>
<tr>
 <td>사원</td>
 <td>품목명</td>
 <td>입고수량</td>
 <td></td>
 <td>폐기한 날짜</td>
 </tr>
</thead>
<tbody>
<c:forEach items="${mat }" var="item">
<tr>
<td>${item.emp_name }</td>
<td>${item.stuff_name }</td>
<td>${item.sector_no }</td>
<td>${item.stuff_cnt } ${item.stuff_size }</td>
<td>${item.dis_date }</td>


</tr>
</c:forEach>

</tbody>

