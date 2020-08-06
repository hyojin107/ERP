<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>




<form:form modelAttribute="emp" action="${cPath}/emp/manage/empList" method="post" enctype="multipart/form-data"  id="inputForm" style="padding : 5px">
	<table class="table table-bordered text-center">
		<thead>
			<tr>
				<td rowspan="5" colspan="2" style="padding:auto;">
					<table >
					<tr>
						<td><!-- 이미지파일 불러오는거  -->
							<img id="emp_img" style="width: 150px; max-heigth: 100px;" alt="" src="${cPath }/resources/empImg/${emp.emp_no}">
						</td>
					</tr>
					</table>
					<input class="form-control" type="file" name="input_img" accept="image/*" id="input_img"  disabled="disabled">
					
				</td>
				<th colspan="2">사원아이디</th>
				<td colspan="5" id="emp_no">${emp.emp_no}</td>

			</tr>
			<tr>
				<th colspan="2">비밀번호</th>
				<td colspan="5"><input class="col-8 form-control mr-2" type="text" value="${emp.emp_pass}" readonly/></td>
			</tr>
			<tr>
				<th colspan="2">이름</th>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text"
					name="emp_name" value="${emp.emp_name}" readonly ></td>
				
				<th colspan="2">영문이름</th>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text"
					name="emp_en_name" value="${emp.emp_en_name }"  readonly></td>
			</tr>
			<tr>	
				<th colspan="2">생일</th>
				<td colspan="5"><input class="col-5 form-control mr-2"
					type="date" name="emp_birthday" value="${emp.emp_birthday}"  readonly>
				</td>
			</tr>
			<tr>
				<th colspan="2">주민번호</th>
				<td colspan="5">
				<input style="text-align" class="col-5 form-control mr-2" type="text" name="emp_regno" value="${emp.emp_regno }" readonly>  
					<span class="error">${errors["emp_regno"] }</span>
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>부서</th>
				<td><select class="dynamicElement form-control mr-2 "
					name="dep_no2"   disabled data-url="<c:url value='departmentList'  />">
						<option >${emp.depVO.dep_no2} </option>
					</select>
				</td>
				<th>소속</th>
				<td><select class="dynamicElement form-control mr-2"
					name="dep_no"  disabled data-url="<c:url value='TeamList'/>">
						<option value="${emp.depVO.dep_no}">${emp.depVO.dep_name}</option>
				</select></td>
				<th>직급</th>
				<td><select class="dynamicElement form-control mr-2" 
					name="pos_no"  disabled>
						<c:forEach items="${posList}" var="posList" > 
							<option value="${posList.POS_NO}" ${emp.pos_no eq posList.POS_NAME ? "selected" : ""}> ${posList.POS_NAME}</option>
						</c:forEach>
				</select></td>
				<th>입사일</th>
				<td colspan="2"><input class="col-12 form-control mr-2" type="date" name="hire_date" value="${emp.hire_date }" disabled> 
				<span class="error">${errors["hire_date"] }</span>
				</td>
			</tr>

			<tr>
				<th>성별</th>
				<td><input class="" type="radio" name="emp_gen"value="남성" disabled="disabled"
					${'남성' eq emp.emp_gen?"checked" :""} /> 남성<input class=""
					type="radio" name="emp_gen" value="여성"  disabled="disabled"
					${'여성' eq emp.emp_gen?"checked" :""} /> 여성<span class="error">${errors["emp_gen"] }</span>
				</td>
				<th>국적</th>
				<td><input class=""   type="radio" name="country" value="내국인" disabled="disabled"
					${'내국인' eq emp.country?"checked" :""} /> 내국인
					
					 <input class="" type="radio" name="country" value="외국인" disabled="disabled"
					${'외국인' eq emp.country?"checked" :""} /> 외국인 <span class="error">${errors["country"] }</span>
				</td>

				<th>병역</th>
				<td><select class="dynamicElement form-control mr-2"
					name="soldier" disabled>
						<c:forEach items="${solList}" var="solList">
							<option value="${solList.CODE}" ${emp.soldier eq solList.NAME ? "selected" : "" }>${solList.NAME}</option>
						</c:forEach>
				</select></td>

				<th>구분</th>
				<td colspan="2"><select
					class="dynamicElement form-control mr-2" name="fulltime" disabled >
						<c:forEach items="${fullList}" var="fullList">
							<option value="${fullList.CODE }" ${emp.fulltime eq fullList.CODE ? "selected" : ""}>${fullList.NAME}</option>
						</c:forEach>
				</select></td>

			</tr>

			<tr>
				<th>은행명</th>
				<td colspan="2"><select class="dynamicElement form-control mr-2" name="bank" disabled>
						<option value="신한" ${emp.bank eq "신한" ? "selected" : ""}>신한</option>
						<option value="국민" ${emp.bank eq "국민" ? "selected" : ""}>국민</option>
						<option value="농협" ${emp.bank eq "농협" ? "selected" : ""}>농협</option>
						<option value="우리" ${emp.bank eq "우리" ? "selected" : ""}>우리</option>
						<option value="기업" ${emp.bank eq "기업" ? "selected" : ""}>기업</option>
						<option value="새마을금고" ${emp.bank eq "새마을금고" ? "selected" : ""}>새마을금고</option>
				</select></td>
				<th>예금주</th>
				<td colspan="2"><input class="col-12 form-control mr-2"  value="${emp.emp_name}" type="text" readonly /></td>
				<th>계좌번호</th>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text" name="emp_bankno"
					value="${emp.emp_bankno }"  readonly /></td>
			</tr>
			<tr>
				

				<th>이메일</th>
				<td colspan="2"><input class="col-12 form-control mr-2"
					type="text" name="emp_email"  readonly value="${emp.emp_email }"> <span
					class="error">${errors["emp_email"] }</span></td>

				<th>연락처</th>
				<td colspan="2"><input class="col-12 form-control mr-2"
					type="text" name="emp_phone" readonly  value="${emp.emp_phone }"> <span
					class="error">${errors["emp_phone"] }</span></td>
			</tr>
			<tr>
				<td colspan="4"><input class="form-control"
					style="width: 50%; display: inline;" placeholder="우편번호" value="${emp.emp_zip}"
					name="emp_zip" id="addr1" type="text" readonly="readonly">
					<button type="button" class="btn btn-default"  disabled="disabled"  name="seach"
						onclick="execPostCode();">  
						<i class="fa fa-search"  ></i> 우편번호 찾기
					</button></td>
				<td colspan="3"><input class="form-control" style="top: 5px;" value="${emp.emp_addr}"
					placeholder="도로명 주소" name="emp_addr" id="addr2" type="text"
					readonly="readonly" /></td>
				<td colspan="3"><input class="form-control" placeholder="상세주소"  value="${emp.emp_addr2}"
					readonly="readonly"  name="emp_addr2" id="addr3" type="text" /></td>
			</tr>
		<tbody id="trsch">
		 <c:forEach var="eduVOList" items="${emp.eduVOList}">
			<tr id="schoolName">
				<th>학교명</th>
				<td colspan="2"><input class="col-12 form-control mr-2"  readonly
					type="text" name="eduVOList[0].edu_name" value="${eduVOList.edu_name }">
					<span class="error">${errors["edu_name"] }</span></td>
				<th>전공</th>
				<td><input class="col-12 form-control mr-2" type="text"  readonly
					name="eduVOList[0].major" value="${eduVOList.major}"> <span
					class="error">${errors["major"] }</span></td>
				<th>졸업여부</th>
				<td colspan="2">
				<select class="dynamicElement form-control mr-2" disabled="disabled"  name="eduVOList[0].graduate">
						<option value="중퇴" ${eduVOList.graduate eq "중퇴" ? "seleceted" : ""}>중퇴</option>
						<option value="졸업예정" ${eduVOList.graduate eq "졸업예정" ? "selected" :""}>졸업예정</option>
						<option value="졸업" ${eduVOList.graduate eq "졸업" ? "selected" : ""}>졸업</option>
				</select></td>
				<td><input class="btn btn-success  mr-2" type="button" name="btn" value="+" disabled="disabled"
					id="eduPlu" onclick="schaddRow()"> <input
					class="btn btn-success  mr-2" type="button" name="btn" value="-" id="eduMic" disabled="disabled"
					onclick="schdelRow()"></td>
			</tr>
		 </c:forEach>
		</tbody>


		<tbody id="trlic">
		 <c:forEach items="${emp.empCertVOList}" var="empCertVOList">
			<tr id="licence">
				<th>자격증구분</th>
				<td><input class="col-12 form-control mr-2" type="text"  readonly
					name="empCertVOList[0].cert_sector"
					value="${empCertVOList.cert_sector }"> <span class="error">${errors["cert_sector"] }</span>
				</td>
				<th>자격증명</th>
				<td><input class="col-12 form-control mr-2"  type="text" readonly
					name="empCertVOList[0].cert_text" value="${empCertVOList.cert_text }">
					<span class="error">${errors["cert_text"] }</span></td>
				<th>발급기관명</th>
				<td><input class="col-12 form-control mr-2"  type="text"  readonly
					name="empCertVOList[0].issue_agency" value="${empCertVOList.issue_agency}">
					<span class="error">${errors["issue_agency"] }</span></td>
				<th>취득일</th>
				<td><input class="col-12 form-control mr-2" type="date"  readonly value="${empCertVOList.cert_date}"
					name="empCertVOList[0].cert_date"> <span class="error">${errors["cert_date"] }</span>
				</td>
				<td><input class="btn btn-success  mr-2" disabled="disabled" name="btn" type="button" value="+"
					id="licPlu" onclick="licaddRow()" /> <input
					class="btn btn-success  mr-2"  disabled="disabled" name="btn" type="button" value="-" id="licMic"
					onclick="licdelRow()"></td>
			</tr>
		 </c:forEach>
		</tbody>
		<tbody id="trcom">
		 <c:forEach items="${emp.careerVOList}" var="careerVOList">
			<tr id="company">
				<th>회사명</th>
				<td><input class="col-12 form-control mr-2" type="text"  readonly
					name="careerVOList[0].company" value="${careerVOList.company}">
					<span class="error">${errors["company"] }</span></td>
				<th>경력업무</th>
				<td><input class="col-12 form-control mr-2" type="text"  readonly
					name="careerVOList[0].career_task"
					value="${careerVOList.career_task}"> <span class="error">${errors["career_task"] }</span>
				</td>
				<th>근속년수</th>
				<td><select class="dynamicElement form-control mr-2"  disabled
					name="careerVOList[0].work_year">
						<option value="1년 이하" ${careerVOList.work_year eq "1년 이하" ? "selected" : ""}>1년 이하</option>
						<option value="1년~2년" ${careerVOList.work_year eq "1년~2년" ? "selected" : ""}>1년~2년</option>
						<option value="2년~5년 " ${careerVOList.work_year eq "2년~5년" ? "selected" : ""}>2년~5년</option>
						<option value="5년이상" ${careerVOList.work_year eq "5년이상" ? "selected" : ""}>5년이상</option>
				</select> <span class="error">${errors["work_year"] }</span></td>
				<th>최종직급</th>
				<td><select class="dynamicElement form-control mr-2"  disabled
					name="careerVOList[0].final_position">
						<c:forEach items="${posList}" var="posList">
							<option value="${posList.POS_NO}" ${posList.POS_NO eq careerVOList.final_position ? "selected" : ""}>${posList.POS_NAME}</option>
						</c:forEach>
				</select></td>
				<td><input class="btn btn-success  mr-2" type="button" name="btn" value="+" disabled="disabled"
					id="posPlu" onclick="comaddRow()"> <input
					class="btn btn-success  mr-2" type="button" name="btn" value="-" id="posMic"  disabled="disabled"
					onclick="comdelRow()"></td>
			</tr>
		 </c:forEach>
		</tbody>
	</table>
</form:form>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>

<script type="text/javascript">


	
//모달창 확인 버튼 이벤트 걸기
$("#confirm_btn").click(function(){
	$("#exampleModal").modal('hide')
	window.location.href = "${cPath}/emp/manage/empinformation";
	
	})

	
var lic_num = 1;
// 자격증 추가 행 
function licaddRow() {
	let lic=$("#licence").clone();   // 자격증  한 행을 복사해서 lic 에 넣는다. 
	
	lic.find("input").eq(0).attr("name","empCertVOList["+lic_num+"].cert_sector");
	lic.find("input").eq(1).attr("name","empCertVOList["+lic_num+"].cert_text");
	lic.find("input").eq(2).attr("name","empCertVOList["+lic_num+"].issue_agency");
	lic.find("input").eq(3).attr("name","empCertVOList["+lic_num+"].cert_date");
	lic.find("input").val("");
	lic.find("td:last").remove();
	$("#trlic").append(lic);
	lic_num++;
}
function licdelRow() {
	// jquery 로 테이블 삭제 
	if ($("#trlic tr").length < 2) { // 한 행이 한줄이면  return  지우는걸 마지막 한줄에서 막음
		 $("#trlic").find("input[type='text']").val('');
		 $("#trlic").find("input[type='date']").val('');
		return;
	}
	$("#trlic tr:last").remove(); // '-' 버튼을 클릭하면  마지막 tr를 삭제해주는거 
    
}

var sch_Num = 1;
// 학력 추가 행 
function schaddRow() {
	let sch = $("#schoolName").clone();
	sch.find("input").eq(0).attr("name","eduVOList["+sch_Num +"].edu_name");
	sch.find("input").eq(1).attr("name","eduVOList["+sch_Num +"].major");
	sch.find("input").eq(2).attr("name","eduVOList["+sch_Num +"].graduate");

	sch.find("input").val("");
	sch.find("td:last").remove();
	$("#trsch").append(sch);
	sch_Num++;					
};
					
function schdelRow() {
	// jquery 로 테이블 삭제 
	if ($("#trsch tr").length < 2) {
		$("#trsch").find("input[type='text']").val('');
		return;
	}
	$("#trsch tr:last").remove();

}

var car_Num = 1;
// 경력사항  추가 행 
function comaddRow() {
	let career = $("#company").clone();
	career.find("input").eq(0).attr("name","careerVOList["+car_Num +"].company");
	career.find("input").eq(1).attr("name","careerVOList["+car_Num +"].career_task");
	career.find("input").eq(2).attr("name","careerVOList["+car_Num +"].work_year");
	career.find("input").eq(3).attr("name","careerVOList["+car_Num +"].final_position");
	
	career.find("input").val("");
	career.find("td:last").remove();
	
	$("#trcom").append(career)
	car_Num++;
}

function comdelRow() {
	// jquery 로 테이블 삭제 
	if ($("#trcom tr").length < 2) {
		$("#trcom").find("input[type='text']").val('');
		return;
	}
	$("#trcom tr:last").remove();

}

// 옵션 선택시 
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
				html += optionPtrn.replace("%V", dep.dep_no).replace("%T", dep.dep_name)
			/* +"<input type='hidden' name='depVO.dep_name' value='"+dep.dep_name+"'/>"; */
			});
			dep_no2.html(html)
		});



// 주소검색 
function execPostCode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== '' && data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', '
						+ data.buildingName : data.buildingName);
			}
			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if (extraRoadAddr !== '') {
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if (fullRoadAddr !== '') {
				fullRoadAddr += extraRoadAddr;
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			console.log(data.zonecode);
			console.log(fullRoadAddr);

			$("[name=emp_zip]").val(data.zonecode);
			$("[name=emp_addr]").val(fullRoadAddr);

			/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
			document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
			document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
		}
	}).open();
}

var exampleModal = $("#exampleModal").modal({
	show : false
}).on("hidden.bs.modal", function() {
	sampleModal.find(".modal-body").empty();
	sampleModal.data("mat_no", "");
});

$("#input_img").on("change", handleImgFileSelect); // id가  input_imgd인 파일이 onchange이벤트를 걸어서 스크립트를 불러온다.
var inputForm = $("#inputForm"); // 저장 form의 id
var sel_file;
function handleImgFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			return;
			}

		sel_file = f;
		var reader = new FileReader();
		reader.onload = function(e){ // onload를 통해 reader를 불러올떄 img src를 url롤 지정해주는 방식 
			$("#emp_img").attr("src",e.target.result);
			}
		reader.readAsDataURL(f);

		
		})
}

</script>