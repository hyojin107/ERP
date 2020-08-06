%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>퇴직금 추계액 산출</h1>  
<thead class="table-primary">
			
		<tr  class="row">
			<td class="col-1">날짜</td>
			<td class="col-1"><input type="date"></td>
		</tr>
		<tr>		
			<td class="col-1">부서</td>
			<td class="col-1 form-inline">
			 
				<select class="dynamicElement  mr-2" name="dep_no2"
					data-url="<c:url value='getdepartmentList'/>">
					<option value>부서명</option>
				</select>
			 
			</td>
			<td class="col-1">소속팀</td>
			<td class="col-1 form-inline">
					 <select class="dynamicElement  mr-2" name="dep_no"
						data-url="<c:url value='getTeamList' />">
						<option value>소속 팀</option>
					</select>
			</td>
			<td class="col-1"><input type="button" value="검색"></td>
		</tr> 

</thead>
<div>   
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>No.</th>
			<th>부서</th>
			<th>소속</th>
			<th>직급</th>
			<th>사원ID</th>
			<th>성명</th>
			<th>구분</th>
			<th>입사일</th>
			<th>퇴직일</th>
			<th>최근3개월 월급여 총액</th>
			<th>기준급여</th>
			<th>근속일수</th>
			<th>퇴직금 추계액</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
<%-- 	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<select name="searchType" class="form-control mr-2">
						<option value="" ${empty pagingVO.searchVO.searchType?"selected":"" }>
							<spring:message code="all" />
						</option>
						<option value="title" ${pagingVO.searchVO.searchType eq 'title'?"selected":"" }>
							<spring:message code="title" />
						</option>
						<option value="writer" ${pagingVO.searchVO.searchType eq 'writer'?"selected":"" }>
							<spring:message code="writer" />
						</option>
						<option value="content" ${pagingVO.searchVO.searchType eq 'content'?"selected":"" }>
							<spring:message code="content" />
						</option>
					</select>
					<input type="text" class="form-control mr-2" name="searchWord"
						value="${pagingVO.searchVO.searchWord }"
						onkeyup="event.keyCode==13?$('#searchBtn').trigger('click'):'';"
					>
					<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn">
					<input class="btn btn-success mr-2" type="button" value="<spring:message code='newBoard'/>" 
						onclick="location.href='<c:url value="/board/form"/>';"
					>
					
				</div>
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
				</div>
			</td>
		</tr>
	</tfoot> --%>
</table>
</div>
<%-- <form id="searchForm" action="${pageContext.request.contextPath }/board">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
</form> --%>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paiging.js"></script>
<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let boardList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(boardList.length>0){
				$.each(boardList, function(idx, board){
					let trTag = $("<tr>").append(
									$("<td>").text(board.rnum)
									, $("<td>").html(
										$("<a>").attr("href", "${pageContext.request.contextPath }/board/"+board.bo_no)
												.html(board.bo_title)													
									)
									, $("<td>").text(board.bo_writer)
									, $("<td>").text(board.bo_date)
									, $("<td>").text(board.bo_hit));
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html($("<td colspan='8'>").text("조건에 맞는 게시글이 없음.")));
				$("#pagingArea").empty();
			}
			listBody.html(trTags);
			listBody.data("currentpage", resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();

</script>

<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/paiging.js?time=${System.currentTimeMillis()}"></script>
	
	<script type="text/javascript">
		// 옵션 선택시 
		var optionPtrn = "<option value='%V'>%T</option>";
		var departmentCode = $("select[name='dep_no2']").data( // 부서코드
				"success",
				function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
					var html = "";
					$.each(resp, function(idx, dep) {
						html += optionPtrn.replace("%V", dep.dep_no2)
								.replace("%T", dep.dep_name);
					});
					departmentCode.append(html);
				}).on("change", function() {  // 부서 선택 마다 소속팀이 바뀌는거 
			let dep_no2 = $(this).val();

			dep_no.trigger("renew", {
				dep_no2 : dep_no2
			});
		});

		var dep_no = $("select[name='dep_no']").data( // 소속 팀
				"success",
				function(resp) {
					var html = "<option value>소속팀</option>";
					$.each(resp, function(idx, buyer) {
						html += optionPtrn.replace("%V", dep.dep_no)
								.replace("%T", dep.dep_name);
					});
					dep_no.html(html);
				});

		$(".dynamicElement").dynamicSelect();
	</script>