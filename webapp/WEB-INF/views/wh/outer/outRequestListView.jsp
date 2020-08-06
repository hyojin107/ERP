<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>출고관리 : 출고신청서 목록들이 보여진다. (출하지시서)목록보여주기 </h1>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">출하지시서 상세보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
			 <button type="button" class="btn btn-primary" >상품출고</button>
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div>
	<form:form id="searchForm" action="${pageContext.request.contextPath }/outer/doc" method="get">
		<!-- 탭 -->
		<ul class="nav nav-pills nav-tabs">
		  <li class="nav-item" id="status_all">
		    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
		  </li>
		  <li class="nav-item" id="status_ing">
		    <a class="nav-link" data-toggle="tab" href="#">진행중</a>
		  </li>
		  <li class="nav-item" id="status_finish">
		    <a class="nav-link" data-toggle="tab" href="#">출고완료</a>
		  </li>
		</ul>
		<input type="hidden" name="status" id="status" value=""/> <!-- 진행상태 넘겨주기 -->
		<table border="1" class="table table-striped">
			<tr>
				<th>작성 일자</th>
				<td>
					<input type="date" name="startDay"/>~<input type="date" name="endDay"/>
				</td>
				<td><input type="button" class="btn btn-primary" value="검색" id="searchBtn"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="emp_name">
				</td>
				<td colspan="2"></td>
			</tr>
		</table>
	</form:form>
</div>
<br/><br/>
<table border="1"  class="table">
	<thead class="table-primary">
		<tr>
			<th>No.</th>
			<th>문서 유형</th>
			<th>부서 명</th>
			<th>작성자</th>
			<th>작성일자</th>
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
	// 탭
	//전체
	$("#status_all").on("click", function(){
		$("#status").val("");
		searchBtn.click();
		$("#delBtn").hide();
	});
	//진행중
	$("#status_ing").on("click", function(){
		$("#status").val("OR01");
		searchBtn.click();
		$("#delBtn").show();
	});
	//입고 완료
	$("#status_finish").on("click", function(){
		$("#status").val("OR02");
		searchBtn.click();
		$("#delBtn").hide();
	});
	
	var listbody = $("#listbody");
	var searchForm = $("#searchForm").paging({
		searchUI : "#searchUI",
		searchBtn : "#searchBtn",
		pagination : "#pagingArea",
		pageParam : "page",
		byAjax : true,
		success : function(resp){
			let docList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			console.log(docList);
			let trTags = [];
			if(docList.length > 0){
				$.each(docList,function(idx,doc){
					let trTag = 
						$("<tr>").append(
							$("<td>").text(doc.rnum),
							$("<td>").text(doc.code),
							$("<td>").text(doc.dep_name),
							$("<td>").text(doc.emp_name),
							$("<td>").text(doc.write_date)
						).data("board_no",doc.board_no);
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
					$("<td colspan='5'>").text("조건에 맞는 상품이 없습니다.")	
				));
				$("#pagingArea").empty();
			}
			
			$("#listbody").html(trTags);
			listbody.data("currentPage",resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();
	
	// 모달창 띄우기 
	var sampleModal = $("#exampleModal").modal({
		show:false
	}).on("hidden.bs.modal",function(){
		sampleModal.find(".modal-body").empty();
		sampleModal.data("board_no","");
	});

	function loadProdView(board_no){
		$.ajax({
			url : "<c:url value='/outer/doc/order/'/>"+board_no,
			dataType : "html",
			// Accept : 
			// html > text/html, Content-Type:text/html
			// json >  application/json 
			success : function(resp) {
				sampleModal.find(".modal-body").html(resp);
				sampleModal.data("board_no",board_no);
				sampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":"
						+ errorResp.responseText);
			}
		});
	}
	
	// 새창띄우기 
	var listBody = $("#listbody").on("click","tr",function(){
		let board_no = $(this).data("board_no");
		let url = "<c:url value='/outer/doc/order/'/>"+board_no;
		let _width = '900';
		let _height = '500';
		let _left = Math.ceil((window.screen.width - _width)/2);
		let _top = Math.ceil((window.screen.width - _height)/6);
		let popupOption = "width="+_width+", height="+_height+", left="+_left+", top="+_top;
		window.open(url,"",popupOption);
// 		loadProdView(board_no);
	}).css({cursor:"pointer"});
	
	
</script>