<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 2      이제경       		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>



<!-- 탭버튼 -->
<style>
.tablinks.active {
	color: #000;
	background-color: #fff;
}
</style>
<script type="text/javascript">
	function openTab(evt, tabName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent"); // 컨텐츠를 불러옵니다. 
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none"; //컨텐츠를 모두 숨깁니다. 
		}
		tablinks = document.getElementsByClassName("tablinks"); //탭을 불러옵니다. 
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", ""); //탭을 초기화시킵니다. 
		}
		document.getElementById(tabName).style.display = "block"; //해당되는 컨텐츠만 보여줍니다. 
		evt.currentTarget.className += " active"; //클릭한 탭을 활성화시킵니다. 
	}
</script>
<!-- 탭버튼 끝 -->
<div class="col-xs-12">
	<div class="box">
		<div class="box-header">
			<h3 class="box-title">견적서조회</h3>
			<table>
<!-- 				<thead> -->
<!-- 					<tr> -->
<!-- 						<td> -->
<!-- 							<div class="tab"> -->
<!-- 								<button class="tablinks active" onclick="openTab(event, 'tab1')">전체</button> -->
<!-- 								<button class="tablinks" onclick="openTab(event, 'tab2')">진행중</button> -->
<!-- 								<button class="tablinks" onclick="openTab(event, 'tab3')">완료</button> -->
<!-- 							</div> -->
<!-- 							<div id="tab1" class="tabcontent" style="display: block;">전체리스트</div> -->
<!-- 							<div id="tab2" class="tabcontent" style="display: none;">진행중리스트</div> -->
<!-- 							<div id="tab3" class="tabcontent" style="display: none;">완료리스트</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 				</thead> -->
				<tbody >
					
					<tr>
					<td>
						<div class="#" id="searchUI">
						<!-- 탭 -->
						<ul class="nav nav-pills nav-tabs">
						  <li class="nav-item" id="status_all">
						    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
						  </li>
						  <li class="nav-item" id="status_ing">
						    <a class="nav-link" data-toggle="tab" href="#">진행중</a>
						  </li>
						  <li class="nav-item" id="status_ok">
						    <a class="nav-link" data-toggle="tab" href="#">완료</a>
						  </li>
						</ul>
						<spring:message code="date" />
						<input type="date" name="est_date">					
						<spring:message code="buyer.buyer_name" />
						<input type="text" name="buyer_name">
						<spring:message code="emp.emp_name" />
						<input type="text" name="emp_name">
						</div>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td>
							<div>
<!-- 									<select name="searchType"> -->
<!-- 										<option value="" -->
<%-- 											${empty pagingVO.searchVO.searchType? "selected":"" }> --%>
<!-- 											모두</option> -->
<!-- 									</select>  -->

									<input type="button" value="검색" id="searchBtn"> 
									<input type="button" value="새글등록"
										onclick="location.href='<c:url value="/order/estimate/form" />';">
								</div>
<%-- 								<nav id="pagingArea">${pagingVO.pagingHTML }</nav> --%>


						</td>
					</tr>
				</tfoot>

			</table>

			<!--               <div class="box-tools"> -->
			<!--                 <div class="input-group input-group-sm hidden-xs" style="width: 150px;"> -->
			<!--                   <input type="text" name="table_search" class="form-control pull-right" placeholder="Search"> -->

			<!--                   <div class="input-group-btn"> -->
			<!--                     <button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button> -->
			<!--                   </div> -->
			<!--                 </div> -->
		</div>
	</div>
	<!-- /.box-header -->
	<div id="tableDiv" class="box-body table-responsive no-padding" style="height:600px;overflow-y: scroll;">
		<table class="table table-hover" id="estimateTable">
			<thead>
				<tr>
					<th>#</th>
					<th><spring:message code="board.bo_date" /></th>
					<th><spring:message code="estimate.est_no" /></th>
					<th><spring:message code="buyer.buyer_name" /></th>
					<th><spring:message code="estimate.est_price" /></th>
					<th><spring:message code="status" /></th>
				</tr>
			</thead>
			<tbody id="listBody">

			</tbody>
			<tfoot>
				<tr>
					<td colspan="6">
<%-- 						<nav id="pagingArea">${pagingVO.pagingHTML }</nav> --%>
					</td>
				</tr>
				<tr>
					<td colspan="8">
						
					</td>
				</tr>
			</tfoot>

		</table>
	</div>
	<div>
		<input type="button" id="print" value="인쇄">
		<input type="button" id="exportBtn" value="엑셀저장">
		<input type="button" id="delBtn" value="삭제">
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">견적서상세보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
			 <button type="button" id="updateBtn" class="btn btn-primary mr-2">수정</button>
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<%-- <form:form id="searchForm" action="${pageContext.request.contextPath }/order/estimate" type="post"> --%>
<form:form id="searchForm" action="${pageContext.request.contextPath }/order/estimate" method="get">
	<input type="hidden" name="page" value="${param.page }">
	<input type="hidden" name="est_date" value="" />
	<input type="hidden" name="buyer_name" value="" />
	<input type="hidden" name="emp_name" value="" />
	<input type="hidden" name="status" id="status" value="" />
<!-- 	<input type="hidden" name="searchType" value="" /> -->
<!-- 	<input type="hidden" name="searchWord" value="" /> -->
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging(
			{
				searchUI : "#searchUI",
				searchBtn : "#searchBtn",
				pagination : "#pagingArea",
				pageParam : "page",
				byAjax : true,
				success : function(resp) {
					console.log(resp);
					let estimateList = resp.dataList;
					let pagingHTML = resp.pagingHTML;
					console.log(estimateList);
					let trTags = [];
					if (estimateList.length > 0) {
						$.each(estimateList, function(idx, estimate) {
							let trTag = $("<tr>").append(
// 									$("<td>").html(estimate.rnum),
									$("<td>").html($("<input>").attr({type:"checkbox", name:"inputChk"}).addClass("chk")).addClass("chk"),
									$("<td>").html(estimate.est_date),
									$("<td>").html(estimate.est_no).attr({name:"est_no",value:estimate.est_no}),
// 									$("<td>").html(
// 											$("<a>").attr(
// 													"href",
// 													"${pageContext.request.contextPath}/order/estimate/"
// 															+ estimate.est_no)
// 													.html(estimate.est_date)

// 									), 
									$("<td>").html(estimate.buyer_name),
									$("<td>").html(estimate.est_price),
									$("<td>").html(
											$("<select>").append(
												$("<option>").val("OR01").text("진행중"),
												$("<option>").val("OR02").text("완료")
											).addClass("select").val(estimate.est_prog)
									).addClass("select").data("est_no", estimate.est_no),
									$("<td>").html($("<input>").attr({type:"button", name:"selectBtn", value:"진행상태변경"}).addClass("selectBtn")).addClass("selectBtn")
							).data("est_no", estimate.est_no);
							trTags.push(trTag);
						});
// 						$("#pagingArea").html(pagingHTML);
					} else {
						trTags.push($("<tr>").html(
								$("<td colspan='8'").text("조건에 맞는 게시글이 없음")));
// 						$("#pagingArea").empty();
					}
					listBody.html(trTags);
					listBody.data("currentPage", resp.currentPage);
					$("#pagingArea").html(pagingHTML);
					searchForm.find("[name='page']").val("");
					//엑셀저장------------------------------------------------------------
					estimateTable = $("#estimateTable").tableExport({
						   headers: true,        // (Bool), 테이블의 <thead> 태그 안에 <th> 나 <td> 가 있으면 표시함 (기본: true)
					       footers: true,       // (Bool), 테이블의 <tfoot> 태그 안에 <th> 나 <td> 가 있으면 표시함, (기본: false)
					       formats: ["xlsx"],    // (String[]), 저장할 파일 포맷 반드시 배열 타입이어야 함, 아니면 에러 발생. (기본: ['xlsx', 'csv', 'txt'])
//					 	        filename: "exceldata",// 다운로드 파일명(확장자 제외하고 이름만). (기본: 'id')
					       bootstrap: true,     // (Bool), 부트스트랩 사용시 true, 사용시 부트스트랩 버튼 스타일 유지해줌. (기본: true)
					       exportButtons: false,  // (Bool), 선택한 확장자 포맷들로 자동으로 내장 버튼을 출력해줌. (기본: true)
					       position: "top",      // (top, bottom), 캡션 표시 위치(버튼이 출력되는 위치로 테이블 상단(top), 하단(bottom)을 선택. (기본: 'bottom')
					       ignoreRows: null,     // (Number, Number[]), 엑셀 파일 저장시 제외할 테이블 행을 숫자, 또는 숫자 배열로 지정. (기본: null)
					       ignoreCols: null,     // (Number, Number[]), 엑셀 파일 저장시 제외할 테이블 열을 숫자, 또는 숫자 배열로 지정. (기본: null)
					       trimWhitespace: true, // (Boolean), 테이블 안의 텍스트 앞뒤에 붙은 줄바꿈, 공백, 탭을 모두 제거해줌. true 권장. (기본: false)
					       RTL: false,           // (Boolean), 엑셀 워크시트를 오른쪽에서 왼쪽으로 출력함. 아랍어 전용으로 false 고정. ( (기본: false)
					       sheetname: "Sheet1"   // (id, String), 시트이름 (기본: 'id')
					});
				}

			}).submit();

	
	// 모달창 띄우기
	var sampleModal = $("#exampleModal").modal({
		show:false
	}).on("hidden.bs.modal",function(){
		sampleModal.find(".modal-body").empty();
		sampleModal.data("est_no","");
	});
	   
	       
	function loadEstView(est_no) {
		$.ajax({
			url : "<c:url value='/order/estimate/'/>" + est_no,
			dataType : "html",
			// Accept : 
			// html > text/html, Content-Type:text/html
			// json >  application/json 
			success : function(resp) {
				sampleModal.find(".modal-body").html(resp);
				sampleModal.data("est_no", est_no);
				sampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}

	//tr태그 클릭------------------------------------------------------------
	var est_num;
	var listView = $("#listBody").on("click", "tr", function(e){
// 		console.log(e.target);
		if($(e.target).attr("class")=='select') return;
		if($(e.target).attr("class")=='chk') return;
		if($(e.target).attr("class")=='selectBtn') return;
		est_num = $(this).data("est_no");
		loadEstView(est_num);
		console.log(est_num);
	}).css({cursor:"pointer"});
	

	//tr엑셀파일로 저장하기------------------------------------------------------------
	let estimateTable = null;
   $("#exportBtn").on("click", function(){
		let name = prompt("file name");
		let exportData = estimateTable.getExportData()['estimateTable']['xlsx'];
		console.log(exportData.filename);
	    //                   // data          // mime              // name              // extension
	    estimateTable.export2file(exportData.data, exportData.mimeType, name, exportData.fileExtension);
   });

	//수정버튼------------------------------------------------------------
   	
	$("#updateBtn").on("click", function(){
// 		let est_no = sampleModal.find("td").eq(4).text();
		let est_no = sampleModal.find("tr").eq(1).find("td").text();
// 		alert(est_no)
		console.log(est_no);
		location.href= "${pageContext.request.contextPath }/order/estimate/"+est_no+"/form";
		
	});
	
	//진행상태변경------------------------------------------------------------
	
	var selectBtn = $("#listBody").on("click", "input[type=button]", function(){
// 		alert(1);
// 		console.log(e);
		let est_prog = $(this).parent().prev().find("select").val();
		console.log(est_prog);
		let est_no = $(this).parent().parent().find("td").eq(2).text();
		loadSelect(est_no, est_prog);
	});
	
	function loadSelect(est_no, est_prog) {
		$.ajax({
			url : "<c:url value='/order/prog/estimate'/>",
			dataType : "html",
			data : {
				est_no : est_no,
				est_prog : est_prog},
			// Accept : 
			// html > text/html, Content-Type:text/html
			// json >  application/json 
			success : function(resp) {
				alert("진행상태가 변경되었습니다.");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	
//탭관련------------------------------------------------------------
	//전체
	$("#status_all").on("click", function(){
		$("#status").val("");
		searchBtn.click();
	});
	
	//진행중
	$("#status_ing").on("click", function(){
		$("#status").val("OR01");
		searchBtn.click();
	});
	
	//완료
	$("#status_ok").on("click", function(){
		$("#status").val("OR02");
		searchBtn.click();
	});
	
//삭제버튼클릭------------------------------------------------------------
	var delBtn = $("#delBtn").on("click", function(){
		var est_noList = [];
	
// 		let est_no = $("#listBody").find("tr").eq(0).find("td").eq(2);
// 		alert(est_no);
		
		//선택된값 가져오기
// 		var chkbox = $("input[name=inputChk]:checked").parent().parent().find("#est_no").val();
// 		var chkbox = $("input[name=inputChk]:checked").parent().parent().find("td[name=est_no]").text();
// 		console.log(chkbox);
		
		var chkbox='';
			chkbox = $("input[name=inputChk]:checked").parent().parent().find("td[name=est_no]");
		
		//값을 리스트에 담아주기
		$.each(chkbox,function(idx,item){
			est_noList.push($(item).text()); //
			console.log(est_noList);
			deleteEstimate(est_noList);
		});
		
	});
	
	
	
	function deleteEstimate(est_noList){
		jsonData = {est_noList : est_noList};
		$.ajax({
			url : "${cPath}/order/estimate/delete",
			contentType : "application/json;charset=UTF-8",
			dataType : "text",
			type : "POST",
			data :JSON.stringify(jsonData),
			success : function(resp) {
				alert(resp);
				searchBtn.click();
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		}); 
		
	}
	
</script>

