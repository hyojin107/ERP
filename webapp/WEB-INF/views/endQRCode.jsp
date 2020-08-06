<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


	<img src="/ERP/resources/img/퇴근img.PNG" />

<c:if test="${not empty result }">
	<script type="text/javascript">
		alert(result);
	</script>
</c:if>
