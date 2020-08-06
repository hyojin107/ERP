<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>퇴직금정산</h1>  

<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">			
<thead class="table-primary">
		<tr class="row"> 
 			<th class="col-3">부서</th>
			<td class="col-2 form-inline"><select
				class="dynamicElement form-control mr-2 " name="dep_no2"
				data-url="<c:url value='/emp/manage/departmentList'/>">
					<option value="">부서명</option>
			</select>
			</td>
 		</tr> 
 		<tr class="row">	
			<td class="col-2 form-inline">
			<th class="col-3">소속팀</th>
			<select
				class="dynamicElement form-control mr-2" name="dep_no"
				data-url="<c:url value='/emp/manage/TeamList'/>">
					<option value="">소속 팀</option>
			</select>
			</td>
		</tr>
		<tr class="row">	
			<td class="col-2 form-inline">
			<th class="col-3">정산구분</th>
			<select class="dynamicElement form-control mr-2" name="retire_reason" value="${emp.retire_reason}"> 
														<!-- name ==>vo에 있는거 컨트롤러에 vo 값으로 들어갈수 잇도록  -->
				<option value="">정산구분</option>
				<c:forEach items="${retireList}" var="retire">
					<option value="${retire.code}">${retire.name}</option>
				</c:forEach>					
			</select>
			</td>
			<td class="col-1"><input type="submit" value="검색" id="searchBtn"></td>
		</tr>
	</thead>
</div>	
<div>   
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>No.</th>
			<th>소속</th>
			<th>직급</th>
			<th>사원ID</th>
			<th>성명</th>
			<th>정산여부</th>
			<th>지급날짜</th>
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
			<a href="<c:url value='/emp/retire/retirementForm'/>">
				<button class="btn btn-success">등록</button></a>
			</td>
		</tr>
	</tfoot>
</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" style="max-width: 100%; width: auto; display: table;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">퇴직금 영수증</h5>
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

 <form id="searchForm" action="${pageContext.request.contextPath }/emp/retire"   method="get">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="dep_no2" value=""/>
	<input type="hidden" name="dep_no" value=""/>
	<input type="hidden" name="retire_reason" value=""/>
</form> 
<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">



		//옵션 선택시 
		var optionPtrn = "<option value='%V' %S>%T</option>";
		var departmentCode = $("select[name='dep_no2']").data( // 부서코드
				"success",
				function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
					var html = "";
					$.each(resp, function(idx, dep) {
						html += optionPtrn.replace("%V", dep.DEP_NO)
								.replace("%T", dep.DEP_NAME);
					});
					departmentCode.append(html);
				}).on("change", function() {  // 부서 선택 마다 소속팀이 바뀌는거 
			let dep_no = $(this).val();
		
			dep_no2.trigger("renew", {
				dep_no2 : dep_no
			});
		});
		
		var dep_no2 = $("select[name='dep_no']").data( // 소속 팀
				"success",
				function(resp) {
					var html = "<option value>소속팀</option>";
					$.each(resp, function(idx, dep) {
						html += optionPtrn.replace("%V", dep.dep_no)
								.replace("%T", dep.dep_name)
					});
					dep_no2.html(html);
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
			let retiList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			console.log(retiList);
			let trTags = [];
			if (retiList.length > 0) {
				$.each(retiList,function(idx, emp) {
				let trTag = $("<tr>")
					.append(
							$("<td>").text(emp.rnum),
							$("<td>").text(emp.dep_no),
							$("<td>").text(emp.pos_no),
							$("<td>").text(emp.emp_no),
							$("<td>").text(emp.emp_name),
							$("<td>").text(emp.retire_reason),
							$("<td>").text(emp.payment_day));
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
	
		
	// 모달창 	
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
						upBtn.text('등록');
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
		function loadAssetsView(emp_no) {
			$.ajax({
				url : "<c:url value='/emp/retire/'/>" + emp_no,
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
		
		
		// 1번 listBody 를 클릭시 
		$("#listBody").on("click", "tr", function() {
			let retirement = $(this).find("td").eq(3).text(); //  0 1 2 3 4  3번째 td 의 값을 주소값으로 넘겨주는거 
			loadAssetsView(retirement);
		}).css({
			cursor : "pointer"
		});
	</script>