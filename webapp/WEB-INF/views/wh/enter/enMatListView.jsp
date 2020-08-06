<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>입고관리 : 입고 요청할 원자재 목록 (현재고량 &lt; 안전재고량)</h1>
<div>
	<input type="button" value="원자재목록"  onclick="location.href='${cPath}/enter/mat/matlist'"/>
	<input type="button" value="구매요청서목록" onclick="location.href='${cPath}/enter/mat/buyorder/buyrequestlist'"/>
</div>
<br/>
<div>
	<form:form id="searchForm" action="${cPath }/enter/mat" method="get">
		<table border="1" class="table">
			<tr>
				<th>
					<spring:message code="mat.mat_name"/>
				</th>
				<td><input type="text" name="mat_name" onkeyup="enterkey();"/></td>
				<th>
					<spring:message code="mat.mat_no"/>
				</th>
				<td><input type="text" name="mat_no"/></td>
				<td><input type="button" value="검색" id="searchBtn"/></td>
			</tr>
			<tr>
				<th>
					<spring:message code="mat.mat_validity"/>
				</th>
				<td colspan="4">
					<input type="date" name="startDay" />~<input type="date" name="endDay"/>
				</td>
			</tr>
			<tr>
				<th>
					<spring:message code="mat.lprod_no"/>
				</th>
				<td>
					<select name="lprod_no">
						<option value="">상품 분류</option>
						<c:forEach items="${lprodList }" var="lprod">
							<option value="${lprod.lprod_no}">
								${lprod.lprod_name }
							</option>
						</c:forEach>
					</select>
				</td>
				<th>
					<spring:message code="mat.mat_use"/>
				</th>
				<td colspan="2">
					<select name="mat_use">
						<option value="" >상태</option>
						<option value="G001">사용중</option>
						<option value="G002">사용중지</option>
					</select>
				</td>
			</tr>
		</table>
	</form:form><!-- 검색 form -->
</div>
<br/><br/>
<!-- 원자재 목록 -->
<table border="1"  class="table table-striped" id="matTable">
	<thead>
		<tr>
			<th>
				<spring:message code="mat.rnum"/>
			</th>
			<th>
				<spring:message code="mat.mat_no"/>
			</th>
			<th>
				<spring:message code="mat.mat_name"/>
			</th>
			<th>
				<spring:message code="mat.stock"/>
			</th>
			<th>
<%-- 				<spring:message code="store.store_name"/> --%>
				<spring:message code="mat.mat_safe_stock"/>
			</th>
			<th>
<%-- 				<spring:message code="sector.sector_no"/> --%>
				<spring:message code="mat.mat_use"/>
			</th>
			<th>구매 신청</th>
		</tr>
	</thead>
	<tbody id="listbody"></tbody>
	<tfoot>
		<tr>
			<td colspan="7">
				<nav id="pagingArea">${pagingVO.pagingHTML }</nav>
			</td>
		</tr>
	</tfoot>
</table>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
	var listbody = $("#listbody");
	var searchForm = $("#searchForm").paging({
		searchUI : "#searchUI",
		searchBtn : "#searchBtn",
		pagination : "#pagingArea",
		pageParam : "page",
		byAjax : true,
		success : function(resp){
			let matList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(matList.length > 0){
				$.each(matList, function(idx,mat){
					let trTag = $("<tr>").append(
						$("<td>").text(mat.rnum),
						$("<td>").text(mat.mat_no),
						$("<td>").text(mat.mat_name),
						$("<td>").text(mat.mat_stock),
						$("<td>").text(mat.mat_safe_stock),
						$("<td>").text(mat.mat_use == 'G001' ? '사용중' : '사용중지'),
						$("<td>").html(
							$("<a>").attr("href", "${cPath }/enter/mat/buyorder/"+mat.mat_no)
							.text("구매 신청")			
						)
					).data("mat_no",mat.mat_no);
					trTags.push(trTag);
				});
			$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
					$("<td colspan='7'>").text("조건에 맞는 상품이 없습니다.")		
				));
				$("#pagingArea").empty();
			}
			
			$("#listbody").html(trTags);
			listbody.data("currentPage",resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();
</script>
