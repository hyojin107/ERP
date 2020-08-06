<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 검색버튼을 눌렀을 때 내용 가져오는거? -->
<form id="searchForm" action="${pageContext.request.contextPath }/emp/manage/ann" method="get" >
	<input type="hidden" name="page" value="${param.page }" /> 
 	 <input type="hidden" name="dep_no2" value="" />  
 	 <input type="hidden" name="dep_no" value="" /> 
 	 <input type="hidden" name="ann_status" value="" /> 
</form>
<h1>인사발령</h1>  
<div class=" " id="searchUI">
	<thead class="table table-bordered table-hover text-left">
		<tr class="row">
			<td class="col-2 form-inline"><select
				class="dynamicElement form-controlmr-2 " name="dep_no2"
				data-url="<c:url value='/emp/manage/departmentList'/>">
					<option value="">부서명</option>
			</select></td>
		</tr>
		<tr class="row">
			<td class="col-2 form-inline"><select
				class="dynamicElement form-controlmr-2" name="dep_no"
				data-url="<c:url value='/emp/manage/TeamList'/>">
					<option value="">소속 팀</option>
			</select></td>
		</tr>
		<tr class="row">
			<td class="col-2 form-inline"><select
				class="dynamicElement form-controlmr-2" name="ann_status"
				data-url="<c:url value='/emp/manage/annList'/>">
					<option value="">발령상태</option>
			</select></td>
		</tr>
		<tr class="row">
			<td class="col-8"><input type="submit" value="검색" id="searchBtn"></td>
		</tr>
		<tr>
			<td>
				<a href="<c:url value='/emp/manage/ann/announcementNewUpdate'/>">
						<button  style="align:right" class="btn btn-success">신규발령</button>
				</a>
		</td>
	</thead>
</div>

   
<table class="table table-bordered table-hover text-left" id="datatable">
	<thead class="table-primary">
		<tr>
			<th id='allchk'><input type="checkbox" class='allchk'></th>
<!-- 			<th>no.</th> -->
			<th>소속</th>
			<th>직급</th>
			<th>사원ID</th>
			<th>성명</th>
			<th>발령내용</th>
			<th>발령상태</th>
			<th>등록일자</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
<tbody id="listBody">

	</tbody>
	<tfoot>
		<tr>
			<td colspan="7">
				<div class="d-block d-md-flex align-items-center d-print-none">
					<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
						${pagingVO.pagingHTML }</nav>
				</div>
				<button class="btn btn-success up" data-no='B002' >발령완료</button> 
				<button	class="btn btn-success up" data-no='B003' >발령취소</button> 
				<button class="btn btn-success">삭제</button>
			</td>
		</tr>
	</tfoot>
</table>

<input type="hidden" name="page" value="${param.page }" />

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
			<!-- 	<button type="button" class="btn btn-primary" id='upBtn'>수정</button> -->
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 업데이트 발령완료, 발령취소 버튼을 눌렀을떄  -->
<form action="${cPath}/emp/manage/ann" id="upform">
	<input type="hidden" name="ann_no" id="ann_no" value="${emp.ann_no }">
	<input type="hidden" name="ann_status" id="name" value="${emp.ann_status }">
	
</form>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>

<script type="text/javascript">

	//옵션 선택시 
	var optionPtrn = "<option value='%V' %S>%T</option>";

	var departmentCode = $("select[name='dep_no2']").data( //data 는 db의 부서명을 가져오는거 
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
	
	// 발령상태 - 리스트에 있는거 
	var ann_status = $("select[name='ann_status']").data(
		"success",
		function(resp){
			var html = "<option value>발령상태</option>";
			$.each(resp, function(idx, emp){
				html += optionPtrn.replace("%V", emp.code).replace("%T",
						emp.name)
			});
			ann_status.html(html);
			});

	$(".dynamicElement").dynamicSelect();

	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging( // searchForm 검색 폼 id
			{
				searchUI : "#searchUI",     //  부서명, 소속 검색하는거 맨 위에  아이디값을 불러옴
				searchBtn : "#searchBtn",   // 부서명, 소속 검색하는거 맨 위에 검색버튼  아이디값을 불러옴
				pagination : "#pagingArea", // 페이징
				pageParam : "page",         // searchForm 의 히든으로 되어 있는 id 값
				byAjax : true,
				success : function(resp) { // 검색을 눌렀을 때 action으로 넘어가는 컨트롤러의 값  
					let empList = resp.dataList;  // setDataList
					let pagingHTML = resp.pagingHTML; // 페이징 값
					console.log(empList);
					let trTags = []; // 배열
					if (empList.length > 0) {  // 리스트에 뿌려지는 값 
						$.each(empList, function(idx, emp) {
							let trTag = $("<tr>").append(
									$("<td>").addClass("area").html("<input type='checkbox' class='area'>"), // 체크박스 td
// 									$("<td>").text(emp.rnum),
									$("<td>").text(emp.dep_no),
									$("<td>").text(emp.pos_no),
									$("<td>").text(emp.emp_no),
									$("<td>").text(emp.emp_name),
									$("<td>").text(emp.remark),
									$("<td>").text(emp.name),
									$("<td>").text(emp.today_ann)
									).data("ann_no", emp.ann_no); // tr태그에 데이터를 넣어두는거  ann_no pk값
							trTags.push(trTag); //trTags 배열에 trTag를 넣음
						});
						$("#pagingArea").html(pagingHTML);
					}else{
						trTags.push($("<tr>").html(
								$("<td colspan='7'>").text("조건에 맞는 사원이 없음.")));
						$("#pagingArea").empty();
					}
					listBody.html(trTags); //  listBody에 trTags를 붙임
					listBody.data("currentpage", resp.currentPage);
					searchForm.find("[name='page']").val("");
				}
			}).submit();

	var exampleModal = $("#exampleModal").modal({
		show : false
	}).on("hidden.bs.modal", function() {
		exampleModal.find(".modal-body").empty();
// 		upBtn.text('수정');
	});



	var exampleModal = $("#exampleModal").modal({
		show : false
	}).on("hidden.bs.modal", function() {
		exampleModal.find(".modal-body").empty();
	});

	/// 행 클릭시 모달창 나오는 
	function checkedView(ann_no) {

		
		$.ajax({ // 행을 클릭 하면  아래 경로 콘트롤러로 이동 하고 모달창이 보여지는거 
			url : "<c:url value='/emp/manage/ann/'/>"+ann_no,
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

	// 체크 박스 눌렀을 때
	
	// 첫번째 칸을 눌렀을 때 체크가 되도록하는거      
	$("#listBody").on("click", "tr", function(e){ // 1. 체크박스를 클릭하면 
		if($(e.target).hasClass("area")) { 	// 체크박스를 클릭하면 ..target이 area가 있으면
			// e.target 내가 클릭한 가장 깊이 들어가 있는 요소 
			var check = $(e.target).data("ann_no"); // target은 내가 누른 td를 말하는거  한칸 의 안 속 박스
			if($(e.target)[0]==$(this).find("td")[0]){ // 체크박스가 있는 칸을  눌렀을 떄 체크가 되도록 해주는거 
 				if(!check.is(":checked")) { // 체크박스가 checked가 아니면 checked를 해주고 
					console.log(check);
					check.prop("checked",true);
				} // 체크박스가 체크 되어 있으면 false로 해준다.
				else check.prop("checked",false);
			}
			return;
		} // .target이 area가 없으면 if문 건너뛰고  
		let ann_no = $(this).data("ann_no"); //
		checkedView(ann_no); // 체크박스가 아니라 행을 클릭했을 경우  모달창이 띄어지는 function으로 이동
	}).css({cursor:"pointer"}); // 행에 cursor를 올리면 보이도록 

	// 맨위의 체크 박스  전체선택?을 하는 느낌?
	$("#allchk").on("click", function(e){
		let bool = false; 
		if($(e.target)[0]==$(this).find("input")[0] && $(this).find("input").is(":checked")) bool = true;
		if($(e.target)[0]!=$(this).find("input")[0] && !$(this).find("input").is(":checked")) bool = true;
		$("input").prop("checked",bool);
	}).css({cursor:"pointer"});

	
	// 발령 완료, 발령 취소 버튼의 class up
	$(".up").on("click", function(){ // 발령취소, 발령완료를 클릭하면 
		result = "";
		var first_sign = $("#name").val(); // name의 속성을 first_sign에 담기 
		var no = $(this).data("no"); // 클릭을 했을떄 no 값 b002 /b003 을  no 에 넣음
		
		console.log(" 발령완료 버튼 누르고 >> " + no);
		
		$.each($("input").not('.allchk'),function(idx, input){ // 맨위의 체크박스만 빼고 체크박스가 each(for문 )
			if($(input).is(":checked")) upda($(input).parent().parent().data("ann_no"),no); // tr태그를 찾는거찾아서 no에 no를 넣는거  
		});
// 		 if(result.length > 3){ //???
// 			result = result.substring(0,result.length()-2);
// 			result += " 발령완료";
// 			alert(result);
// 		} 
		$("#name").val(first_sign); // name 속성 값에 first sign을 넣는거 
		searchForm.submit();
	});
// 	searchForm.on("submit", function(){
// 		$("input[name='chit_date']").val("");
// 	});
	
	
	var result ="";
	function upda(ann_no, name){ // 버튼을 선택한 값을  각각 넣어주기 
		console.log(ann_no);
		console.log(name);
		var ann_no2 = $("#ann_no").val(ann_no);
		var name2 = $("#name").val(name);
		
		console.log(ann_no2);
		console.log(name2);
		
		
		var parameters = $("#upform").serialize();
		var action = $("#upform").attr("action");
		
		$.ajax({
			url : action,
			data : parameters,
			method : "post",
			dataType : "text", // Accept:application/json, Content-Type:application/json
			success : function(resp) { // resp 콘트롤러에서 리턴된 값  수정성공, 실패
				
				console.log("resp>>>>>>>>>>>>>>      "+resp)
				  if(resp == '수정성공'){ // DB값을 바꾸었을 때  수정 성공  
					  result = alert("발령상태 변경완료");
				}else{
					result = alert("발령상태  변경실패");
				}
								
			},
			error : function(errorResp) {
			
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
		};
	
	
	
	
</script>