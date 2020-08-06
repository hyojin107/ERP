<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 2        송효진      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>구매요청 현황</h2>
<div id="searchUI">	<!-- 검색 -->
	<!-- 탭 -->
	<ul class="nav nav-pills nav-tabs">
	  <li class="nav-item" id="status_all">
	    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
	  </li>
	  <li class="nav-item" id="status_ing">
	    <a class="nav-link" data-toggle="tab" href="#">진행중</a>
	  </li>
	  <li class="nav-item" id="status_ok">
	    <a class="nav-link" data-toggle="tab" href="#">발주완료</a>
	  </li>
	</ul>
	<br>
	 작성일자 <input type="date" name="doc_date"/> ~ <input type="date" name="doc_dateEnd"/>
	<br>
	작성자명 <input type="button" id="empBtn" value="찾기"/>
	<input type="text" name="emp_no" id="empNo" readonly/><input type="text" id="empName" readonly/>
	<br/><input type="button" id="searchBtn" value="검색"/>
</div>

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">요청코드</th>
      <th scope="col">작성일자</th>
      <th scope="col">구매 개수</th>
      <th scope="col">작성자</th>
    </tr>
  </thead>
  <tbody id="listBody" data-toggle="modal" data-target="#exampleModal">
  	<!-- 테이블 -->
  </tbody>
</table>
<input type="button" id="delBtn" value="삭제" style="display:none;"/>
<br>

<!-- 검색어 보내기 -->
<form id="searchForm" action="${cPath }/buy/document">
	<input type="hidden" name="page" />
	<input type="hidden" name="doc_date"value="" />
	<input type="hidden" name="doc_dateEnd" value=""/>
	<input type="hidden" name="emp_no" value=""/>
	<input type="hidden" name="status" id="status" value=""/>	<!-- 구매 상태 -->
	<!-- value값은  id가 searchUI인 태그를 찾아, 그 안에 name값이 같은 것들을 찾아와서 이곳에 주입시켜줌-->
</form>

<!-- 상세보기 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>
<script type="text/javascript">
	
	//전체
	$("#status_all").on("click", function(){
		$("#status").val("");
		searchBtn.click();
		$("#delBtn").hide();
	});
	//진행중
	$("#status_ing").on("click", function(){
		$("#status").val("Q001");
		searchBtn.click();
		$("#delBtn").show();
	});
	//매입 완료
	$("#status_ok").on("click", function(){
		$("#status").val("Q002");
		searchBtn.click();
		$("#delBtn").hide();
	});
	
	
	//페이지네이션 + 검색
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,	//false이면 동기, true면 비동기 방식으로 처리 한다는 뜻 (기본값은 false로서 동기구조임)
		success:function(resp){
			let docList = resp.dataList;
			buyDocList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(docList.length>0){
				$.each(docList, function(idx, doc){
					let trTag = $("<tr>").attr({scope:"row"}).append(
									$("<th/>").html($("<input/>").addClass('listCheck').attr({type:"checkbox"}))
									, $("<td/>").addClass('buy_no').text(doc.buy_no)
									, $("<td/>").text(doc.doc_date)
									, $("<td/>").text(doc.matCnt)
									, $("<td/>").text(doc.emp_name)
								).data("buyNo", doc.buy_no);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='5'>").text("조건에 맞는 요청서가 없습니다.")));
			}
			listBody.html(trTags);			
			listBody.data("currentpage", resp.currentPage);
			$("#pagingArea").html(pagingHTML);
			searchForm.find("[name='page']").val("");
		}
	}).submit();
	
	
	var exampleModal = $("#exampleModal").modal({
	    show:false
	 }).on("hidden.bs.modal", function(){
	    exampleModal.find(".modal-body").empty();
	 });
	 //사원 목록 모달창
	 modalView({
	   noText : "#empNo",      //사원 클릭 시, 입력될 태그 지정
	   nameText : "#empName",  //사원 클릭 시, 입력될 태그 지정
	   clickBtn : "#empBtn",        //모달창을 띄울 버튼 지정
	    urlPath : "${cPath}/buy/document/empModal",
	    title:"사원 목록"            //제목
	 });
	 
	 
	//발주 등록으로 이동
	$(document).on("click", "#orderBtn", function(){
		$("input[class=listCheck]:checked").each(function() {
			let noClass = $(this).parent().parent().find(".buy_no").text();
			let inputTag = "<input type='hidden' name='buy_no' value='"+ noClass +"'/>"; 
			$("#buyNoList").append(inputTag);
		});
		$("#buyNoForm").submit();
	});
	 
	
	// 체크박스 부분 모달 이벤트 삭제
	$(document).on("click", "th", function(event){
		event.stopPropagation();
	});
	//요청서 모달창
	var buyDocList;
	var listBody = $("#listBody").on("click", "td", function(){
		let buyNo = $(this).parent().data("buyNo");
		let docVO;
		if(buyDocList.length>0){
			$.each(buyDocList, function(idx, doc){
				if(doc.buy_no == buyNo){
					docVO = doc;
				}
			});
		}else{
			console.log("buyDocList의 데이터가 존재하지 않습니다");
		}
		loadDocView(docVO);
	});
	
	function loadDocView(docVO){ //상세보기 데이터 삽입
		$("#exampleModalLabel").text("구매요청서 목록");
		let view = $("<table>").addClass("table table-bordered").append(
				$("<tr>").append($("<th>").text("구매요청코드"), $("<td>").text(docVO.buy_no)  ),
				$("<tr>").append($("<th>").text("작성일자"), $("<td>").text(docVO.doc_date)  ),
				$("<tr>").append($("<th>").text("구매 갯수"), $("<td>").text(docVO.matCnt)  ),
				$("<tr>").append($("<th>").text("담당자"), $("<td>").text(docVO.emp_name)  ),
				$("<tr>").append($("<th>").text("담당자 부서"), $("<td>").text(docVO.dep_name)  )
		);
		//서브테이블 만들기
		let matTr = "<tr><td colspan='2'>";
		matTr += "<table><h4>구매요청 물품</h4>";
		matTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격</th><th>규격단위</th><th>수량</th><th>요청상태</th></tr>";
		for(var i=0; i<docVO.matList.length; i++){
			matTr += "<tr><td>"+docVO.matList[i].mat_no+"</td>";
			matTr += "<td>"+docVO.matList[i].matVO.mat_name+"</td>";
			matTr += "<td>"+docVO.matList[i].matVO.lprodVO.lprod_name+"</td>";
			matTr += "<td>"+docVO.matList[i].matVO.mat_standard+"</td>";
			matTr += "<td>"+docVO.matList[i].matVO.mat_stand_size+"</td>";
			matTr += "<td>"+docVO.matList[i].qty+"</td>";
			matTr += "<td>"+docVO.matList[i].doc_status+"</td></tr>";
		}
		matTr += "</table></td></tr>";
		view.append(matTr);
		
		exampleModal.find(".modal-body").html(view);
		exampleModal.data("buyNo", docVO.buy_no);
		exampleModal.modal("show");
	}
	
	
	//삭제
	$("#delBtn").on("click", function(){
		let buyList = [];
		$("input[class=listCheck]:checked").each(function() {
			let buy_no = $(this).parent().parent().find(".buy_no").text();
			buyList.push(buy_no);
		});
		jsonData = {buy_noList : buyList};
		$.ajax({
			url : "${cPath}/buy/document",
			contentType : "application/json",
			data : JSON.stringify(jsonData),
			method : "DELETE",
			dataType : "text",
			success : function(resp) {
				alert(resp);
				searchBtn.click();
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	});
	
</script>




