<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
<thead class="table-primary">
		<tr>		
			<td class="col-1">부서</td>
			<td class="col-1 form-inline">
			 
				<select class="dynamicElement  mr-2" name="dep_no2"
					data-url="<c:url value='/emp/manage/departmentList'/>">
					<option value>부서명</option>
				</select>
			 
			</td>
			<td class="col-1">소속팀</td>
			<td class="col-1 form-inline">
					 <select class="dynamicElement  mr-2" name="dep_no"
						data-url="<c:url value='/emp/manage/TeamList' />">
						<option value>소속 팀</option>
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
			<th>부서</th>
			<th>소속</th>
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
					${pagingVO.pagingHTML }
				</nav>	
			</td>
		</tr>
	</tfoot>
</table>
</div>

<form id="searchForm" action="${pageContext.request.contextPath }/emp/manage"   method="get">
	<input type="hidden" name="page" value="${param.page }"/>
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
		var searchForm = $("#searchForm").paging(
				{
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
							$.each(empList, function(idx, emp) {
								let trTag = $("<tr>").append(
										$("<td>").text(emp.rnum),
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
	
// 		// 행하나 클릭시 선택한 사원의 정보가 화면에 뿌져지도록
// 		function empInfoView(emp_no){
// 			$.ajax({
// 				url :"<c:url value='/emp/retire/retirementForm/'/>"+emp_no,
// 				dataType :"json",
// 				success: function(resp){ // 컨트롤러에서 vo를 넘겨준 값 ㄴ
// 					$(".emp1")[0].text(resp.dep_no); 
// 					$(".emp1")[1].text(resp.pos_no);
// 					$(".emp1")[2].text(resp.hire_date); 
// 					$(".emp1")[3].text(resp.emp_name);
// 					$(".emp1")[4].text(resp.name); 
// 					$("#exampleModal").modai("hide");// 행을 클릭하면 모달이 숨겨지는거	
// 				}
// 			});
// 		}
				
// 		$("#listBody").on("click","tr", function(){
// 			let empInfo = $(this).find("td").eq(3).text();
// 			empInfoView(empInfo);
// 		}).css({
// 			cursor : "pointer"
// 		});


</script>	

