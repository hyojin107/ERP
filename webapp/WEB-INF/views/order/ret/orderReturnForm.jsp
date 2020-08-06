<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 23       송효진 	          최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
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
	<h4>Step1. 출하서 목록 선택</h4>
	<div class="form-inline" id="searchUI">	<!-- 검색 -->
		거래처 <input type="button" id="buyerBtn" value="찾기"/>
		<input type="text" name="buyer_no" id="buyer_no" readonly/><input type="text" id="buyer_name" readonly/>
		 출하일 <input type="date" name="ship_p_date"/> ~ <input type="date" name="ship_p_dateEnd"/>
		<br/>
		작성자명 <input type="button" id="empBtn" value="찾기"/>
		<input type="text" name="emp_no" id="empNo" readonly/><input type="text" id="empName" readonly/>
		<br/><input type="button" id="searchBtn" value="검색"/>
	</div>
	
	<table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">출하등록 번호</th>
	      <th scope="col">출하일</th>
	      <th scope="col">거래처명</th>
	      <th scope="col">작성일자</th>
	      <th scope="col">담당자명</th>
	    </tr>
	  </thead>
	  <tbody id="listBody" data-toggle="modal" data-target="#exampleModal">
		<!-- 테이블 -->
	  </tbody>
	</table>
	<input type="button" id="nextPage" value="다음"/>
</div>



<!-- 검색어 보내기 -->
<form id="searchForm" action="${cPath }/buy/purchase">
	<input type="hidden" name="page" />
	<input type="hidden" name="ship_p_date"value="" />
	<input type="hidden" name="ship_p_dateEnd" value=""/>
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


<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/purModalView.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>



<script type="text/javascript">
	
	
	
	//step1 - 매입서 선택
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
	
	
	
	
</script>













