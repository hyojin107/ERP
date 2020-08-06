<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<form:form id="chitForm" modelAttribute="chit"  method="post" enctype="multipart/form-data" class="w-100"
	action="${pageContext.request.contextPath }/account/chit/${chit.chit_no }">
	
	<input type="hidden" name="_method" value="put" >
	
	<input type="hidden" name="chit_no" value="${chit.chit_no }">
	<table class="table table-bordered">
		<tr>
			<th>전표일자</th>
			<td><text>${chit.chit_date }</text>
			<form:errors path="chit_date" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>전표유형</th>
			<td>
			<text>${chit.buy_sell }</text>
			<form:errors path="buy_sell" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>거래처</th>
			<td><text>${chit.buyer_name }</text>
			<form:errors path="buyer_name" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>거래내역</th>
			<td>
				<table>
					<tr>
						<th>품목</th>
						<th>수량</th>
						<th>가액</th>
						<th>적요</th>
					</tr>
					<c:choose>
					<c:when test="${chit.chitList!=null }">
					<c:forEach items="${chit.chitList }" var="clist">
						<tr>
							<td>${clist.product }</td>
							<td><input type="hidden" name='deal_no' value='${clist.deal_no }'>
							<input type='number' name='qty' value='${clist.qty }' class="form-control" readonly></td>
							<td><input type='number' name='price' value='${clist.price }' class="form-control" readonly></td>
							<td><input type='text' name='summary' value='${clist.summary }' class="form-control" readonly></td>
						</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan='4'>거래 품목이 없습니다.</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</table>
			</td>
		</tr>
		<tr>
			<th>부서</th>
			<td>
				<text>${chit.dep_no }</text>
			</td>
		</tr>
		<tr>
			<th>총액</th>
			<td id="sum"></td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
	var chitForm = $("#chitForm");
	chitForm.on("submit", function(){
		let btn = $("#updateBtn");
		if($("#updateBtn").val()=='수정') {
			event.preventDefault();
			btn.val('저장');
			$("input").removeAttr("readonly");
			return false;
		}
	});
	var sum = 0;
	<c:if test="${chit.chitList!=null }">
	<c:forEach items="${chit.chitList }" var="list">sum+=${list.price*list.qty};</c:forEach>
	</c:if>
	$("#sum").text(sum);
</script>