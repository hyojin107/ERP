<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>월간 근태 관리</h1> 

<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI"> 
 <thead class="table-primary">
		<tr class="row">
			<th>날짜</th>
			<td class="col-1" ><input type="date"  name="work_date"></td>
		</tr>
		 <tr class="row">	
			<td class="col-3">부서</td>
			<td class="col-3  form-inline">
			 	<select class="dynamicElement  form-control mr-2" name="dep_no2"
					data-url="<c:url value='/emp/manage/departmentList'/>">
					<option value="">부서명</option>
				</select>
			</td>
		</tr>
		<tr  class="row">	
			<td class="col-3">소속팀</td>
			<td class="col-3 form-inline">
					 <select class="dynamicElement form-control  mr-2" name="dep_no"
						data-url="<c:url value='/emp/manage/TeamList' />">
						<option value="">소속 팀</option>
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
			<th>날짜</th>
			<th>소속</th>
			<th>직급</th>
			<th>사원명</th>
			<th>출근일수</th>
			<th>연장시간</th>
			<th>지각</th>
			<th>결근</th>
			<th>조퇴</th>
			<th>비고</th>
			
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8">
				<!--  <div class="d-block d-md-flex align-items-center d-print-none">
 				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
				</div>  --> 
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
				<!-- </div>  -->
			</td>
		</tr>
	</tfoot> 
</table>
</div>

<!-- ajax 로 controller에 넘어가는거  -->
 <form id="searchForm" action="${pageContext.request.contextPath }/emp/work/monthList">
	<input type="hidden" name="page" value="${param.page}"/>
	<input type="hidden" name="work_date" value=""/>
	<input type="hidden" name="dep_no2" value=""/>
	<input type="hidden" name="dep_no" value=""/>
</form>  

<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>

<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI :"#searchUI",
		searchBtn :"#searchBtn",
		pagination :"#pagingArea",
		pageParam :"page",
		byAjax:true,
		success:function(resp){
			let workList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(workList.length>0){
				$.each(workList, function(idx, work){
					let trTag = $("<tr>").append(
									$("<td>").text(work.rnum)
									,$("<td>").text(work.work_date)
									,$("<td>").text(work.dep_no)
									,$("<td>").text(work.pos_no)
									, $("<td>").text(work.emp_name)
									, $("<td>").text(work.work_time)
									, $("<td>").text(work.extendsTime)
									, $("<td>").text("지각")
									, $("<td>").text("결근")
									, $("<td>").text("조퇴")
									, $("<td>").text("비고"));
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
						$("<td colspan='5'>").text("조건에 맞는 게시글이 없음.")));
				$("#pagingArea").empty();
			}
			listBody.html(trTags);
			listBody.data("currentpage", resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();

		// 옵션 선택시 
		var optionPtrn = "<option value='%V' %S>%T</option>";
		var departmentCode = $("select[name='dep_no2']").data( // 부서코드
				"success",
				function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
					var html = "";
					$.each(resp, function(idx, dep) {
						html += optionPtrn.replace("%V", dep.DEP_NO) //emplist.xml에서hashmap이라서 대문자
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
	</script>