<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h1>계정 상세내역</h1><br>
<form id="accup">
<table>
		<tr>
			<th>구분</th>
			<td><input type="text" name="division" class="code form-control" readonly="readonly"
				 value="${account.division }">
		</tr>
		<tr>
			<th>표준계정과목</th>
			<td>
				 <select class="dynamicElement form-control mr-2" name="stand_no" disabled="disabled"
					data-url="<c:url value='account/basic/account/stand'/>">
					<c:forEach items="${standardList }" var="list">
						<option value="${list.stand_no }" data-division='${list.division }' 
						${list.stand_no eq account.stand_no? 'selected': '' }>${list.stand_name }</option>
					</c:forEach>
				</select>
		</tr>
		<tr>
			<th>계정코드</th>
			<td><input type="text" name="account_no" class="code form-control" readonly="readonly"
				 value="${account.account_no }">
		</tr>
		<tr>
			<th>계정명</th>
			<td><input type="text" name="account_name" class="form-control" readonly
				 value="${account.account_name }">
		</tr>
		<tr>
			<th>비고</th>
			<td><textarea id="etc" name="etc" class="form-control" readonly>${account.etc }</textarea>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<select name='use_status' disabled="disabled">
					<option value='G001' ${"G001" eq account.use_status? "selected": "" }>사용</option>
					<option value='G002' ${"G002" eq account.use_status? "selected": "" }>사용중지</option>
				</select>
		</tr>
</table>
</form>
<script>
var division = $("input[name='division']");
$( "select[name='stand_no']" ).change(function() {
  var str = "";
  $( "select[name='stand_no'] option:selected" ).each(function() {
    division.val($( this ).data("division"));
  });
});


$("input[name='summary_no']").on("input", function(){
	if($(this).val()!=""){
		insertBtn.val("새적요입력");
	}else{
		$("#insertBtn").val("등록");
	}
});
</script>