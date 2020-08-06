<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>전표인쇄</h1><br>
<a href="${cPath }/account/chit"><button class="btn btn-success mr-2" >전체</button></a>
<a href="${cPath }/account/chit?sign_status=goin"><button class="btn btn-success mr-2" >요청</button></a>
<a href="${cPath }/account/chit?sign_status=sign"><button class="btn btn-success mr-2" >승인</button></a>
<form id="searchForm" action="${cPath }/account/chit">
<table>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
					<div class="form-inline d-flex ml-md-auto d-print-none"
						id="searchUI">
						<text>전표일자</text>
						<input type="date" name='chit_date'>
						<text>매출/매입</text>
						<select class="form-control mr-2" name='buy_sell'>
							<option value="">
								<spring:message code='all' />
							</option>
							<option value="매출" ${'sell' eq chitVO.buy_sell?"selected":"" }>매출</option>
							<option value="매입" ${'buy' eq chitVO.buy_sell?"selected":"" }>
								매입</option>
						</select>
						<text>거래처</text>
						<input type="text" class="form-control mr-2" name="buyer_name"
							value="${chitVO.buyer_name }"
							onkeyup="event.keyCode==13?$('#searchBtn').trigger('click'):'';">
						<input class="btn btn-success mr-2" type="button"
							value="<spring:message code='search'/>" id="searchBtn">
					</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th><input type="checkbox"></th>
			<th>전표코드</th>
			<th>전표일자</th>
			<th>매출/매입</th>
			<th>거래처명</th>
			<th>가액</th>
			<th>전표상태</th>
		</tr>
	</thead>
	<tbody id="listBody">

	</tbody>
	<tfoot>
		<tr>
			<td colspan="7">
				<div class="d-block d-md-flex align-items-center d-print-none">
					<div class="form-inline d-flex ml-md-auto d-print-none"
						id="searchUI"></div>
					<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
						${pagingVO.pagingHTML }</nav>
				</div>
				<button class="btn btn-success">인쇄</button> 
			</td>
		</tr>
	</tfoot>
</table>

	<input type="hidden" name="page" value="${param.page }" />
</form>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">전표 상세내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">인쇄</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
var listBody = $("#listBody");
var searchForm = $("#searchForm").paging({
	searchUI:"#searchUI",
	searchBtn:"#searchBtn",
	pagination:"#pagingArea",
	pageParam:"page",
	byAjax:true,
	success:function(resp){
		let chitList = resp.dataList;
		let pagingHTML = resp.pagingHTML;
		let trTags = [];
		if(chitList.length>0){
			$.each(chitList, function(idx, chit){
				let trTag = $("<tr>").append(
								$("<td>").html("<input type='checkbox'>")
								, $("<td>").text(chit.chit_no)
								, $("<td>").text(chit.chit_date)
								, $("<td>").text(chit.buy_sell)
								, $("<td>").text(chit.buyer_name)
								, $("<td>").text(chit.pay)
								, $("<td>").text(chit.pay)
								).data("chit_no", chit.chit_no);;
				trTags.push(trTag);
			});
			$("#pagingArea").html(pagingHTML);
		}else{
			trTags.push($("<tr>").html($("<td colspan='7'>").text("조건에 맞는 전표가 없습니다.")));
			$("#pagingArea").empty();
		}
		listBody.html(trTags);
		listBody.data("currentpage", resp.currentPage);
		searchForm.find("[name='page']").val("");
	}
}).submit();

var exampleModal = $("#exampleModal").modal({
	show:false
}).on("hidden.bs.modal", function(){
	exampleModal.find(".modal-body").empty();
});

function loadChitView(chit_no){
	$.ajax({
		url : "<c:url value='/account/chit/'/>"+chit_no,
		dataType : "html", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			exampleModal.find(".modal-body").html(resp);
			exampleModal.modal("show");
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
}
$("#listBody").on("click", "tr", function(){
	let chit_no = $(this).data("chit_no");
	loadChitView(chit_no);
}).css({cursor:"pointer"});
</script>