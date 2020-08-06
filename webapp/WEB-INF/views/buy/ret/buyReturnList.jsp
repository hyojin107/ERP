<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>반품 현황</h2>
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
	    <a class="nav-link" data-toggle="tab" href="#">출고완료</a>
	  </li>
	  <li class="nav-item" id="status_del">
	    <a class="nav-link" data-toggle="tab" href="#">반품취소</a>
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
      <th scope="col">반품번호</th>
      <th scope="col">작성일자</th>
      <th scope="col">거래처명</th>
      <th scope="col">반품 개수</th>
      <th scope="col">작성자</th>
    </tr>
  </thead>
  <tbody id="listBody" data-toggle="modal" data-target="#exampleModal">
    <!-- 테이블 -->
  </tbody>
</table>
<input type="button" id="delBtn" value="반품취소" style="display:none;"/>


<!-- 검색어 보내기 -->
<form id="searchForm" action="${cPath }/buy/ret">
	<input type="hidden" name="page" />
	<input type="hidden" name="ret_date"value="" />
	<input type="hidden" name="ret_dateEnd" value=""/>
	<input type="hidden" name="buyer_no" value=""/>
	<input type="hidden" name="emp_no" value=""/>
	<input type="hidden" name="status" id="status" value=""/>	<!-- 반품 상태 -->
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
	//출고 완료
	$("#status_ok").on("click", function(){
		$("#status").val("Q002");
		searchBtn.click();
		$("#delBtn").hide();
	});
	//반품 취소
	$("#status_del").on("click", function(){
		$("#status").val("Q006");
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
			let retList = resp.dataList;
			buyRetList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(retList.length>0){
				$.each(retList, function(idx, ret){
					let trTag = $("<tr>").attr({scope:"row"}).append(
									$("<th>").html($("<input/>").addClass('listCheck').attr({type:"checkbox"}))
									, $("<td/>").text(ret.ret_no)
									, $("<td/>").text(ret.ret_date)
									, $("<td/>").text(ret.buyerVO.buyer_name)
									, $("<td/>").text(ret.matCnt)
									, $("<td/>").text(ret.emp_name)
								).data("retNo", ret.ret_no);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='6'>").text("조건에 맞는 반품서가 없습니다.")));
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
	
	//반품서 모달창
	var buyRetList;
	var listBody = $("#listBody").on("click", "td", function(){
		let retNo = $(this).parent().data("retNo");
		let retVO;
		if(buyRetList.length>0){
			$.each(buyRetList, function(idx, ret){
				if(ret.ret_no == retNo){
					retVO = ret;
				}
			});
		}else{
			console.log("buyRetList의 데이터가 존재하지 않습니다");
		}
		loadRetView(retVO);
	});
	
	function loadRetView(retVO){ //상세보기 데이터 삽입
		$("#exampleModalLabel").text("반품서 목록");
		let view = $("<table>").addClass("table table-bordered").append(
				$("<tr>").append($("<th>").text("반품번호"), $("<td>").text(retVO.ret_no)  ),
				$("<tr>").append($("<th>").text("반품일자"), $("<td>").text(retVO.ret_date)  ),
				$("<tr>").append($("<th>").text("매입번호"), $("<td>").text(retVO.pur_code)  ),
				$("<tr>").append($("<th>").text("매입일자"), $("<td>").text(retVO.pur_date)  ),
				$("<tr>").append($("<th>").text("거래처코드"), $("<td>").text(retVO.buyerVO.buyer_no)  ),
				$("<tr>").append($("<th>").text("거래처명"), $("<td>").text(retVO.buyerVO.buyer_name)  ),
				$("<tr>").append($("<th>").text("반품 개수"), $("<td>").text(retVO.matCnt)  ),
				$("<tr>").append($("<th>").text("작성자"), $("<td>").text(retVO.emp_name)  ),
				$("<tr>").append($("<th>").text("작성자 부서"), $("<td>").text(retVO.dep_name)  )
		);
		//서브테이블 만들기
		let matTr = "<tr><td colspan='2'>";
		matTr += "<table><h4>원자재 반품 물품</h4>";
		matTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr>";
		for(var i=0; i<retVO.matList.length; i++){
			matTr += "<tr><td>"+retVO.matList[i].mat_no+"</td>";
			matTr += "<td>"+retVO.matList[i].mat_name+"</td>";
			matTr += "<td>"+retVO.matList[i].lprod_name+"</td>";
			matTr += "<td>"+retVO.matList[i].mat_stand_size+"</td>";
			matTr += "<td>"+retVO.matList[i].retmat_qty+"</td>";
			matTr += "<td>"+retVO.matList[i].cost+"</td>";
		}
		matTr += "</table></tr>";
		
		let itemTr = "<tr><td colspan='2'>";
		itemTr += "<table><h4>일반 반품 물품</h4>";
		itemTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr>";
		for(var i=0; i<retVO.itemList.length; i++){
			itemTr += "<tr><td>"+retVO.itemList[i].item_no+"</td>";
			itemTr += "<td>"+retVO.itemList[i].item_name+"</td>";
			itemTr += "<td>"+retVO.itemList[i].item_lprod+"</td>";
			itemTr += "<td>"+retVO.itemList[i].item_stand_size+"</td>";
			itemTr += "<td>"+retVO.itemList[i].retitem_qty+"</td>";
			itemTr += "<td>"+retVO.itemList[i].item_cost+"</td></tr>";
		}
		itemTr += "</table></tr>";
		
		view.append(matTr).append(itemTr);
		
		exampleModal.find(".modal-body").html(view);
		exampleModal.data("retNo", retVO.ret_no);
		exampleModal.modal("show");
	}
	
	
	//삭제 
	$("#delBtn").on("click", function(){
		let retList = [];
		$("input[class=listCheck]:checked").each(function() {
			let ret_no = $(this).parent().parent().data("retNo");
			retList.push(ret_no);
		});
		jsonData = {ret_noList : retList};
		$.ajax({
			url : "${cPath}/buy/ret",
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



