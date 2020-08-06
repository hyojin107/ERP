<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<h1>사원리스트</h1>
<!-- 사원 목록 리스트 보여주는거  -->
<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
	<thead class="table-primary">
		<tr class="row">
			<td class="col-2 form-inline"><select
				class="dynamicElement form-controlmr-2 " name="dep_no2"
				data-url="<c:url value='departmentList'/>">
					<option value="">부서명</option>
			</select></td>
		</tr>
		<tr class="row">
			<td class="col-2 form-inline"><select
				class="dynamicElement form-controlmr-2" name="dep_no"
				data-url="<c:url value='TeamList'/>">
					<option value="">소속 팀</option>
			</select></td>
			<td class="col-1"><input type="submit" value="검색" id="searchBtn"></td>
		</tr>
	</thead>
</div>


<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>No.</th>
			<th>사원구분</th>
			<th>소속</th>
			<th>직급</th>
			<th>사원ID</th>
			<th>성명</th>
		</tr>
	</thead>
	<tbody id="listBody">

	</tbody>
	<tfoot>
		<tr>
			<td colspan="8">
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }</nav>
			</td>
			<td colspan="8"><a
				href="<c:url value='/emp/manage/empinformation'/>"><button
						class="btn btn-success">신규등록</button></a></td>
		</tr>
	</tfoot>
</table>

<!--  행하나 클릭시 모달창으로 사원의 상세정보가 나오는곳  -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" style="max-width: 100%; width: auto; display: table;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사원상세정보</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id='upBtn'>수정</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 검색버튼을 눌렀을 때 내용 가져오는거? -->
<form id="searchForm"
	action="${pageContext.request.contextPath }/emp/manage" method="get">
	<input type="hidden" name="page" value="${param.page }" /> 
	<input type="hidden" name="sal_date" value="" />
	 <input type="hidden" name="dep_no2" value="" /> 
	 <input type="hidden" name="dep_no" value="" />
</form>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>

<script type="text/javascript">
	//옵션 선택시 
	var optionPtrn = "<option value='%V' %S>%T</option>";

	var departmentCode = $("select[name='dep_no2']").data(
			// 부서코드
			"success",
			function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
				var html = "";
				$.each(resp, function(idx, dep) {

					html += optionPtrn.replace("%V", dep.DEP_NO).replace("%T",
							dep.DEP_NAME)

				});
				departmentCode.append(html);
			}).on("change", function() { // 부서 선택 마다 소속팀이 바뀌는거 
		let dep_no = $(this).val();

		dep_no2.trigger("renew", {
			dep_no2 : dep_no
		// 키 : 값  dep_no2에 dep_no 를 넣어주는거  
		});
	});

	var dep_no2 = $("select[name='dep_no']").data(
			// 소속 팀
			"success",
			function(resp) {
				var html = "<option value>소속팀</option>";
				$.each(resp, function(idx, dep) {
					html += optionPtrn.replace("%V", dep.dep_no).replace("%T",
							dep.dep_name)
				});
				dep_no2.html(html)
			});

	$(".dynamicElement").dynamicSelect();

	// 리스트 목록 출력하는 거 
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging(
			{
				searchUI : "#searchUI",
				searchBtn : "#searchBtn",
				pagination : "#pagingArea",
				pageParam : "page",
				byAjax : true,
				success : function(resp) { 
					let empList = resp.dataList;
					let pagingHTML = resp.pagingHTML;
					console.log(empList);
					let trTags = [];
					if (empList.length > 0) {
						$.each(empList, function(idx, emp) {
							let trTag = $("<tr>").append(
									$("<td>").text(idx+1), // 순차적으로 값을 뿌려주는거 
									$("<td>").text(emp.name),
									$("<td>").text(emp.dep_no),
									$("<td>").text(emp.pos_no),
									 $("<td>").text(emp.emp_no),
									$("<td>").text(emp.emp_name));
							trTags.push(trTag);
						});
						$("#pagingArea").html(pagingHTML);
					} else {
						trTags.push($("<tr>").html(
								$("<td colspan='5'>").text("조건에 맞는 사원이 없음.")));
						$("#pagingArea").empty();
					}
					listBody.html(trTags);
					listBody.data("currentpage", resp.currentPage);
					searchForm.find("[name='page']").val("");
				}
			}).submit();

	// 모달창에서 수정버튼을 눌렀을떄
	var upBtn = $("#upBtn").on(
			"click", // 수정버튼을 눌렀을 때
			function(event) {
				
				// 버튼의 이름을 바꾸기만 하는거 
				if ('수정' == upBtn.text()) { // '수정'하고 수정버튼하고 같으면 
					upBtn.text('등록'); // 버튼의 이름을 등록으로 바꾸고 
					exampleModal.find('.form-control').not('.code').removeAttr('readonly'); // readonly를 지운다.
					exampleModal.find('.form-control').not('.code').removeAttr('disabled'); // disable 를 지운다. 
					exampleModal.find("input[name='emp_gen']").not('.code').removeAttr('disabled');
					exampleModal.find("input[name='country']").not('.code').removeAttr('disabled');
					exampleModal.find("input[name='btn']").not('.code').removeAttr('disabled');
					exampleModal.find("button[name='seach']").not('.code').removeAttr('disabled');
					 $(".dynamicElement").dynamicSelect();
					return;
				}
				
				// 등록 버튼을 눌렀을 때
				var form = exampleModal.find("form")[0]; // 모달 id = exampleModal 에서 form 를 찾아서 form 에 넣어두고 
				var data = new FormData(form); //새로운 데이터를 formdmf 넣는다. 
				//	 	data.append("file", $("#input_img")[0].files[0]);
				var emp_no = exampleModal.find(  // 모달창에서 id가 emp_no를 찾아서 
						"#emp_no").text();  //
				$.ajax({
					url : "${cPath}/emp/manage/empInput/" + emp_no, // 모달창을 수정하고 컨트롤러로 넘어가는거 ???
					processData : false,
					contentType : false,
					type : 'post',
					data : data,
					dataType : "text", // Accept:application/json, Content-Type:application/json
					success : function(resp) { // 등록버튼을 누르고 콘솔의 결과 값으러 돌오는거??
					 if(resp == '수정성공'){
// 						loadAccountView(emp_no);
						alert(resp);
						$("#exampleModal").modal("hide");
					 }else{
						 alert(resp);
					 }
					 
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
		upBtn.text('수정');
	});


	/// 행 클릭시 모달창 나오는 
	function loadAssetsView(emp_no) {
		$.ajax({
			url : "<c:url value='/emp/manage/'/>" +emp_no,
			dataType : "html", // Accept:application/json, Content-Type:application/json
			success : function(resp) {
				exampleModal.find(".modal-body").html(resp);
				exampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	
	
	// 사원리스트에서 하나를 클릭했을 떄
	$("#listBody").on("click", "tr", function() {
		let emp_no = $(this).find("td").eq(4).text(); //  0 1 2 3 4  3번째 td 의 값을 주소값으로 넘겨주는거 
		loadAssetsView(emp_no);
	}).css({
		cursor : "pointer"
	});
</script>