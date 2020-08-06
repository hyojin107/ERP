<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1>급여명세서발송</h1>

<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
	<thead class="table-primary">
		<tr class="row">
			<th>날짜</th>
			<td class="col-1"><input type="date" name="sal_date"></td>
		</tr>
		<tr class="row">
			<td class="">부서</td>
			<td class=" form-inline"><select class="dynamicElement  mr-2"
				name="dep_no2" data-url="<c:url value='departmentList'/>">
					<option value="">부서명</option>
			</select></td>
		</tr>
		<tr class="row">
			<td class="">소속팀</td>
			<td class=" form-inline"><select class="dynamicElement  mr-2"
				name="dep_no" data-url="<c:url value='TeamList' />">
					<option value="">소속 팀</option>
			</select></td>
			<td>
			<td class="col-1"><input type="submit" value="검색" id="searchBtn"></td>
		</tr>
	</thead>
</div>
<div>
	<table class="table table-bordered table-hover text-left">
		<thead class="table-primary">
			<tr>
				<th>no</th>
				<th>사원ID</th>
				<th>성명</th>
				<th>소속</th>
				<th>직급</th>
				<th>지급일자</th>
				<th>은행</th>
				<th>계좌번호</th>
				<th>E-mail</th>
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
			</tr>
			<nav>
				<td colspan="8"><a
					href="<c:url value='/emp/manage/emailModal'/>">
						<button class="btn btn-success">메일전송</button>
				</a></td>
			</nav>
		</tfoot>
	</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl"
		style="max-width: 100%; width: auto; display: table;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">급여내역</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<!-- 모달창 내용이 들어가는 곳  -->
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<form id="searchForm"
	action="${pageContext.request.contextPath }/emp/salary" method="get">
	<input type="hidden" name="page" value="${param.page }" /> <input
		type="hidden" name="sal_date" value="" /> <input type="hidden"
		name="dep_no2" value="" /> <input type="hidden" name="dep_no" value="" />
</form>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
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


	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let emailList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(emailList.length>0){
				$.each(emailList, function(idx, emp){
					let trTag = $("<tr>").append(
									$("<td>").addClass("area").html("<input type='checkbox' class='area'>") // area라는 체크박스를 추가하는 거
									,$("<td>").text(emp.rnum)
									,$("<td>").text(emp.emp_no)
									,$("<td>").text(emp.emp_name)
									,$("<td>").text(emp.dep_no)
									,$("<td>").text(emp.pos_no)
									,$("<td>").text(emp.sal_date)
									,$("<td>").text(emp.bank)
									,$("<td>").text(emp.emp_bankno)
									,$("<td>").text(emp.emp_email)
									);
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
			url : "<c:url value='/emp/salary/'/>" + emp_no,
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
// 	// 1번 listBody 를 클릭시 
// 	$("#listBody").on("click", "tr", function() {
// 		let retirement = $(this).find("td").eq(1).text(); //  0 1 2 3 4  3번째 td 의 값을 주소값으로 넘겨주는거 
// 		loadAssetsView(retirement);
// 	}).css({
// 		cursor : "pointer"
// 	});

	//체크박스 클릭시 , 체크 하는거 
	$("#listBody").on("click", function(e){ //
		if($(e.target).hasClass("area")){ // 클릭한것에 area게 있으면 
			var check = this.find("emp_email"); // 클릭한것에 this에서 인덱스가 9번째 td를 찾는거 
			if($(e.target)[0]==$(this).find("td")[0]){
				check.prop("checked",true); // 체크박스에 checked가 되어 있으면 
				// 체크된 사원의 이메일을 꺼내와서 controller에 보내준다?????????????
				}

			// text로  찾은 값을 가져오기 
				// 어디다 넣주고 
			else check.prop("checked",false);

		}
		return;
		// tr 클릭시 모달창 나오는 부분 
		let retirement = $(this).find("td").eq(1).text(); //  0 1 2 3 4  3번째 td 의 값을 주소값으로 넘겨주는거 
		loadAssetsView(retirement);
	}).css({cursor:"pointer"});

</script>