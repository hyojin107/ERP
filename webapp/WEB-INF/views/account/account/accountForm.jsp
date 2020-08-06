<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<h1>계정등록</h1>
<form:form id="accountForm" modelAttribute="account"  method="post" enctype="multipart/form-data" class="w-100"
	action="${pageContext.request.contextPath }${currentAction }">
	
	<input type="hidden" name="account_no" value="${account.account_no }">
	<table class="table table-bordered">
		<tr>
			<th>구분</th>
			<td><input type="text" name="division" class="form-control" readonly="readonly"
				 value="${account.division }">
			<form:errors path="division" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>표준계정과목</th>
			<td>
				 <select class="dynamicElement form-control mr-2" name="stand_no"
					data-url="<c:url value='account/basic/account/stand'/>">
					<option value>표준계정과목</option>
					<c:forEach items="${standardList }" var="list">
						<option value="${list.stand_no }" data-division='${list.division }'>${list.stand_name }</option>
					</c:forEach>
				</select>
			<form:errors path="account_name" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>계정코드</th>
			<td><input type="text" name="account_no" class="form-control" readonly="readonly"
				 value="${account.account_no }">
			<form:errors path="account_no" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>계정명</th>
			<td><input type="text" name="account_name" class="form-control"
				 value="${account.account_name }">
			<form:errors path="account_name" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>비고</th>
			<td><textarea id="etc" name="etc" class="form-control">${account.etc }</textarea>
			<form:errors path="etc" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<select name='use_status'>
					<option value='G001' ${"G001" eq account.use_status? "selected": "" }>사용</option>
					<option value='G002' ${"G002" eq account.use_status? "selected": "" }>사용중지</option>
				</select>
				<form:errors path="use_status" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="저장" />
				<input type="button" class="btn btn-secondary" value="다시작성" id='rewrite'/>
				<input type="button" class="btn btn-primary" value="목록으로" 
					onclick="location='${cPath}/account/basic/account'"
				/>
			</td>
		</tr>
	</table>
</form:form>


<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
//옵션 선택시 
var option = $("input[name='division']");

var standardCode = $("select[name='stand_no']").on("click",function(){
	option.val($(this).find("option").eq($(this).val()).data("division"));
});
$("#rewrite").on("click", function(){
	$("form").find("input").not(".btn").val("");	
	$("form").find("textarea").val("");
	$("form").find("select").val("");
});
</script>