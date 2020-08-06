<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>고정자산등록</h1><br>
<form id="searchForm" action="${cPath }/account/fixAssets">
<input type="hidden" name="page" value="${param.page }"/>
<input type="hidden" name="account_no"/>
<input type="hidden" name="assets_name"/>
</form>
		<div class="d-block d-md-flex align-items-center d-print-none">
		<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
			<text>계정과목</text>
			<select name="account_no" class="form-control mr-2">
				<option value="">
					<spring:message code='all'/>
				</option>
				<c:forEach items="${accountList }" var="account">
					<option value="${account.account_no }"
					${account.account_no==pagingVO.detailSearch.account_no?"selected":"" } >${account.account_name }</option>
				</c:forEach>
			</select>
			<text>자산명</text>
			<input type="text" class="form-control mr-2" name="assets_name"
				value="${pagingVO.detailSearch.assets_name }">
			<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn">
		</div>
		</div>

<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>고정자산코드</th>
			<th>계정과목</th>
			<th>자산명</th>
			<th>취득일</th>
			<th>상각방법</th>
			<th>잔존가액</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
		<tfoot>
		<tr>
			<td colspan="6">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
				</div>
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
				</div>
				<a href="<c:url value='/account/fixAssets/form'/>"><button class="btn btn-success">신규등록</button></a>
			</td>
		</tr>
	</tfoot>
</table>


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">고정자산 상세내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id='upBtn'>수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
var exampleModal = $("#exampleModal").modal({
	show:false
}).on("hidden.bs.modal", function(){
	exampleModal.find(".modal-body").empty();
	upBtn.text('수정');
});

var upBtn = $("#upBtn").on("click", function(event){
	if('수정' == upBtn.text()){
		upBtn.text('등록');
		exampleModal.find('.form-control').not('.code').removeAttr('readonly');
		exampleModal.find('.form-control').not('.code').removeAttr('disabled');
		return;
	}
	var form = exampleModal.find("form")[0]; 
	var data = new FormData(form);
// 	data.append("file", $("#input_img")[0].files[0]);
	var fixassets_no = exampleModal.find("input[name='fixassets_no']").val();
	$.ajax({
		url : "${cPath}${currentAction}"+fixassets_no,
		 processData: false,
         contentType: false,
         type : 'post',
		data : data,
		dataType : "text", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
				alert(resp);
				upBtn.text('수정');
				exampleModal.find('.form-control').not('.code').attr('readonly','readonly');
				exampleModal.find('.form-control').not('.code').attr('disabled','disabled');
				loadAccountView(fixassets_no);
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
	
});
var listBody = $("#listBody");
var searchForm = $("#searchForm").paging({
	searchUI:"#searchUI",
	searchBtn:"#searchBtn",
	pagination:"#pagingArea",
	pageParam:"page",
	byAjax:true,
	success:function(resp){
		let assetsList = resp.dataList;
		let pagingHTML = resp.pagingHTML;
		let trTags = [];
		if(assetsList.length>0){
			$.each(assetsList, function(idx, assets){
				let trTag = $("<tr>").append(
								$("<td>").text(assets.fixassets_no)
								, $("<td>").text(assets.account_name)
								, $("<td>").text(assets.assets_name)
								, $("<td>").text(assets.getdate)
								, $("<td>").text(assets.amor_way)
								, $("<td>").text(assets.getcost-assets.total)
								);
				trTags.push(trTag);
			});
			$("#pagingArea").html(pagingHTML);
		}else{
			trTags.push($("<tr>").html($("<td colspan='6'>").text("조건에 맞는 고정자산이 없습니다.")));
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

function loadAssetsView(fixassets_no){
	$.ajax({
		url : "<c:url value='/account/fixAssets/'/>"+fixassets_no,
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
	let fixassets_no = $(this).find("td").eq(0).text();
	loadAssetsView(fixassets_no);
}).css({cursor:"pointer"});
</script>