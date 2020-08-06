<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 16     이제경       		최초작성
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
table { border-collapse:collapse; }  
th, td { border:1px solid gray; }
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

<div class="col-xs-12">
	<div class="box">
		<div class="box-header">
			<h3 class="box-title">출하조회</h3>
			<table>
				<thead>
				
				</thead>
				<tbody>

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
						  <li class="nav-item" id="status_del">
						    <a class="nav-link" data-toggle="tab" href="#">취소</a>
						  </li>
						</ul>						
<%-- 						<spring:message code="date" /> --%>
<!-- 						<input type="date" name="or_date"> -->
						<spring:message code="buyer.buyer_name" />
						<input type="button" id="buyerBtn" value="찾기"/>
						<input type="text" name="buyer_no" id="buyer_no" value="${shipment.buyer_no }"/><input type="text" id="buyer_name"/>
<%-- 						<spring:message code="delivery.deliv_schd" /> --%>
<!-- 						<input type="text" name="deliv_schd"> -->
<%-- 						<spring:message code="prod_name" /> --%>
<!-- 						<input type="text" name="prod_name"> -->
						출하일
						<input type="date" name="ship_p_date">
						<spring:message code="emp.emp_name" />
						<input type="button" id="empBtn" value="찾기"/>
						<input type="text" name="emp_no" id="empNo" value="${shipment.emp_name }"/><input type="text" id="empName"/>
					</div>
					</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3">
							<div>
								
									<!-- 									<select name="searchType"> -->
									<!-- 										<option value="" -->
									<%-- 											${empty pagingVO.searchVO.searchType? "selected":"" }> --%>
									<!-- 											모두</option> -->
									<!-- 									</select>  -->

									<input type="button" value="검색" id="searchBtn"> 
									<input type="button" value="신규등록"
										onclick="location.href='<c:url value="/order/shipment/form" />';">
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
	<div id="tableDiv" class="box-body table-responsive no-padding" style="height:600px; overflow-y:scroll;">
		<table class="table table-hover" id="shipmentTable">
			<thead>
				<tr>
					<th>#</th>
					<th>출하일</th>
					<th><spring:message code="delivery.deliv_no" /></th>
					<th><spring:message code="delivery.deliv_schd" /></th>
					<th><spring:message code="emp.emp_name" /></th>
					<th><spring:message code="buyer.buyer_no" /></th>
					<th><spring:message code="buyer.buyer_name" /></th>
					<th colspan="2"><spring:message code="status" /></th>
				</tr>
			</thead>
			<tbody id="listBody">
				
				
			</tbody>
<!-- 			<tfoot> -->
<!-- 				<tr> -->
<!-- 					<td> -->
<!-- 						<input type="button" id="selectDelete" value="선택삭제"> -->
<!-- 					</td> -->
<!-- 					<td colspan="8"> -->
<%-- 						<nav id="pagingArea">${pagingVO.pagingHTML }</nav> --%>
						
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</tfoot> -->

		</table>
	</div>
	<div>
		<input type="button" id="print" value="인쇄">
		<input type="button" id="exportBtn" value="엑셀저장">
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">출하 상세보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" id="delBtn" class="btn btn-primary mr-2">삭제</button>
				<button type="button" id="updateBtn" class="btn btn-primary mr-2">수정</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<form:form id="radioForm" action="${cPath }/order/transDetails/form" method="get">
	<div id="shipmentPost"></div>
	<input type="button" id="selectDelivery" onclick="sendShipmnet()" value="거래명세서등록">
</form:form>


<form:form id="searchForm" action="${pageContext.request.contextPath }/order/shipment" method="get">
	<input type="hidden" name="page" value="${param.page }">
<!-- 	<input type="hidden" name="deliveryList[0].order[0].or_date" value=""> -->
<!-- 	<input type="hidden" name="deliveryList[0].deliv_schd" value=""> -->
<!-- 	<input type="hidden" name="deliveryList[0].order[0].orderList[0].prodList[0]" value=""> -->
	<input type="hidden" name="ship_p_date" value="">
	<input type="hidden" name="emp_no" value="">
	<input type="hidden" name="buyer_no" value="">
	<input type="hidden" name="status" id="status" value="">
<!-- 	<input type="hidden" name="searchType" value="" /> -->
<!-- 	<input type="hidden" name="searchWord" value="" /> -->
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript">
//listBody붙이기------------------------------------------------------------

	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging(
			{
				searchUI : "#searchUI",
				searchBtn : "#searchBtn",
				pagination : "#pagingArea",
				byAjax : true,
				success : function(resp) {
					let shipmentList = resp.dataList;
					console.log(shipmentList);
					let pagingHTML = resp.pagingHTML;
					let trTags = [];
					if (shipmentList.length > 0) {
						$.each(shipmentList, function(idx, shipment) {
							console.log(shipment);
							let trTag = $("<tr>").append(
// 										$("<td>").text(shipment.rnum),
									$("<td>").html($("<input>").attr({type:"radio", name:"inputChk"}).addClass("radio")).addClass("radio"),
									$("<td>").html(shipment.ship_p_date),
									$("<td>").html(shipment.deliveryList[0].deliv_no),
									$("<td>").html(shipment.deliveryList[0].deliv_schd),
									$("<td>").html(shipment.emp_name),
									$("<td>").html(shipment.buyer_no),
									$("<td>").html(shipment.buyer_name),
// 									$("<td>").html(shipment.ship_no),
									$("<input/>").addClass("shipNo").attr({type:"hidden", value:shipment.ship_no}),
// 									$("<input/>").addClass("buyerNo").attr({type:"hidden", value:shipment.buyer_no})
									$("<td>").html(
											$("<select>").append(
												$("<option>").val("OR01").text("진행중"),
												$("<option>").val("OR02").text("완료")
											).addClass("select").val(shipment.ship_prog)
									).addClass("select").data("ship_no", shipment.ship_no),
									$("<td>").html($("<input>").attr({type:"button", name:"selectBtn", value:"진행상태변경"}).addClass("selectBtn")).addClass("selectBtn")
							).data("ship_no", shipment.ship_no);
// 									).data("ship_no", shipment.ship_no+"");
// 							console.log(shipment);
							trTags.push(trTag);
						});
						$("#pagingArea").html(pagingHTML);
					} else {
						trTags.push($("<tr>").html(
								$("<td colspan='5'").text("조건에 맞는 게시글이 없음")));
						$("#pagingArea").empty();
					}
					listBody.html(trTags);
					
					listBody.data("currentPage", resp.currentPage);
					searchForm.find("[name='page']").val("");
					//엑셀저장------------------------------------------------------------
					shipmentTable = $("#shipmentTable").tableExport({
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


//tr엑셀파일로 저장하기------------------------------------------------------------
	let shipmentTable = null;
	  $("#exportBtn").on("click", function(){
		let name = prompt("file name");
		let exportData = shipmentTable.getExportData()['shipmentTable']['xlsx'];
		console.log(exportData.filename);
	    //                   // data          // mime              // name              // extension
	    shipmentTable.export2file(exportData.data, exportData.mimeType, name, exportData.fileExtension);
	  });
	

//모달창 띄우기------------------------------------------------------------
	var sampleModal = $("#exampleModal").modal({
		show:false
	}).on("hidden.bs.modal",function(){
		sampleModal.find(".modal-body").empty();
		sampleModal.data("ship_no","");
	});	
	
	//거래처, 담당자 모달---------------------------------------------------------------------------------------------

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
	      title:"사원 목록"				//제목
	   });
	   //거래처 목록 모달창
	   modalView({
		  noText : "#buyer_no",      //사원 클릭 시, 입력될 태그 지정
		  nameText : "#buyer_name",  //사원 클릭 시, 입력될 태그 지정
		  clickBtn : "#buyerBtn",         //모달창을 띄울 버튼 지정
	      urlPath : "${cPath}/buy/document/buyerModal",
	      title:"거래처 목록"				//제목
	   });
	
	 //listBody붙이기-------------------------------------------------------------
		function loadShipmentView(ship_no) {
			$.ajax({
				url : "<c:url value='/order/shipment/'/>" + ship_no,
				dataType : "html",
				// Accept : 
				// html > text/html, Content-Type:text/html
				// json >  application/json 
				success : function(resp) {
					sampleModal.find(".modal-body").html(resp);
					sampleModal.data("ship_no", ship_no);
					sampleModal.modal("show");
				},
				error : function(errorResp) {
					console.log(errorResp.status + ":" + errorResp.responseText);
				}
			});
		}
		//tr태그 클릭------------------------------------------------------------
		var ship_num;
		var listView = $("#listBody").on("click", "tr", function(e){
			if($(e.target).attr("class")=='radio') return;
			if($(e.target).attr("class")=='select') return;
			if($(e.target).attr("class")=='selectBtn') return;
			ship_num = $(this).data("ship_no");
			loadShipmentView(ship_num);
		}).css({cursor:"pointer"});
		
		//라디오버튼클릭------------------------------------------------------------
		
		function sendShipmnet(){
			var listBody = document.getElementById('listBody');
			var confirm_val = confirm("선택한 출하의 거래명세서를 입력하겠습니까?");
			var chkRadio = $("input[name=inputChk]:checked").parent().parent().find(".shipNo").val();
			alert(chkRadio);
//	 		console.log("라디오 값확인: " +chkRadio);
			
			$("#shipmentPost").append("<input type='hidden' name='ship_no' value='"+ chkRadio +"'/>");
			
			if(confirm_val){
				$("#radioForm").submit();
				
			}

		}
		
//진행상태변경------------------------------------------------------------
		
		var selectBtn = $("#listBody").on("click", "input[type=button]", function(){
//	 		alert(1);
//	 		console.log(e);
			let ship_prog = $(this).parent().prev().find("select").val();
			console.log(ship_prog);
			let ship_no = $(this).parent().parent().data("ship_no");
			alert(ship_no);
			loadSelect(ship_no, ship_prog);
		});
		
		function loadSelect(ship_no, ship_prog) {
			$.ajax({
				url : "<c:url value='/order/prog/shipment/'/>",
				dataType : "html",
				data : {
					ship_no : ship_no,
					ship_prog : ship_prog},
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
		
//수정버튼------------------------------------------------------------
	  	
		$("#updateBtn").on("click", function(){
			let ship_no = sampleModal.find("tr").eq(0).find("td").eq(0).text();
//	 		console.log(est_no);
//	 		let or_no = or_num;
//	 		console.log(or_no);
			location.href= "${pageContext.request.contextPath }/order/shipment/"+ship_no+"/form";
		});
		
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
		
		//취소
		$("#status_del").on("click", function(){
			$("#status").val("OR99");
			searchBtn.click();
		});
		
		
</script>

