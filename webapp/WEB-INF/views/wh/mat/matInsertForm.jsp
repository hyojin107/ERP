<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1>원자재 관리 : 원자재  신규등록 작성 폼</h1>
<form:form id="matForm" modelAttribute="matVO" method="post" action="${cPath }/ware/mat">
	<c:if test="${not empty methodType }">
		<input type="hidden" name="_method" value="${methodType }"/>
	</c:if>
	
	<table class="table">
		<tr>
			<td>
				<spring:message code="mat.mat_no"/>
			</td>
			<td>
				<input type="text" name="mat_no" value="${matVO.mat_no }" readonly="readonly" placeholder="자동생성">
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_name"/>
			</td>
			<td>
				<input type="text" name="mat_name" value="${matVO.mat_name }"/>
				<form:errors path="mat_name" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_standard"/>
			</td>
			<td>
				<input type="number" name="mat_standard" value="${matVO.mat_standard }"/>
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_stand_size"/>
			</td>
			<td>
				<input type="text" name="mat_stand_size" value="${matVO.mat_stand_size }"/> 
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_validity"/>
			</td>
			<td>
				<input type="date" name="mat_validity" value="${matVO.mat_validity }"/> 
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_use"/>
			</td>
			<td> 
			<select name="mat_use">
				<option value="">사용여부</option>
				<c:forEach items="${ruleList }" var="use">
					<option value="${use.code }"
					${not empty matVO and not empty matVO.mat_use and matVO.mat_use.contains(use.code) ? "selected" : "" }>
					${use.name }</option>
				</c:forEach>
			</select>
				<form:errors path="mat_use" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_safe_stock"/>
			</td>
			<td> 
				<input type="number" name="mat_safe_stock" value="${matVO.mat_safe_stock}"/>
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.mat_stock_size"/>
			</td>
			<td> 
				<input type="text" name="mat_stock_size" value="${matVO.mat_stock_size}"/>
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="mat.lprod_no"/>
			</td>
			<td>
				<select name="lprod_no">
					<option value>상품분류</option>
					<c:forEach items="${lprodList }" var="lprod">
						<option value="${lprod.lprod_no}"
							${not empty matVO.lprod_no and matVO.lprod_no.contains(lprod.lprod_no) ? "selected":""}>
							${lprod.lprod_name }
						</option>
					</c:forEach>
				</select>
				<form:errors path="lprod_no" element="span" cssClass="error"/>
			</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<td>창고위치</td> -->
<!-- 			<td> -->
<%-- 				<select class="dynamicElement" name="store_no" data-url="<c:url value='/ware/lprod/getStoreList'/>"> --%>
<!-- 					<option value>창고선택</option> -->
<%-- 					<c:forEach items="${storeList }" var="store"> --%>
<%-- 						<option value="${store.store_no }">${store.store_name }</option> --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<td>창고구역</td> -->
<!-- 			<td> -->
<%-- 				<select class="dynamicElement" name="sector_no" data-url="<c:url value='/ware/lprod/getSectorList'/>"> --%>
<!-- 				</select> -->
<!-- 			</td> -->
<!-- 		</tr> -->
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="저장"/>
				<input type="reset" class="btn btn-secondary" value="다시쓰기"/>
				<input type="button"  class="btn btn-info" value="뒤로가기" onclick="history.back();"/>
				<input type="button" class="btn btn-primary" value="목록으로 " onclick="location.href='${pageContext.request.contextPath}/ware/mat/list';"/>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">

	// 창고선택하면 그 창고에 속한 구역이 나온다 .
	var optionPtrn = "<option value='%V' %S>%T</option>";
	
	var store_Tag = $("select[name='store_no']").on("change",function(){
		let store_no = $(this).val();
		sector_Tag.trigger("renew",{
			store_no : store_no
		});
	});
	
	var sector_Tag = $("select[name='sector_no']").data("success",function(resp){
		var html = "<option value>구역선택</option>";
		$.each(resp, function(idx, sector){
			html += optionPtrn
					.replace("%V",sector.store_no)
					.replace("%T", sector.sector_no)
					.replace("%S", sector.store_no == "${mat.sector_no}"?"selected":"");
		});
		sector_Tag.html(html);
	});
	
	$(".dynamicElement").dynamicSelect();
</script>
