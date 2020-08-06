<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>출고관리 : 생산을 요청할 상품의 목록을 출력 (현 재고량 &lt; 안전 재고량 )</h1>

<div>
	<form:form id="searchForm" action="${cPath }/outer/prod" method="get">
		<table border="1" class="table">
			<tr>
				<th>
					<spring:message code="prod.prod_name"/>
				</th>
				<td><input type="text" name="prod_name"/></td>
				<th>
					<spring:message code="prod.prod_no"/>
				</th>
				<td><input type="text" name="prod_no"/></td>
				<td><input type="button" class="btn btn-primary" value="검색" id="searchBtn"/></td>
			</tr>
			
			<tr>
				<th>
					<spring:message code="prod.prod_out_price"/>
				</th>
				<td>
					<input type="number" name="startPrice"/>~<input type="number" name="endPrice"/>
				</td>
				<th>
					<spring:message code="prod.prod_validity"/>
				</th>
				<td colspan="2">
					<input type="date" name="startDay"/>~<input type="date" name="endDay"/>
				</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.lprod_no"/>
				</th>
				<td>
					<select name="lprod_no">
						<option value>상품 분류</option>
						<c:forEach items="${lprodList }" var="lprod">
							<option value="${lprod.lprod_no}">
								${lprod.lprod_name }
							</option>
						</c:forEach>
					</select>
				</td>
				<th>
					<spring:message code="prod.prod_use"/>
				</th>
				<td colspan="2">
					<select name="prod_use">
						<option value="">상태</option>
						<option value="G003">생산중</option>
						<option value="G004">생산중단</option>
					</select>
				</td>
			</tr>
		</table>
	</form:form><!-- 검색 form -->
</div>
<br/><br/>
<table border="1"  class="table">
	<thead class="table-primary">
		<tr>
			<th>
				<spring:message code="prod.rnum"/>
			</th>
			<th>
				<spring:message code="prod.prod_no"/>
			</th>
			<th>
				<spring:message code="prod.prod_name"/>
			</th>
			<th>
				<spring:message code="prod.prod_stock"/>
			</th>
			<th>
				<spring:message code="prod.prod_safe_stock"/>
			</th>
			<th>
				<spring:message code="prod.prod_stock_size"/>
			</th>
			<th>
				<spring:message code="prod.prod_out_price"/>
			</th>
			<th>생산신청</th>
		</tr>
	</thead>
	<tbody id="listbody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="13">
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
			let prodList = resp.dataList;
			console.log(prodList);
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(prodList.length > 0){
				$.each(prodList, function(idx,prod){
					let trTag = $("<tr>").append(
						$("<td>").text(prod.rnum),
						$("<td>").text(prod.prod_no),
						$("<td>").text(prod.prod_name),
						$("<td>").text(prod.prod_stock),
						$("<td>").text(prod.prod_safe_stock),
						$("<td>").text(prod.prod_stock_size),
						$("<td>").text(prod.prod_out_price),
						$("<td>").html(
							$("<a>").attr("href", "${cPath }/outer/prod/pduct/insert/"+prod.prod_no)
							.html("생산 신청")													
						)						
					).data("prod_no",prod.prod_no);
					trTags.push(trTag);
				});
			$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
					$("<td colspan='8'>").text("조건에 맞는 상품이 없습니다.")		
				));
				$("#pagingArea").empty();
			}
			$("#listbody").html(trTags);
			listbody.data("currentPage",resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();

</script>
