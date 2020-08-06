<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">생산의뢰서 상세보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<h1>출고관리 : 생산팀으로 요청했던 생산의뢰서의 목록들을 보여준다. </h1>

<div>
	<form:form id="searchForm" action="${pageContext.request.contextPath }/outer/prod/pduct" method="get">
		<table border="1" class="table">
			<tr>
				<th>
					<spring:message code="writer"/>
				</th>
				<td><input type="text" name="emp_name"/></td>
				<td><input type="button" class="btn btn-primary" value="검색" id="searchBtn"/></td>
			</tr>
			<tr>
				<th>
					<spring:message code="pductor.porder_confirm"/>
				</th>
				<td>
					<select name="porder_confirm">
						<option value="">확인여부</option>
						<option value="Y">확인</option>
						<option value="N">대기중</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>
					<spring:message code="writedate"/>
				</th>
				<td colspan="3">
					<input type="date" name="startDay"/>~<input type="date" name="endDay"/>
				</td>
			</tr>
			
		</table>
	</form:form>
</div>
<br/><br/>
<table border="1"  class="table">
	<thead  class="table-primary">
		<tr>
			<th>No.</th>
			<th>
				<spring:message code="pductor.poroder_no"/>
			</th>
			<th>
				<spring:message code="pductor.emp_name"/>
			</th>
			<th>
				<spring:message code="pductor.porder_date"/>
			</th>
			<th>
				<spring:message code="pductor.porder_confirm"/>
			</th>
		</tr>
	</thead>
	<tbody id="listbody"></tbody>
	<tfoot>
		<tr>
			<td colspan="5">
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
			let pductList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			console.log(pductList);
			let trTags = [];
			if(pductList.length > 0){
				$.each(pductList,function(idx,pduct){
					let trTag = 
						$("<tr>").append(
							$("<td>").text(pduct.rnum),
							$("<td>").text(pduct.porder_no),
							$("<td>").text(pduct.emp_name),
							$("<td>").text(pduct.porder_date),
							$("<td>").text(pduct.porder_confirm == 'Y' ? '확인' : '대기중')
						).data("porder_no",pduct.porder_no);
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
					$("<th colspan='5'>").text("조건에 맞는 게시글이 없습니다.")	
				));
				$("#pagingArea").empty();
			}
			
			$("#listbody").html(trTags);
			listbody.data("currentPage",resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();
	
	// 모달창
	var sampleModal = $("#exampleModal").modal({
	show:false
	}).on("hidden.bs.modal",function(){
		sampleModal.find(".modal-body").empty();
		sampleModal.data("porder_no","");
	});
	
	function loadProductOrView(porder_no){
		$.ajax({
			url : "<c:url value='/outer/prod/pduct/'/>"+porder_no,
			dataType : "html",
			// Accept : 
			// html > text/html, Content-Type:text/html
			// json >  application/json 
			success : function(resp) {
				sampleModal.find(".modal-body").html(resp);
				sampleModal.data("porder_no",porder_no);
				sampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":"
						+ errorResp.responseText);
			}
		});
	}
	
	var listBody = $("#listbody").on("click","tr",function(){
		let porder_no = $(this).data("porder_no");
		loadProductOrView(porder_no);
		}).css({cursor:"pointer"});
		
</script>