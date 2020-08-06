<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>매입 현황</h2>
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
	    <a class="nav-link" data-toggle="tab" href="#">입고완료</a>
	  </li>
	  <li class="nav-item" id="status_del">
	    <a class="nav-link" data-toggle="tab" href="#">매입취소</a>
	  </li>
	  <li class="nav-item" id="status_ret">
	    <a class="nav-link" data-toggle="tab" href="#">반품처리</a>
	  </li>
	</ul>
	 작성일자 <input type="date" name="pur_date"/> ~ <input type="date" name="pur_dateEnd"/>
	<br/>
	거래처 <input type="button" id="buyerBtn" value="찾기"/>
	<input type="text" name="buyer_no" id="buyer_no" readonly/><input type="text" id="buyer_name" readonly/>
	작성자명 <input type="button" id="empBtn" value="찾기"/>
	<input type="text" name="emp_no" id="empNo" readonly/><input type="text" id="empName" readonly/>
	<br/><input type="button" id="searchBtn" value="검색"/>
</div>

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">매입번호</th>
      <th scope="col">작성일자</th>
      <th scope="col">거래처명</th>
      <th scope="col">매입 개수</th>
      <th scope="col">작성자</th>
    </tr>
  </thead>
  <tbody id="listBody" data-toggle="modal" data-target="#exampleModal">
	<!-- 테이블 -->
  </tbody>
</table>
<input type="button" id="delBtn" value="매입취소" style="display:none;"/>

<!-- 검색어 보내기 -->
<form id="searchForm" action="${cPath }/buy/purchase">
	<input type="hidden" name="page" />
	<input type="hidden" name="pur_date"value="" />
	<input type="hidden" name="pur_dateEnd" value=""/>
	<input type="hidden" name="buyer_no" value=""/>
	<input type="hidden" name="emp_no" value=""/>
	<input type="hidden" name="status" id="status" value=""/>	<!-- 매입 상태 -->
	<!-- value값은  id가 searchUI인 태그를 찾아, 그 안에 name값이 같은 것들을 찾아와서 이곳에 주입시켜줌-->
</form>

<!-- 모달창 -->
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/purModalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>
<script type="text/javascript">
	//탭
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
	//입고 완료
	$("#status_ok").on("click", function(){
		$("#status").val("Q002");
		searchBtn.click();
		$("#delBtn").hide();
	});
	//매입취소
	$("#status_del").on("click", function(){
		$("#status").val("Q005");
		searchBtn.click();
		$("#delBtn").hide();
	});
	//반품처리
	$("#status_ret").on("click", function(){
		$("#status").val("Q007");
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
			let purList = resp.dataList;
			buyPurList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(purList.length>0){
				$.each(purList, function(idx, pur){
					let trTag = $("<tr>").attr({scope:"row"}).append(
									$("<th>").html($("<input/>").addClass('listCheck').attr({type:"checkbox"}))
									, $("<td/>").text(pur.pur_code)
									, $("<td/>").text(pur.pur_date)
									, $("<td/>").text(pur.buyerVO.buyer_name)
									, $("<td/>").text(pur.matCnt)
									, $("<td/>").text(pur.emp_name)
								).data("purCode", pur.pur_code);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='6'>").text("조건에 맞는 매입서가 없습니다.")));
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
	//거래처 목록 모달창
	modalView({
	  noText : "#buyer_no",      //사원 클릭 시, 입력될 태그 지정
	  nameText : "#buyer_name",  //사원 클릭 시, 입력될 태그 지정
	  clickBtn : "#buyerBtn",         //모달창을 띄울 버튼 지정
	   urlPath : "${cPath}/buy/document/buyerModal",
	   title:"거래처 목록"            //제목
	});
	
	// 체크박스 부분 이벤트 삭제
	$(document).on("click", "th", function(event){
		event.stopPropagation();
	});
	$(document).on("click", "#listBody th", function(){
		let check = $(this).find(".listCheck").prop("checked");
		if(check==false){
			$(this).find(".listCheck").prop("checked", true);			
		}else{
			$(this).find(".listCheck").prop("checked", false);
		}
	});
	
	//발주서 모달창
	var buyPurList;
	var listBody = $("#listBody").on("click", "td", function(){
		let purCode = $(this).parent().data("purCode");
		let purVO;
		if(buyPurList.length>0){
			$.each(buyPurList, function(idx, pur){
				if(pur.pur_code == purCode){
					purVO = pur;
				}
			});
		}else{
			console.log("buyPurList의 데이터가 존재하지 않습니다");
		}
		loadPurView(purVO);
	});

	
	
	//삭제
	$("#delBtn").on("click", function(){
		let purList = [];
		$("input[class=listCheck]:checked").each(function() {
			let pur_code = $(this).parent().parent().data("purCode");
			purList.push(pur_code);
		});
		jsonData = {pur_codeList : purList};
		$.ajax({
			url : "${cPath}/buy/purchase",
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


