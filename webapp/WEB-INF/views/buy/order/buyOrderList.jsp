<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 2        송효진      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>발주 현황</h2>

<div id="searchUI">
	<!-- 탭 -->
	<ul class="nav nav-pills nav-tabs">
	  <li class="nav-item" id="status_all">
	    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
	  </li>
	  <li class="nav-item" id="status_ing">
	    <a class="nav-link" data-toggle="tab" href="#">진행중</a>
	  </li>
	  <li class="nav-item" id="status_ok">
	    <a class="nav-link" data-toggle="tab" href="#">매입완료</a>
	  </li>
	  <li class="nav-item" id="status_del">
	    <a class="nav-link" data-toggle="tab" href="#">발주취소</a>
	  </li>
	</ul>
	<br/>
	 작성일자 <input type="date" name="or_date"/> ~ <input type="date" name="or_dateEnd"/>
	<br>
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
      <th scope="col">발주번호</th>
      <th scope="col">작성일자</th>
      <th scope="col">거래처명</th>
      <th scope="col">발주 개수</th>
      <th scope="col">작성자</th>
    </tr>
  </thead>
  <tbody id="listBody" data-toggle="modal" data-target="#exampleModal">
  	<!-- 테이블 -->
  </tbody>
</table>
<input type="button" id="delBtn" value="발주취소" style="display:none;"/>
<br>

<!-- 매입서 insert -->
<form id="insertPur" action="${cPath}/buy/purchase" method="post">
	<div id="purList"></div>
	<input type="button" id="insertPurBtn" value="매입등록" style="display:none;"/>
</form>


<!-- 검색어 보내기 -->
<form id="searchForm" action="${cPath }/buy/order">
	<input type="hidden" name="page" />
	<input type="hidden" name="or_date"value="" />
	<input type="hidden" name="or_dateEnd" value=""/>
	<input type="hidden" name="buyer_no" value=""/>
	<input type="hidden" name="emp_no" value=""/>
	<input type="hidden" name="status" id="status" value=""/>	<!-- 발주 상태 -->
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
<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>
<script type="text/javascript">
	//탭
	//전체
	$("#status_all").on("click", function(){
		$("#status").val("");
		searchBtn.click();
		$("#delBtn").hide();
		$("#insertPurBtn").hide();
	});
	//진행중
	$("#status_ing").on("click", function(){
		$("#status").val("Q001");
		searchBtn.click();
		$("#delBtn").show();
		$("#insertPurBtn").show();
	});
	//매입 완료
	$("#status_ok").on("click", function(){
		$("#status").val("Q002");
		searchBtn.click();
		$("#delBtn").hide();
		$("#insertPurBtn").hide();
	});
	//발주취소
	$("#status_del").on("click", function(){
		$("#status").val("Q004");
		searchBtn.click();
		$("#delBtn").hide();
		$("#insertPurBtn").hide();
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
			let orderList = resp.dataList;
			buyOrderList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(orderList.length>0){
				$.each(orderList, function(idx, or){
					let trTag = $("<tr>").attr({scope:"row"}).append(
									$("<th>").html($("<input/>").addClass('listCheck').attr({type:"checkbox"}))
									, $("<td/>").text(or.or_code)
									, $("<td/>").text(or.or_date)
									, $("<td/>").text(or.buyerVO.buyer_name)
									, $("<td/>").text(or.matCnt)
									, $("<td/>").text(or.emp_name)
								).data("orCode", or.or_code);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='6'>").text("조건에 맞는 발주서가 없습니다.")));
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
	var buyOrderList;
	var listBody = $("#listBody").on("click", "td", function(){
		let orCode = $(this).parent().data("orCode");
		let orderVO;
		if(buyOrderList.length>0){
			$.each(buyOrderList, function(idx, order){
				if(order.or_code == orCode){
					orderVO = order;
				}
			});
		}else{
			console.log("buyOrderList의 데이터가 존재하지 않습니다");
		}
		loadOrderView(orderVO);
	});
	
	function loadOrderView(orderVO){ //상세보기 데이터 삽입
		$("#exampleModalLabel").text("발주서 목록");
		let view = $("<table>").addClass("table table-bordered").append(
				$("<tr>").append($("<th>").text("발주번호"), $("<td>").text(orderVO.or_code)  ),
				$("<tr>").append($("<th>").text("작성일자"), $("<td>").text(orderVO.or_date)  ),
				$("<tr>").append($("<th>").text("거래처코드"), $("<td>").text(orderVO.buyerVO.buyer_no)  ),
				$("<tr>").append($("<th>").text("거래처명"), $("<td>").text(orderVO.buyerVO.buyer_name)  ),
				$("<tr>").append($("<th>").text("발주 개수"), $("<td>").text(orderVO.matCnt)  ),
				$("<tr>").append($("<th>").text("작성자"), $("<td>").text(orderVO.emp_name)  ),
				$("<tr>").append($("<th>").text("작성자 부서"), $("<td>").text(orderVO.dep_name)  )
		);
		//서브테이블 만들기
		let matTr = "<tr><td colspan='2'>";
		matTr += "<table><h4>원자재 발주 물품</h4>";
		matTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr>";
		for(var i=0; i<orderVO.matList.length; i++){
			matTr += "<tr><td>"+orderVO.matList[i].mat_no+"</td>";
			matTr += "<td>"+orderVO.matList[i].mat_name+"</td>";
			matTr += "<td>"+orderVO.matList[i].lprod_name+"</td>";
			matTr += "<td>"+orderVO.matList[i].mat_stand_size+"</td>";
			matTr += "<td>"+orderVO.matList[i].ormat_qty+"</td>";
			matTr += "<td>"+orderVO.matList[i].cost+"</td>";
		}
		matTr += "</table></tr>";
		
		let itemTr = "<tr><td colspan='2'>";
		itemTr += "<table><h4>일반 발주 물품</h4>";
		itemTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr>";
		for(var i=0; i<orderVO.itemList.length; i++){
			itemTr += "<tr><td>"+orderVO.itemList[i].item_no+"</td>";
			itemTr += "<td>"+orderVO.itemList[i].item_name+"</td>";
			itemTr += "<td>"+orderVO.itemList[i].item_lprod+"</td>";
			itemTr += "<td>"+orderVO.itemList[i].item_stand_size+"</td>";
			itemTr += "<td>"+orderVO.itemList[i].item_qty+"</td>";
			itemTr += "<td>"+orderVO.itemList[i].item_cost+"</td></tr>";
		}
		itemTr += "</table></tr>";
		
		view.append(matTr).append(itemTr);
		
		exampleModal.find(".modal-body").html(view);
		exampleModal.data("orCode", orderVO.or_code);
		exampleModal.modal("show");
	}
	
	
	//매입등록 버튼
	$("#insertPurBtn").on("click", function(){
		let idx = 0;
		$("input[class=listCheck]:checked").each(function() {
			let or_code = $(this).parent().parent().data("orCode")
			$("#purList").append("<input type='hidden' name='orderList["+ idx +"].or_code' value='"+or_code+"'/>");
			idx++;
		});
		$("#insertPur").submit();
	});
	
	//삭제 
	$("#delBtn").on("click", function(){
		let orList = [];
		$("input[class=listCheck]:checked").each(function() {
			let or_code = $(this).parent().parent().data("orCode");
			orList.push(or_code);
		});
		jsonData = {or_codeList : orList};
		$.ajax({
			url : "${cPath}/buy/order",
			contentType : "application/json;charset=UTF-8",
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

