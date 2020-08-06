<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">상품 상세보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
<!-- 			 <button type="button" id="updateBtn" class="btn btn-primary mr-2">수정</button> -->
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<h2>상품관리 : 상품 목록 출력</h2>
<div>
	<form:form id="searchForm" action="${cPath }/ware/prod" method="get">
		<table border="1" class="table">
			<tr>
				<th>
					<spring:message code="prod.prod_name"/>
				</th>
				<td><input type="text" name="prod_name"/></td>
				<th>
					<spring:message code="prod.prod_no"/>
				</th>
				<td><input type="text" name="prod_no"/></td>
				<td><input type="button" value="검색" id="searchBtn"/></td>
			</tr>
			
			<tr>
				<th>
					<spring:message code="prod.prod_out_price"/>
				</th>
				<td>
					<input type="number" name="startPrice"/>~<input type="number" name="endPrice"/>
				</td>
				<th>
					<spring:message code="prod.prod_validity"/>
				</th>
				<td colspan="2">
					<input type="date" name="startDay"/>~<input type="date" name="endDay"/>
				</td>
			</tr>
			<tr>
				<th>
					<spring:message code="prod.lprod_no"/>
				</th>
				<td>
					<select name="lprod_no">
						<option value>상품 분류</option>
						<c:forEach items="${lprodList }" var="lprod">
							<option value="${lprod.lprod_no}">
								${lprod.lprod_name }
							</option>
						</c:forEach>
					</select>
				</td>
				<th>
					<spring:message code="prod.prod_use"/>
				</th>
				<td colspan="2">
					<select name="prod_use">
						<option value="">상태</option>
						<option value="G003">생산중</option>
						<option value="G004">생산중단</option>
					</select>
				</td>
			</tr>
		</table>
	</form:form><!-- 검색 form -->
</div>
<br/><br/>

<!-- 엑셀저장버튼 -->
<button id="exportBtn">엑셀 저장</button>
<br/>

<!-- 상품 목록 -->
<table border="1" class="table" id="prodTable">
	
	<thead>
	<tr>
		<th>
			<spring:message code="prod.rnum"/>
		</th>
		<th>
			<spring:message code="prod.prod_no"/>
		</th>
		<th>
			<spring:message code="prod.prod_name"/>
		</th>
		<th>
			<spring:message code="prod.lprod_no"/>
		</th>
		<th>
			<spring:message code="prod.prod_validity"/>
		</th>
		<th>
			<spring:message code="prod.prod_use"/>
		</th>
	</tr>
	</thead>
	<tbody id="listbody"></tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<nav id="pagingArea">${pagingVO.pagingHTML }</nav>
			</td>
		</tr>
	</tfoot>
</table>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">

var listbody = $("#listbody");

var searchForm = $("#searchForm").paging({
	searchUI : "#searchUI",
	searchBtn : "#searchBtn",
	pagination : "#pagingArea",
	pageParam : "page",
	byAjax : true,
	success : function(resp){
		let prodList = resp.dataList;
		let pagingHTML = resp.pagingHTML;
		console.log(prodList);
		let trTags = [];
		if(prodList.length > 0){
			$.each(prodList,function(idx,prod){
				let trTag = 
					$("<tr>").append(
						$("<td>").text(prod.rnum),
						$("<td>").text(prod.prod_no),
						$("<td>").text(prod.prod_name),
						$("<td>").text(prod.lprod_no),
						$("<td>").text(prod.prod_validity),
						$("<td>").text(prod.prod_use == 'G003' ? '생산중' : '생산중단')
					).data("prod_no",prod.prod_no);
				trTags.push(trTag);
			});
			$("#pagingArea").html(pagingHTML);
		}else{
			trTags.push($("<tr>").html(
				$("<td colspan='6'>").text("조건에 맞는 상품이 없습니다.")	
			));
			$("#pagingArea").empty();
		}
		
		$("#listbody").html(trTags);
		listbody.data("currentPage",resp.currentPage);
		searchForm.find("[name='page']").val("");
		// 엑셀로 저장 : 테이블이 전부 생성된후 엑셀에 담는다. 
		prodTable = $("#prodTable").tableExport({
			   headers: true,        // (Bool), 테이블의 <thead> 태그 안에 <th> 나 <td> 가 있으면 표시함 (기본: true)
		       footers: false,       // (Bool), 테이블의 <tfoot> 태그 안에 <th> 나 <td> 가 있으면 표시함, (기본: false)
		       formats: ["xlsx"],    // (String[]), 저장할 파일 포맷 반드시 배열 타입이어야 함, 아니면 에러 발생. (기본: ['xlsx', 'csv', 'txt'])
//		 	        filename: "exceldata",// 다운로드 파일명(확장자 제외하고 이름만). (기본: 'id')
		       bootstrap: false,     // (Bool), 부트스트랩 사용시 true, 사용시 부트스트랩 버튼 스타일 유지해줌. (기본: true)
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
	sampleModal.data("prod_no","");
});

function loadProdView(prod_no){
	$.ajax({
		url : "<c:url value='/order/prodSearch/'/>"+prod_no,
		dataType : "html",
		// Accept : 
		// html > text/html, Content-Type:text/html
		// json >  application/json 
		success : function(resp) {
			sampleModal.find(".modal-body").html(resp);
			sampleModal.data("prod_no",prod_no);
			sampleModal.modal("show");
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":"
					+ errorResp.responseText);
		}
	});
}

var listBody = $("#listbody").on("click","tr",function(){
	let prod_no = $(this).data("prod_no");
	loadProdView(prod_no);
	}).css({cursor:"pointer"});
	
	// 수정 버튼 
// 	$("#updateBtn").on("click", function(){
// 		let prod_no = sampleModal.find("td").eq(0).text();
// 		location.href="${pageContext.request.contextPath }/ware/prod/update/"+prod_no;
// 	});

// 	엑셀파일로 저장하기 
	let prodTable = null;
   $("#exportBtn").on("click", function(){
		let name = prompt("file name");
		let exportData = prodTable.getExportData()['prodTable']['xlsx'];
		console.log(exportData.filename);
	    //                   // data          // mime              // name              // extension
	    prodTable.export2file(exportData.data, exportData.mimeType, name, exportData.fileExtension);
   });

</script>
