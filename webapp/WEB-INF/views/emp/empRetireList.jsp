<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>사원퇴사관리</h1>  


<thead>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<select name="searchType" class="form-control mr-2">
						<option value="" ${empty pagingVO.searchVO.searchType?"selected":"" }>
							<spring:message code="all" />
						</option>
						<option value="${emp.emp_no }" ${pagingVO.searchVO.searchType eq '${emp_no}'?"selected":"" }>
							<spring:message code="id" />
						</option>
						<option value="${emp.emp_name}" ${pagingVO.searchVO.searchType eq '${emp_name}'?"selected":"" }>
							<spring:message code="name" />
						</option>
					</select>
				</div>
				
					<input type="text" class=" " name="searchWord"
						value="${pagingVO.searchVO.searchWord }"
						onkeyup="event.keyCode==13?$('#searchBtn').trigger('click'):'';">
					<input class="btn btn-success mr-2" type="button" value="검색" id="searchBtn">
					<%-- <input class="btn btn-success mr-2" type="button" value="<spring:message code='newBoard'/>" 
						onclick="location.href='<c:url value="/board/form"/>';"
					> --%>  
				</div>
			</td>
		</tr>
</thead>

<form id="searchForm" action="${pageContext.request.contextPath }/emp/retire/">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
</form>

<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>no</th>
			<th>사원ID</th>
			<th>소속</th>
			<th>직급</th>
			<th>성명</th>
			<th>퇴사날짜</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8">
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
			</td>
			<td colspan="8">
			<%-- <a href="<c:url value='/emp/retire/retirementForm'/>">
				<button class="btn btn-success">등록</button></a> --%>
			</td>
		</tr>
	</tfoot>
</table>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" style="max-width: 100%; width: auto; display: table;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">퇴사자 정보</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let boardList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(boardList.length>0){
				$.each(boardList, function(idx, emp){
					let trTag = $("<tr>").append(
									$("<td>").text(emp.rnum)
									, $("<td>").text(emp.emp_no)
									, $("<td>").text(emp.dep_no)
									, $("<td>").text(emp.pos_no)
									, $("<td>").text(emp.emp_name)
									, $("<td>").text(emp.retire_date));
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html($("<td colspan='8'>").text("조건에 맞는 게시글이 없음.")));
				$("#pagingArea").empty();
			}
			listBody.html(trTags);
			listBody.data("currentpage", resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();


	// 모달창 	 수저버튼을 누르면  모달을 숨기는거 
	var exampleModal = $("#exampleModal").modal({
		show : false
	}).on("hidden.bs.modal", function() {
		exampleModal.find(".modal-body").empty();
		upBtn.text('수정');
	});

	var upBtn = $("#upBtn").on(
			"click",
			function(event) {
				if ('수정' == upBtn.text()) {
					upBtn.text('등록');  // 수젗버튼을 누르면  버튼이 등록으로 바꾼다.
					exampleModal.find('.form-control').not('.code').removeAttr(
							'readonly');
					exampleModal.find('.form-control').not('.code').removeAttr(
							'disabled');
					return;
				}
				var form = exampleModal.find("form")[0];
				var data = new FormData(form);
				//	 	data.append("file", $("#input_img")[0].files[0]);
				var emp_no = exampleModal.find(
						"input[name='emp_no']").val();
				$.ajax({
					url : "${cPath}${currentAction}" + emp_no,
					processData : false,
					contentType : false,
					type : 'post',
					data : data,
					dataType : "text", // Accept:application/json, Content-Type:application/json
					success : function(resp) {
						alert(resp);
						upBtn.text('수정');
						exampleModal.find('.form-control').not('.code').attr(
								'readonly', 'readonly');
						exampleModal.find('.form-control').not('.code').attr(
								'disabled', 'disabled');
						loadAccountView(emp_no);
					},
					error : function(errorResp) {
						console.log(errorResp.status + ":"
								+ errorResp.responseText);
					}
				});

			});

	var exampleModal = $("#exampleModal").modal({
		show : false
	}).on("hidden.bs.modal", function() {
		exampleModal.find(".modal-body").empty();
	});

	/// 행 클릭시 모달창 나오는 
	function loadAssetsView(emp_no) {//2 td의 첫번쩨 == emp_no를 파라미터로 넣어준다.
		$.ajax({
			url : "<c:url value='/emp/retire/retireEmp/'/>" + emp_no, // 컨트롤러에 연결하는거
			dataType : "html", // Accept:application/json, Content-Type:application/json
			success : function(resp) {
				exampleModal.find(".modal-body").html(resp); //modal-body클래스를 찾아서 모달을 붙여준다.
				exampleModal.modal("show"); // 모달을 창에 띄운다.
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	// 1번 listBody 를 클릭시 
	$("#listBody").on("click", "tr", function() {
		let retirement = $(this).find("td").eq(1).text(); //  0 1 2 3 4  3번째 td 의 값을 주소값으로 넘겨주는거 
		loadAssetsView(retirement); // td의 1번을 찾아서 function에 넣어준다.
	}).css({
		cursor : "pointer"
	});
	
</script>