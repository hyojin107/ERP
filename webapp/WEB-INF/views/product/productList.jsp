<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2020. 7. 6      작성자명 박정민      최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
 
 
 
<table class="table table-bordered">
  <thead>
    <tr>
      <th scope="col">상품오더 번호</th>
      <th scope="col">오더 사원이름</th>
      <th scope="col">생산 품목</th>
      <th scope="col">오더한 날짜</th>
    </tr>
  </thead>
  <tbody id = "tablebody">

  </tbody>
  
  <tfoot>
  <tr>
   <td colspan="7">
    <nav aria-label="..."></nav>
       ${pagingVO.pagingHTML }
       <div class="form-inline" id="searchUI">
					<select name="searchType" class="form-control mr-2">
						<option value="all" ${pagingVO.searchVO.searchType eq 'all'?"selected":"" }>전체</option>
						<option value="emp" ${pagingVO.searchVO.searchType eq 'emp'?"selected":"" }>직원이름</option>
						<option value="orderno" ${pagingVO.searchVO.searchType eq 'orderno'?"selected":"" }>생산번호</option>
					</select>
					<input type="text" class="form-control mr-2" name="searchWord"
						value="${pagingVO.searchVO.searchWord }"
					>
					<input class="btn btn-success" type="button" value="검색" id="searchBtn">
				</div>
    </td>
  </tr>
  </tfoot>
</table>

<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원 정보 상세 조회</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id = "modalbody">
      
      </div>
      <div class="modal-footer">
      
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="OrderFirm(event)">의뢰확정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<form id="searchForm" action = "${cPath }/product">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
	<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
</form>

<script type="text/javascript" src="${cPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script>


$('#tablebody').on("click",'tr', function() {
	
	var modal = $(this);
	var modalbody = $(".modal-body")
	
	modalbody.load(modal.data("remote"));

}).css({
		cursor:"pointer"
	});


var listBody = $("#tablebody");
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
			$.each(boardList, function(idx, prod){
				let trTag = $("<tr data-toggle = 'modal' data-target = '#viewModal' data-remote='${cPath }/product/"+prod.porder_no+"'>").append(
						
								$("<td>").text(prod.porder_no)
								, $("<td>").text(prod.emp_name)
								, $("<td>").text(prod.prod_name)
								, $("<td>").text(prod.porder_date));
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


function OrderFirm(evn){
	
	let form = $("#modalbody").find(".table")
	let formorder = form.data("order")
	let formurl = form.data("url")
	let data = { "porder_no" : formorder }
	
	console.log(formorder + " " +  formurl +" _ " ) 
	
	$.ajax({

	url : formurl,
	async : false,
	data : { porder_no : formorder},
	method : "post",
	dataType : "text", // Accept,text/html , Content-Type:text/html accept와 
	success : function(resp) {
	 	alert(resp)
	},
	error : function(error) {

	 	alert(error)
		console.log(error.status + " : " + error.responseText);
	}
})

searchForm.submit();

}
</script>


