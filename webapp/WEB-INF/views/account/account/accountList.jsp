<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>계정관리</h1><br>
<a href="${cPath }/account/basic/account"><button class="btn btn-success mr-2" ><spring:message code='account'/></button></a>
<a href="${cPath }/account/basic/account/summary"><button class="btn btn-success mr-2" ><spring:message code='summary'/></button></a>
<div class="d-block d-md-flex align-items-center d-print-none">
<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
	<select name="searchType" class="form-control mr-2">
		<option value="" ${empty pagingVO.searchVO.searchType?"selected":"" }>
			<spring:message code='all'/>
		</option>
		<option value="account_no" ${pagingVO.searchVO.searchType eq 'account_no'?"selected":"" }>
			<spring:message code='account_no'/>
		</option>
		<option value="account_name" ${pagingVO.searchVO.searchType eq 'account_name'?"selected":"" }>
			<spring:message code='account_name'/>
		</option>
	</select>
	<input type="text" class="form-control mr-2" name="searchWord"
		value="${pagingVO.searchVO.searchWord }"
		onkeyup="event.keyCode==13?$('#searchBtn').trigger('click'):'';"
	>
	<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn">
</div>
</div>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>#</th>
			<th>구분</th>
			<th><spring:message code="stand_name"/></th>
			<th><spring:message code="account_no"/></th>
			<th><spring:message code="account_name"/></th>
			<th><spring:message code="etc"/></th>
			<th><spring:message code="use"/></th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
		<tfoot>
		<tr>
			<td colspan="7">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
				</div>
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
				</div>
			</td>
		</tr>
	</tfoot>
</table>
				<a href="<c:url value='/account/basic/account/form'/>"><button class="btn btn-success">신규등록</button></a>
<form id="searchForm" action="${cPath }/account/basic/account">
	<input type="hidden" name="page"/>
	<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
	<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
</form>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">계정 상세내역</h5>
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


<script type="text/javascript" src="${cPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript" src="${cPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">


var upBtn = $("#upBtn").on("click", function(event){
	if('수정' == upBtn.text()){
		upBtn.text('등록');
		exampleModal.find('input').not('.code').removeAttr('readonly');
		exampleModal.find('select').not('.code').removeAttr('disabled');
		exampleModal.find('textarea').removeAttr('readonly');
		return;
	}
	var form = exampleModal.find("form")[0]; 
	var data = new FormData(form);
	var account_no = exampleModal.find("input[name='account_no']").val()*1;
	$.ajax({
		url : "${cPath}${currentAction}"+account_no,
		 processData: false,
         contentType: false,
		data : data,
		method : "put",
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			if(resp==1){
				alert('수정 성공');
				loadAccountView(account_no);
				upBtn.text('수정');
			}else alert('수정 실패');
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
	
});
	
var searchForm = $("#searchForm").paging({
	searchUI:"#searchUI",
	searchBtn:"#searchBtn",
	pagination:"#pagingArea",
	pageParam:"page",
	byAjax:true,
	success:function(resp){
		let accountList = resp.dataList;
		let pagingHTML = resp.pagingHTML;
		let trTags = [];
		if(accountList.length>0){
			$.each(accountList, function(idx, account){
				let trTag = $("<tr>").append(
								$("<td>").text(idx+1)
								, $("<td>").text(account.division)
								, $("<td>").text(account.stand_name)
								, $("<td>").text(account.account_no)
								, $("<td>").text(account.account_name)
								, $("<td>").text(account.etc==null?'N/A':account.etc)
								, $("<td>").text(account.use_status)
							).data("account_no", account.account_no);
				trTags.push(trTag);
			});
		}else{
			trTags.push($("<tr>").html($("<td colspan='7'>").text("조건에 맞는 계정과목이 없음")));
		}
		$("#listBody").html(trTags);			
		$("#pagingArea").html(pagingHTML);
	}
});

searchForm.submit();

var exampleModal = $("#exampleModal").modal({
	show:false
}).on("hidden.bs.modal", function(){
	exampleModal.find(".modal-body").empty();
	upBtn.text('수정');
	searchForm.submit();
});

function loadAccountView(account_no){
	$.ajax({
		url : "<c:url value='/account/basic/account/'/>"+account_no,
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

<c:if test="${not empty lastUpdateAccount}">
	loadProdView("${lastUpdateAccount.account_no}");
	<c:remove var="lastUpdateAccount" scope="session"/>
</c:if>

$("#listBody").on("click", "tr", function(){
	let account_no = $(this).data("account_no");
	loadAccountView(account_no);
}).css({cursor:"pointer"});
</script> 