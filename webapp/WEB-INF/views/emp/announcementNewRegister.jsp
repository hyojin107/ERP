<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사원검색</h5>
			 	<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-secondary" id="confirm_btn">확인</button>
			</div> -->
		</div>
	</div>
</div> 


<form:form  id="annRegistar" modelAttribute="ann" method="post" enctype="multipart/form-data" class="w-100" 
       action="${cPath}${currentAction}">
       
   
    
사원정보 <input type="button" value="검색" id="search"/>
<table class="table table-bordered  text-left">
	<thead class="">
		<tr >
			<td class=""> 소속 </td>
			<td class="emp1">${emp.dep_no}</td>	
			<td class="">직급 </td>
			<td class="emp1">${emp.pos_no} </td>	
			<td class="">입사일 </td> 
			<td class="emp1">${emp.hire_date}</td>
		</tr>
		<tr >
			<td>사원ID </td>
			<td class="emp1">${emp.emp_no}</td>
			<td>성명 </td>
			<td class="emp1">${emp.emp_name}</td>
			<td>구분</td>
			<td class="emp1">${emp.name }</td>
		</tr>
		
		<tr>
			<td>발령구분</td>
			<td class="">
				<select class="dynamicElement form-control mr-2" name="remark" >
					<option value="발령구분">발령구분</option>
					<option value="depart">부서이동</option>
					<option value="pos">직급이동</option>
					<option value="remove">해외파견</option>
				</select>
			</td>
			
			<td>발령내용</td>
			<!-- remark로 이름 정해놓은거  -->
			<td class=""> <!-- othersreadscontroller에서 가져오는거  -->
			<select  class="dynamicElement form-control mr-2 " name="dep_no2"  data-url="<c:url value='/emp/manage/departmentList'/>" >
				<option value="">부서명</option>
			</select>
			<select  class="dynamicElement form-control mr-2" name="dep_no" 	data-url="<c:url value='/emp/manage/TeamList'/>">
					<option value="">소속 팀</option>
			</select>
			<select  class="dynamicElement form-control mr-2" name="pos_no" 	data-url="<c:url value='/emp/manage/posList'/>">
					<option value="">직급</option>
			</select>
			<input type='hidden'  id='emp_no' value="${emp.emp_no}" name="emp_no" > 
			</td>

			<td>발령일자</td> 
		    <td><input type="date" name="ann_date" value="${emp.ann_date}"></td>	
		</tr>
		</thead>
	</tbody>
</table>
<%-- <form id="searchForm"
	action="${pageContext.request.contextPath }/emp/manage/ann" method="get">
	<input type="hidden" name="page" value="${param.page }" /> 
	 <input type="hidden" name="dep_no2" value="" /> 
	 <input type="hidden" name="dep_no" value="" />
	 <input type="hidden" name="pos" value="" />
</form> --%>
<tr class="row">
	<td class="col text-right">
	<input class="btn btn-success mr-2" type="submit" value="등록"> 
	<input 	class="btn btn-secondary mr-2" type="button" value="뒤로가기"	onclick="history.back();">
	</td>
</tr>
</form:form>


<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">

					$("select[name='pos_no']").hide();
					$("select[name='dep_no']").hide();
					$("select[name='dep_no2']").hide();
// 					$("select[name='remove']").hide();

					//옵션 선택시 
					var optionPtrn = "<option value='%V' %S>%T</option>";
					
					var departmentCode = $("select[name='remark']").on("change", function() { // 발령구분을 선택시 발령 내용이 바뀌는거 
						let dep_no = $(this).val(); // 선택된 value 값
					
						if(dep_no == "depart"){ // value 값이 depart (부서)이면 
							remark.trigger("renew", { //var remark 를 실행시키는거 
								dep_no2 : dep_no // dep_no를 dep_no2에 넣음
								// 키 : 값  dep_no2에 dep_no 를 넣어주는거  
								});
						// depart 를 선택하면 pos_no가 숨겨지는거 
								$("select[name='pos_no']").hide(); 
								$("select[name='remove']").hide(); 
								$("select[name='dep_no']").show(); 
								$("select[name='dep_no2']").show();
								
							
						}else if(dep_no=="pos"){ // value가 pos인것을 선택하면 
							$("select[name='dep_no']").hide();
							$("select[name='dep_no2']").hide();
							$("select[name='remove']").hide(); 
							$("select[name='pos_no']").show();
							
							pos.trigger("renew",{
								pos_no : dep_no // value 값이 pos이면 var pos를 시작하고 dep_no 에 pos_no로 값을 넣어준다. 
							});
							
						}	
							
							
					});
					
					var remark =  $("select[name='dep_no2']").data( //data 는 db의 부서명을 가져오는거 
							// 부서코드
							"success",
							function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
								var html = "";
								$.each(resp, function(idx, dep) {
									html += optionPtrn.replace("%V", dep.DEP_NO).replace("%T", dep.DEP_NAME)
								});
								remark.append(html);
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
					
					
					var pos = $("select[name='pos_no']").data(
						"success",
						function(resp){
							var html ="<option value> 직급 </option>";
							$.each(resp, function(idx, pos){
								html += optionPtrn.replace("%V", pos.POS_NO).replace("%T",
										pos.POS_NAME)
							});
							pos.html(html)
						});
					
// 					var  remove = $("select[name='remove']").data(
// 					 	"success",
// 					 	$("select[name='remove']").hide();
// 					)
					
					$(".dynamicElement").dynamicSelect();

					
			// 모달창 	
			var exampleModal = $("#exampleModal").modal({ // 모달창이 꺼질때 show가 사라지는거
				show : false
			}).on("hidden.bs.modal", function() {
				exampleModal.find(".modal-body").empty();
			});
		
			
			function loadAssetsView(){ // 검색버튼 눌렀을 떄 모달창 띄우는거 
				// 3번 ajax를 타고 jsp를 불러오는거 
					$.ajax({
						url : "<c:url value='/emp/retire/retireEmpModal'/>", // retireEmpModal 컨솔창으로 넘어가는거 
						dataType : "html",
						success : function(resp){ // retireEmpModal.jsp  (내용)가 담기는거 
							exampleModal.find(".modal-body").html(resp);
							exampleModal.modal("show");
						}
					}); 
			}
					$("#search").on("click", function() { // 1번 클릭하면
						loadAssetsView(); //  2번  위의 function을 불러오는거 
					}).css({
						cursor : "pointer"
					});
			
			// 모달창에서  행하나 클릭시 선택한 사원의 정보가 화면에 뿌져지도록
			function empInfoView(emp_no){
						$.ajax({
							url :"<c:url value='/emp/retire/retirementForm/'/>"+emp_no, // 페이지전환이 아니라 정보만 빼오는거 
							dataType :"json",
							success: function(resp){ // 컨트롤러에서 vo를 넘겨준 값 ㄴ
								console.log($(".emp1"));
								$(".emp1").eq(0).text(resp.depVO.dep_name); 
								$(".emp1").eq(1).text(resp.pos_no);
								$(".emp1").eq(2).text(resp.hire_date); 
								$(".emp1").eq(3).text(resp.emp_no);
								$("#emp_no").val(resp.emp_no);
								$(".emp1").eq(4).text(resp.emp_name);
								$(".emp1").eq(5).text(resp.name); 
								$("#exampleModal").modal("hide");// 행을 클릭하면 모달이 숨겨지는거	
								
							}
						});
					}
							
					$("#exampleModal").on("click","tr", function(){
						let empInfo = $(this).find("td").eq(3).text();
						empInfoView(empInfo);
					}).css({
						cursor : "pointer"
					});	
</script>