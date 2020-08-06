<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<h1>My Page</h1>
	<form method="post" id="insertForm">
		<table class="table table-bordered text-center">
			<tr class="row">
				<th class="col-3">사원아이디</th>
				<td class="col-9 form-inline">
				<%-- 	<input class="col-5 form-control mr-2" type="text" id="emp_no" name="emp_no" 
							value="${emp.emp_no}"> --%>
					<!-- <input type="button" id="idCheck" class="btn btn-success mr-2" value="아이디중복확인"/> -->
					<span class="error">${errors["emp_no"] }</span>
				</td>
			</tr>
			<tr  class="row">
			<th class="col-3">부서</th>
			<td class="col-3 form-inline">
			 
				<select class="dynamicElement form-control mr-2" name="dep_no2"
					data-url="<c:url value='getdepartmentList'/>">
					<option value>부서명</option>
				</select>
			 
			</td>
			<th class="col-3">소속팀</th>
			<td class="col-3 form-inline">
					 <select class="dynamicElement form-control mr-2" name="dep_no"
						data-url="<c:url value='getTeamList' />">
						<option value>소속 팀</option>
					</select>
			</td>
			</tr> 
			
			<tr class="row">
				<th class="col-3"> 성명</th>
				<td class="col-3 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_name" 
					value="${emp.emp_name }">
					<span class="error">${errors["emp_name"] }</span></td>
		
				<th class="col-3">영문이름</th>
				<td class="col-3 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_en_name" 
					value="${emp.emp_en_name }">
					<span class="error">${errors["emp_en_name"] }</span></td>
			</tr>


		   <tr class="row">
				<th class="col-3">입사일</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="date" name="hire_date" value="${emp.hire_date }" >
					<span class="error">${errors["hire_date"] }</span></td>
			</tr>
		
			<tr class="row">
				<th class="col-3">국적</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="" name="country" 
					value="${emp.country }">
					<span class="error">${errors["country"] }</span></td>
			</tr>
			
			<tr class="row">
				<th class="col-3">생일</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="date" name="emp_birthday"
					value="${emp.emp_birthday }">
					<span class="error">${errors["emp_birthday"] }</span></td>
			</tr>
			
			<tr class="row">
				<th class="col-3">성별</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="" name="emp_gen"
					value="${emp.emp_gen }">
					<span class="error">${errors["emp_gen"] }</span></td>
			</tr>
			
			
			
			<tr class="row">
				<th class="col-3">주민번호</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_regno" 
					value="${emp.emp_regno }">
					<span class="error">${errors["emp_regno"] }</span></td>
			</tr>
			
			
			<tr class="row">
				<th class="col-3">병역</th>
				<td class="col-9 form-inline">
				<select class="dynamicElement form-control mr-2" name="soldier">
				<option value="미필">미필</option>
				<option value="군필">군필</option>
				<option value="면제">면제</option>
				<option value="해당없음">해당없음</option>
				</select>
				</td>
			</tr>
			
			<tr class="row">
				<th class="col-3">구분</th>
				<td class="col-9 form-inline">
				<select class="dynamicElement form-control mr-2" name="fulltime">
				<option value="정규직">정규직</option>
				<option value="비정규직">비정규직</option>
				<option value="일용직">일용직</option>
				</select>
				</td>
			</tr>
			
			<tr class="row">
				<th class="col-3">이메일</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_email" 
					value="${emp.emp_email }">
					<span class="error">${errors["emp_email"] }</span>
				</td>
			</tr>
			
			<tr class="row">
				<th class="col-3">연락처</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_phone"
					value="${emp.emp_phone }">
					<span class="error">${errors["emp_phone"] }</span>
				</td>
			</tr>
		
			<tr class="row">
				<th class="col-3">우편번호</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_zip" 
					value="${emp.emp_zip }">
					<span class="error">${errors["emp_zip"] }</span>
				 <input type="button" id="emp_zip" class="btn btn-success mr-2" value="검색"/> 
				</td>
			</tr>
			<tr class="row">
				<th class="col-3">주소</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_addr" 
					value="${emp.emp_addr }">
					<span class="error">${errors["emp_addr"] }</span>
				</td>
			</tr>
			<tr class="row">
				<th class="col-3">상세주소</th>
				<td class="col-9 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="emp_addr2" 
					value="${emp.emp_addr2 }">
					<span class="error">${errors["emp_addr2"] }</span>
				</td>
			</tr>
			<tr class="row">
				<th class="col-2">학력</th>
				<td class="col-2 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="edu_name" 
					value="${emp.edu_name }">
					<span class="error">${errors["edu_name"] }</span>
				</td>
				
				<th class="col-2">전공</th>
				<td class="col-2 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="major" 
					value="${emp.major }">
					<span class="error">${errors["major"] }</span>
				</td>
				
				<th class="col-2">졸업여부</th>
				<td class="col-2 form-inline">
				<select class="dynamicElement form-control mr-2" name="fulltime">
					<option value="중퇴">중퇴</option>
					<option value="졸업예정">졸업예정</option>
					<option value="졸업">졸업 </option>
				</select>
				</td>
			</tr>
			
			<tr class="row">
				<th class="col-2">자격증</th>
				<td class="col-2 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="edu_name" 
					value="${emp.edu_name }">
					<span class="error">${errors["edu_name"] }</span>
				</td>
				
				<th class="col-2">발급기관명</th>
				<td class="col-2 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="major" 
					value="${emp.major }">
					<span class="error">${errors["major"] }</span>
				</td>
				
				<th class="col-2">취득일</th>
				<td class="col-2 form-inline">
				<input class="col-5 form-control mr-2" type="date" name="cert_date" 
					value="${emp_certvo.cert_date }">
					<span class="error">${errors["cert_date"] }</span>
				</td>
			</tr>
			
			
			<tr class="row">
				<th class="col-2">회사명</th>
				<td class="col-1 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="company" 
					value="${emp_career.company }">
					<span class="error">${errors["company"] }</span>
				</td>
			
				<th class="col-2">경력업무</th>
				<td class="col-1 form-inline">
				<input class="col-5 form-control mr-2" type="text" name="career_task" 
					value="${emp_career.career_task }">
					<span class="error">${errors["career_task"] }</span>
				</td>
				
				<th class="col-2">근속년수</th>
				<td class="col-1 form-inline">
				<input class="col-5 form-control mr-2" type="number" name="work_year" 
					value="${emp_career.work_year }">
					<span class="error">${errors["work_year"] }</span>
				</td>
				
				<th class="col-2">최종직급</th>
				<td class="col-1 form-inline">
				<select class="dynamicElement form-control mr-2" name="final_position">
					<option value="중퇴">사원</option>
					<option value="졸업예정">대리</option>
					<option value="졸업">과장</option>
					<option value="졸업">부장</option>
				</select>
				</td>
			</tr>
			
			
			<tr class="row">
				<td class="col text-right">
					<input class="btn btn-warning mr-2" type="reset" value="취소"> 
					<input class="btn btn-success mr-2" type="submit" value="저장">
					<input class="btn btn-secondary mr-2" type="submit" value="뒤로가기"
						onclick="history.back();"
					>
				</td>
			</tr>
		</table>
	</form>
<!-- 	<script type="text/javascript">
		var insertForm = $("#insertForm").on("submit", function(){
			let validated = $(this).data("idValidated");
			if(!validated){
				alert("아이디 중복 확인하세요.");
			}
			return validated;
		}).data("idValidated", false);
		var idInput = insertForm.find("#mem_id").on("change", function(){
			insertForm.data("idValidated", false);
			idInput.next("#msgSpan").remove();
		});
		$("#idCheck").on("click", function(){
			let inputId = idInput.val();
			if(!inputId) return;
			idInput.next("#msgSpan").remove();
			$.ajax({
				url : "${pageContext.request.contextPath }/member/idValidate.do",
				data : {
					inputId : inputId
				},
				method : "post",
				dataType : "json", // Accept:application/json, Content-Type:application/json
				success : function(resp) {
					let message = null;
					if(resp.result=="OK"){
						insertForm.data("idValidated", true);
						message = "아이디 사용 가능";
					}else{
						insertForm.data("idValidated", false);
						message = "아이디 중복";
					}
					idInput.after( $("<span>").prop('id', 'msgSpan').text(message) );
				},
				error : function(errorResp) {
					console.log(errorResp.status + ":" + errorResp.responseText);
				}
			});
		});
	</script> --> 
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/paiging.js?time=${System.currentTimeMillis()}"></script>
	
	<script type="text/javascript">
		// 옵션 선택시 
		var optionPtrn = "<option value='%V'>%T</option>";
		var departmentCode = $("select[name='dep_no2']").data( // 부서코드
				"success",
				function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
					var html = "";
					$.each(resp, function(idx, dep) {
						html += optionPtrn.replace("%V", dep.dep_no2)
								.replace("%T", dep.dep_name);
					});
					departmentCode.append(html);
				}).on("change", function() {  // 부서 선택 마다 소속팀이 바뀌는거 
			let dep_no2 = $(this).val();

			dep_no.trigger("renew", {
				dep_no2 : dep_no2
			});
		});

		var dep_no = $("select[name='dep_no']").data( // 소속 팀
				"success",
				function(resp) {
					var html = "<option value>소속팀</option>";
					$.each(resp, function(idx, buyer) {
						html += optionPtrn.replace("%V", dep.dep_no)
								.replace("%T", dep.dep_name);
					});
					dep_no.html(html);
				});

		$(".dynamicElement").dynamicSelect();
	</script>
