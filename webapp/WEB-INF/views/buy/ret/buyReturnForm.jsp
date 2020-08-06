<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.stepwizard-step p {
	    margin-top: 10px;
	}
	
	.stepwizard-row {
	    display: table-row;
	}
	
	.stepwizard {
	    display: table;
	    width: 100%;
	    position: relative;
	}
	
	.stepwizard-step button[disabled] {
	    opacity: 1 !important;
	    filter: alpha(opacity=100) !important;
	}
	
	.stepwizard-row:before {
	    top: 14px;
	    bottom: 0;
	    position: absolute;
	    content: " ";
	    width: 100%;
	    height: 1px;
	    background-color: #ccc;
	    z-order: 0;
	
	}
	
	.stepwizard-step {
	    display: table-cell;
	    text-align: center;
	    position: relative;
	}
	
	.btn-circle {
	  width: 30px;
	  height: 30px;
	  text-align: center;
	  padding: 6px 0;
	  font-size: 12px;
	  line-height: 1.428571429;
	  border-radius: 15px;
	}
</style>

<h2>반품 신청</h2>
<div class="container">
	<div class="stepwizard">
	    <div class="stepwizard-row setup-panel">
	        <div class="stepwizard-step">
	            <a href="#step-1" type="button" id="step1" class="btn btn-primary btn-circle">1</a>
	            <p>Step 1</p>
	        </div>
	        <div class="stepwizard-step">
	            <a href="#step-2" type="button" id="step2" class="btn btn-default btn-circle" disabled="disabled">2</a>
	            <p>Step 2</p>
	        </div>
	        <div class="stepwizard-step">
	            <a href="#step-3" type="button" id="step3" class="btn btn-default btn-circle" disabled="disabled">3</a>
	            <p>Step 3</p>
	        </div>
	    </div>
	</div>
</div>

<div id="stepDiv">
	<h4>Step1. 매입서 목록 선택</h4>
	<div class="form-inline" id="searchUI">	<!-- 검색 -->
		 작성일자 <input type="date" name="pur_date"/> ~ <input type="date" name="pur_dateEnd"/>
		<br>
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
	<!-- <input type="button" id="backPage" value="이전"/> -->
	<input type="button" id="nextPage" value="다음"/>
</div>


<!-- 검색어 보내기 -->
<form id="searchForm" action="${cPath }/buy/purchase">
	<input type="hidden" name="page" />
	<input type="hidden" name="pur_date"value="" />
	<input type="hidden" name="pur_dateEnd" value=""/>
	<input type="hidden" name="buyer_no" value=""/>
	<input type="hidden" name="emp_no" value=""/>
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

<!-- 매입일자 <input type="date" name="pur_date"/> -->
<!-- <br/>거래처<input type="text" id="buyer_no" name="buyer_no" readonly/><input type="text" id="buyer_name" readonly/> -->

<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/purModalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>

<script type="text/javascript">

	$("#nextPage").on("click", function(){
		let purCode = $("input[name=purRadio]:checked").val();
		if(purCode == null){
			alert("매입서 목록을 선택해주세요.");
			return;
		}
		let purVO;	//선택한 매입서 VO
		if(buyPurList.length>0){
			$.each(buyPurList, function(idx, pur){
				if(pur.pur_code == purCode){
					purVO = pur;
				}
			});
		}
		$("#step2").removeClass('btn-default').addClass('btn-primary');
		$("#stepDiv").empty();
		
		step2(purVO);	// step2
		
		$("#step2Btn").on("click", function(){
			let matList = [];	let itemList = [];
			let matVO = [];		let itemVO = [];
			$("input[class=step2Check]:checked").each(function(idx){     
				let ormat_code = $(this).parent().find(".ormat_code").val();
				let retmat_qty = $(this).parent().parent().find(".retmat_qty").val();
				let item_no = $(this).parent().parent().find(".item_no2").text();
				let retitem_qty = $(this).parent().parent().find(".retitem_qty").val();
				
				if(ormat_code && retmat_qty){
					matVO = [];
					matVO = {ormat_code: ormat_code, retmat_qty:retmat_qty};
					matList.push(matVO);
				}
				if(item_no && retitem_qty){
					itemVO = [];
					itemVO = {item_no:item_no, retitem_qty:retitem_qty};
					itemList.push(itemVO);
				}
			});
			jsonData = {
				pur_code : purVO.pur_code,	//매입번호
				emp_no : $("#empNo").val(),	//사원번호
				matList : matList,
				itemList : itemList
			}
			// insert 작업
			$.ajax({
				url : "${cPath}/buy/ret",
				method: "post",
			    contentType: "application/json;charset=UTF-8",	//보내는 data 타입
				data : JSON.stringify(jsonData),	//마샬링
				dataType : "html",	//받는 data타입
				success : function(resp) {
					$("#stepDiv").empty();
					$("#step3").removeClass('btn-default').addClass('btn-primary');
					$("#stepDiv").append(resp);
				},
				error : function(errorResp) {
					console.log(errorResp.status + ":" + errorResp.responseText);
				}
			});
		});
	});
	
	
	function step2(purVO){	//step2
		let title = "<h4>Step2. 반품 목록 선택</h4>";
		let matTr = "<table class='step2Table table table-hover'><h5>원자재 매입 물품</h5>";
		matTr += "<thead><tr><th>#</th><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr></thead><tbody>";
		for(var i=0; i<purVO.matList.length; i++){
			matTr += "<tr><td><input type='checkbox' class='step2Check'/>";
			matTr += "<input type='hidden' class='ormat_code' value='"+purVO.matList[i].ormat_code+"'></td>";
			matTr += "<td class='mat_no'>"+purVO.matList[i].mat_no+"</td>";
			matTr += "<td>"+purVO.matList[i].mat_name+"</td>";
			matTr += "<td>"+purVO.matList[i].lprod_name+"</td>";
			matTr += "<td>"+purVO.matList[i].mat_stand_size+"</td>";
			matTr += "<td><input type='number' class='retmat_qty' value='"+purVO.matList[i].ormat_qty+"' style='width:70px;'/></td>";
			matTr += "<td>"+purVO.matList[i].cost+"</td>";
		}
		matTr += "</tbody></table></tr>";
		
		let itemTr = "<table class='step2Table table table-hover'><h5>일반 매입 물품</h5>";
		itemTr += "<thead><tr><th>#</th><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr></thead><tbody>";
		for(var i=0; i<purVO.itemList.length; i++){
			itemTr += "<tr><td><input type='checkbox' class='step2Check'/></td>";
			itemTr += "<td class='item_no2'>"+purVO.itemList[i].item_no+"</td>";
			itemTr += "<td>"+purVO.itemList[i].item_name+"</td>";
			itemTr += "<td>"+purVO.itemList[i].item_lprod+"</td>";
			itemTr += "<td>"+purVO.itemList[i].item_stand_size+"</td>";
			itemTr += "<td><input type='number' class='retitem_qty' value='"+purVO.itemList[i].item_qty+"' style='width:70px;'/></td>";
			itemTr += "<td>"+purVO.itemList[i].item_cost+"</td></tr>";
		}
		itemTr += "</tbody></table></tr>";
		let endBtn = "<input type='button' id='step2Btn' value='반품 등록'/>";
		
		$("#stepDiv").append(title).append(matTr).append(itemTr).append(endBtn);
		
		// step2 테이블 체크박스 체크
		$(document).on("click", ".step2Table td", function(){
			let check = $(this).parent().find(".step2Check").prop("checked");
			if(check==false){
				$(this).parent().find(".step2Check").prop("checked", true);			
			}else{
				$(this).parent().find(".step2Check").prop("checked", false);
			}
		});
	}
	
	
	
	
	// step1 - 매입서 선택
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
									$("<th>").html($("<input/>").addClass('listCheck').attr({type:"radio", name:"purRadio", value:pur.pur_code}))
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
	
</script>











    