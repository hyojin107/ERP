<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1 style="padding-left: 30px;padding-top: 25px;">급여내역</h1>

<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI" style="padding-left: 30px; padding-top: 10px;">
<thead class="table-primary">
		<tr  class="row">
			<td class="col-1">날짜</td>
			<td class="col-1"><input type="date" name="sal_date"></td>
		</tr> 
 		<tr class="row"> 
 			<th class="col-3">부서</th>
			<td class="col-2 form-inline"><select
				class="dynamicElement form-control mr-2 " name="dep_no2"
				data-url="<c:url value='departmentList'/>">
					<option value="">부서명</option>

			</select>
			</td>
 		</tr> 
 		<tr class="row">	
			<td class="col-2 form-inline">
			<th class="col-3">소속팀</th>
			<select
				class="dynamicElement form-control mr-2" name="dep_no"
				data-url="<c:url value='TeamList'/>">
					<option value="">소속 팀</option>
			</select>
			</td>
			<td class="col-1"><input type="submit" value="검색" id="searchBtn"></td>
		</tr>
</thead>
</div>

<div style="background-color: white; margin: 30px; margin-right: 55px;">
<table class="table table-bordered table-hover text-left">
	<thead>
		<tr>
			<th>No.</th>
			<th>급여일</th>
			<th>소속</th>
			<th>직급</th>
			<th>사원ID</th>
			<th>성명</th>
		</tr>
	</thead>
	<tbody id="listBody">
		<tr>
			<td>1</td>
			<td>2020-07-12</td>
			<td>인사부서</td>
			<td>과장</td>
			<td>2020070102</td>
			<td>연지은</td>
		</tr>
		<tr>
			<td>2</td>
			<td>2020-07-12</td>
			<td>인사부서</td>
			<td>과장</td>
			<td>2020070102</td>
			<td>연지은</td>
		</tr>
		<tr>
			<td>3</td>
			<td>2020-07-12</td>
			<td>인사부서</td>
			<td>과장</td>
			<td>2020070102</td>
			<td>연지은</td>
		</tr>
		<tr>
			<td>4</td>
			<td>2020-07-12</td>
			<td>인사부서</td>
			<td>과장</td>
			<td>2020070102</td>
			<td>연지은</td>
		</tr>
	</tbody>
</table>
</div>
<div style="padding-left: 30px; padding-top: 10px;">
	<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
		${pagingVO.pagingHTML }
	</nav>	
</div>


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" style="max-width: 100%; width: auto; display: table;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">급여정보</h5>
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



<!-- 검색버튼을 눌렀을 때 내용 가져오는거? -->
<form id="searchForm" action="${pageContext.request.contextPath }/emp/salary" method="get">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="sal_date" value=""/>
	<input type="hidden" name="dep_no2" value=""/>
	<input type="hidden" name="dep_no" value=""/>
</form>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>

<script type="text/javascript">
			//옵션 선택시 
			var optionPtrn = "<option value='%V' %S>%T</option>";
			
			var departmentCode = $("select[name='dep_no2']").data( // 부서를 선택하면
					// 부서코드
					"success",
					function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
						var html = "";
					
						$.each(resp, function(idx, dep) {
			
							html += optionPtrn.replace("%V", dep.DEP_NO).replace("%T", // 선택된 값을 옵션의 이름으로 바꿔주는거 
									dep.DEP_NAME)
						});
						departmentCode.append(html);
					}).on("change", function() { // 부서 선택 마다 소속팀이 바뀌는거 
						
				let dep_no = $(this).val(); // dep_no에 부서를  불러오는거 
			
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
							html += optionPtrn.replace("%V", dep.dep_no).replace("%T", dep.dep_name)
						});
						dep_no2.html(html)
					});
			
			$(".dynamicElement").dynamicSelect();
	

	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
			searchUI : "#searchUI",
			searchBtn : "#searchBtn",
			pagination : "#pagingArea",
			pageParam : "page",
			byAjax : true,
			success : function(resp) { //
				let empList = resp.dataList;
				let pagingHTML = resp.pagingHTML;
				console.log(empList);
				let trTags = [];
				if (empList.length > 0) {
					$.each(empList,function(idx, emp) {
					let trTag = $("<tr>")
						.append(
								$("<td>").text(emp.rnum),
								$("<td>").text(emp.sal_date),
								$("<td>").text(emp.dep_no),
								$("<td>").text(emp.pos_no),
								$("<td>").text(emp.emp_no),
								$("<td>").text(emp.emp_name)
								);
				trTags.push(trTag);
									});
					$("#pagingArea").html(pagingHTML);
				} else {
					trTags.push($("<tr>").html(
							$("<td colspan='5'>").text(
									"조건에 맞는 게시글이 없음.")));
					$("#pagingArea").empty();
				}
				listBody.html(trTags);
				listBody.data("currentpage", resp.currentPage);
				searchForm.find("[name='page']").val("");
			}
		}).submit();


		// 모달창 	 수정버튼을 누르면  모달을 숨기는거 
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
						upBtn.text('등록');  // 수정버튼을 누르면  버튼이 등록으로 바꾼다.
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
		function loadAssetsView(emp_no) {//2번 td의 첫번쩨 == emp_no를 파라미터로 넣어준다.
			$.ajax({
				url : "<c:url value='/emp/salary/'/>" + emp_no, // 컨트롤러에 연결하는거
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
			let retirement = $(this).find("td").eq(3).text(); //  0 1 2 3 4  3번째 td 의 값을 주소값으로 넘겨주는거 
			loadAssetsView(retirement); // td의 1번을 찾아서 function에 넣어준다.
		}).css({
			cursor : "pointer"
		});
		
</script>