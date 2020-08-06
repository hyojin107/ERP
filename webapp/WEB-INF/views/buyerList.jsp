<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 2        송효진      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<h2>거래처 조회</h2>

<div class="form-inline" id="searchUI"> <!-- 데이터 입력 시에만 -->
	<select name="searchType" class="form-control mr-2">
		<option value="all" ${pagingVO.searchVO.searchType eq 'all'?"selected":"" }>전체</option>
		<option value="name" ${pagingVO.searchVO.searchType eq 'name'?"selected":"" }>거래처명</option>
		<option value="rep" ${pagingVO.searchVO.searchType eq 'rep'?"selected":"" }>대표자명</option>
	</select>
	<input type="text" class="form-control mr-2" name="searchWord"
		value="${pagingVO.searchVO.searchWord }"
	>
	<input class="btn btn-success" type="button" value="검색" id="searchBtn">
</div>

<table class="table table-hover">
	<thead>
		<tr>
			<th scope="col">#</th>
			<th scope="col">거래처코드</th>		
			<th scope="col">거래처명</th>		
			<th scope="col">대표자명</th>		
			<th scope="col">담당자명</th>		
			<th scope="col">담당자 이메일</th>		
		</tr>
	</thead>
	<tbody id="listBody" data-toggle="modal" data-target="#exampleModal">

	</tbody>
</table>

<nav id="pagingArea" aria-label="...">
	${pagingVO.pagingHTML }
</nav>

<form id="searchForm" action="${cPath }/buyer/buyerList">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType"value="${pagingVO.searchVO.searchType }" />
	<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
</form>

<!-- 상세보기 Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">거래처 정보 상세 조회</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      </div>
      <div class="modal-footer">
        <button type="button" id="updateBtn" class="btn btn-primary mr-2">수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
	<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
</form>

<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>
<script type="text/javascript">
	//상세보기
	var exampleModal = $("#exampleModal").modal({
		show:false
	}).on("hidden.bs.modal", function(){		//모달창이 닫혔으면
		exampleModal.find(".modal-body").empty();
		exampleModal.data("prodid", "");
	});
	
	function loadBuyerView(buyer_no){
		$.ajax({
			url : "<c:url value='/buyer/'/>" + buyer_no,
			dataType : "html",
			success : function(resp) {
				exampleModal.find(".modal-body").html(resp);
				exampleModal.data("buyer_no", buyer_no);
				exampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	var listBody = $("#listBody").on("click", "tr", function(){
		let buyer_no = $(this).data("buyer_no");
		loadBuyerView(buyer_no);
	}).css({ cursor:"pointer" });  //tr태그에 마우스를 오버해도, 손모양으로 보이게 함
	
	var currenturl = "${cPath}" + "${requestScope['javax.servlet.forward.servlet_path']}"; 
	$("#updateBtn").on("click", function(){
		let buyer_no = exampleModal.data("buyer_no");
		let currentPage = listBody.data("currentpage");
		if(currenturl.search("account")>0){
			location.href="${cPath }/account/basic/buyer/"+buyer_no+"/form?currentPage="+currentPage;
		}else{
			location.href="${cPath }/buyer/"+buyer_no+"/form?currentPage="+currentPage;			
		}
	});
	
	
	
	//페이지네이션
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,	//false이면 동기, true면 비동기 방식으로 처리 한다는 뜻 (기본값은 false로서 동기구조임)
		success:function(resp){
			let buyerList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(buyerList.length>0){
				$.each(buyerList, function(idx, buyer){
					let trTag = $("<tr>").append(
									$("<td>").text(buyer.rnum)
									, $("<td>").text(buyer.buyer_no)
									, $("<td>").text(buyer.buyer_name)
									, $("<td>").text(buyer.buyer_rep)
									, $("<td>").text(buyer.charger_name)
									, $("<td>").text(buyer.charger_email)
								).data("buyer_no", buyer.buyer_no);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='8'>").text("조건에 맞는 거래처가 없습니다.")));
			}
			listBody.html(trTags);			
			listBody.data("currentpage", resp.currentPage);
			$("#pagingArea").html(pagingHTML);
			searchForm.find("[name='page']").val("");
		}
	}).submit();
</script>

