<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>일일근태관리</h1>  

<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
 <thead class="table-primary">
		<tr class="row">
			<th>날짜</th>
			<td class="col-1"><input type="date" name="work_date"></td>
		</tr>	
			<tr  class="row">
				<th class="col-3">부서</th>
				<td class="col-3 form-inline">
					<select class="dynamicElement form-control  mr-2" name="dep_no2"
						data-url="<c:url value='/emp/manage/departmentList'/>">
						<option value="">부서명</option>
					</select>
				</td>
			</tr>
			
			<tr class="row">
				<th class="col-3">소속팀</th>
				<td class="col-3 form-inline">
						 <select class="dynamicElement  mr-2" name="dep_no"
							data-url="<c:url value='/emp/manage/TeamList' />">
							<option value="">소속 팀</option>
						</select>
				</td>
			<td class="col-1"><input type="submit" value="검색" id="searchBtn"></td>
		</tr>
</thead>
</div>

<!--  모달창 등록, 수정 페이지 -->
 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일일근태수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="upBtn">수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>



<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>No.</th>
			<th>날짜</th>
			<th>소속</th>
			<th>직급</th>
			<th>사원id</th>
			<th>사원성명</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>지각시간</th>
			<th>연장시간</th>
			
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
			</td>
		</tr>
	</tfoot>
</table>


<form id="searchForm" action="${pageContext.request.contextPath}/emp/work" method="get">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="work_date" value=""/>
	<input type="hidden" name="dep_no2" value=""/>
	<input type="hidden" name="dep_no" value=""/>
</form> 


<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
	
<script type="text/javascript">

		// 옵션 선택시 
		var optionPtrn = "<option value='%V'  %S>%T</option>";
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
								.replace("%T", dep.dep_name);
					});
					dep_no2.html(html);
				});
		
		$(".dynamicElement").dynamicSelect();

	
	// 리스트 목록 출력 하는거 
	
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let workList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(workList.length>0){
				$.each(workList, function(idx, work){
					let trTag = $("<tr>").append(
									$("<td>").text(work.rnum)
									, $("<td>").text(work.work_date)
									, $("<td>").text(work.dep_no)												
									, $("<td>").text(work.pos_no)
									, $("<td>").text(work.emp_no)
									, $("<td>").text(work.emp_name)
									, $("<td>").text(work.work_time)
									, $("<td>").text(work.offwork_time)
									, $("<td>").text(work.lateTime)
									, $("<td>").text(work.extendsTime)); // 연장시간
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

// 	// 모달창 
	var examplemodal = $("#examplemodal").modal({
		show : false
	}).on("hidden.bs.modal", function(){
		$("#examplemodal").find(".modal-body").empty();
		upbtn.text('수정');
	});

	
	
	// 행 하나를 눌렀을 떄  클릭 시점을 사원으로 잡는거 
	$("#listBody").on("click","tr",function(){
		let emp_no = $(this).find("td").eq(4).text();
		loadAssetsView(emp_no);
	}).css({
		cursor:"pointer"
	});
	
	
	//  행클릭시 사원번호로 모달창으로 넘기는거 
	function loadAssetsView(emp_no){
		$.ajax({
			url : "<c:url value='/emp/work/'/>"+emp_no,
			dataType : "html",
			success : function(resp){
				$("#exampleModal").find(".modal-body").html(resp);
				$("#exampleModal").modal("show");
			},
			error : function(errorResp){
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	
	
	// '수정' 버튼을 눌렀을 떄  모달차엥서 수정버튼을 눌렀을 떄 
	var upBtn = $("#upBtn").on("click", function(event){
			if('수정' == upBtn.text()){
				upBtn.text('등록');
				$("#exampleModal").find("input[type='text']").not('.code').removeAttr('readonly');
				 $(".dynamicElement").dynamicSelect();
					return;
			}
			
			// 등록 버튼을 눌렀을 때
			var form = $("#exampleModal").find("form")[0];
			var data = new FormData(form);
			
			var emp_no = $("#exampleModal").find("#emp_no").text();
				$.ajax({
					url : "${cPath}/emp/work/upTime/"+emp_no,
					processData : false,
					contentType : false,
					type : 'post',
					data : data,
					dataType : "text",
					success : function(resp){
						if(resp == '수정성공'){
							loadAssetsView(emp_no);
							alert(resp);
							$("#exampleModal").modal("hide");
						}else{
							alert(resp);
						}
					}
				})
		})
</script>