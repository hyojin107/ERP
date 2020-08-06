<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사원등록</h5>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" id="confirm_btn">확인</button>
			</div>
		</div>
	</div>
</div>


<form:form modelAttribute="emp" action="${cPath}/emp/manage/empInput" method="post" enctype="multipart/form-data"  style="padding : 5px">
	<table class="table table-bordered text-center">
		<thead>
			<tr>
				<td rowspan="5" colspan="2" style="padding:auto;">
					<table >
					<tr>
						<td>
							<img id="img" style="width: 150px; max-heigth: 100px;"/>
						</td>
					</tr>
					</table>
					<input type="file" name="emp_img" accept="image/*" id="input_img">
				</td>
				<th colspan="2">사원아이디</th>
				<td colspan="5">자동생성됩니다.</td>

			</tr>
			<tr>
				<th colspan="2">비밀번호</th>
				<td colspan="5"><input class="col-5 form-control mr-2"
					type="text" id="emp_pass" name="emp_pass" value="${emp.emp_pass}">
					<span class="error">${errors["emp_no"] }</span></td>
			</tr>
			<tr>
				<th colspan="2">이름</th>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text"
					name="emp_name" value="${emp.emp_name}"></td>
				
				<th colspan="2">영문이름</th>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text"
					name="emp_en_name" value="${emp.emp_en_name }"></td>
			</tr>
			<tr>	
				<th colspan="2">생일</th>
				<td colspan="5"><input class="col-5 form-control mr-2"
					type="date" name="emp_birthday" value="${emp.emp_birthday }">
				</td>
			</tr>
			<tr>
				<td colspan="2">주민번호</td>
				<td colspan="5">
				<input style="text-align" class="col-5 form-control mr-2" type="text" name="emp_regno" value="${emp.emp_regno }">  
					<span class="error">${errors["emp_regno"] }</span>
				</td>
			</tr>
			
		</thead>
		<tbody>
			<tr>
				<th>부서</th>
				<td><select class="dynamicElement form-control mr-2 "
					name="dep_no2" data-url="<c:url value='departmentList'  />">
						<option value="">부서명</option>
				</select></td>
				<th>소속</th>
				<td><select class="dynamicElement form-control mr-2"
					name="dep_no" data-url="<c:url value='TeamList'/>">
						<option value="">소속 팀</option>
				</select></td>
				<th>직급</th>
				<td><select class="dynamicElement form-control mr-2"
					name="pos_no">
						<c:forEach items="${posList}" var="posList">
							<option value="${posList.POS_NO}">${posList.POS_NAME}</option>
						</c:forEach>
				</select></td>
				<td>입사일</td>
				<td colspan="2"><input class="col-12 form-control mr-2" type="date" name="hire_date" value="${emp.hire_date }"> 
				<span class="error">${errors["hire_date"] }</span>
				</td>
			</tr>
			<tr>
				<td>성별</td>
				<td><input class="" type="radio" name="emp_gen" value="남성"
					${'남성' eq emp.emp_gen?"checked" :""} /> 남성<input class=""
					type="radio" name="emp_gen" value="여성"
					${'여성' eq emp.emp_gen?"checked" :""} /> 여성<span class="error">${errors["emp_gen"] }</span>
				</td>
				<td>국적</td>
				<td><input class="" type="radio" name="country" value="내국인"
					${'내국인' eq emp.country?"checked" :""} /> 내국인 <input class=""
					type="radio" name="country" value="외국인"
					${'외국인' eq emp.country?"checked" :""} /> 외국인 <span class="error">${errors["country"] }</span>
				</td>

				<td>병역</td>
				<td><select class="dynamicElement form-control mr-2"
					name="soldier" value="${emp.soldier}">
						<c:forEach items="${solList}" var="solList">
							<option value="${solList.CODE}">${solList.NAME}</option>
						</c:forEach>
				</select></td>
				<td>구분</td>
				<td colspan="2"><select
					class="dynamicElement form-control mr-2" name="fulltime">
						<c:forEach items="${fullList}" var="fullList">
							<option value="${fullList.CODE }">${fullList.NAME}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>은행명</td>
				<td colspan="2"><select
					class="dynamicElement form-control mr-2" name="bank"
					value="${emp.bank}">
						<option value="신한">신한</option>
						<option value="국민">국민</option>
						<option value="농협">농협</option>
						<option value="우리">우리</option>
						<option value="기업">기업</option>
						<option value="새마을금고">새마을금고</option>
				</select></td>
				<td>예금주</td>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text" /></td>
				<td>계좌번호</td>
				<td colspan="2"><input class="col-12 form-control mr-2" type="text" name="emp_bankno"
					value="${emp.emp_bankno }" /></td>
			</tr>
			<tr>
				

				<td>이메일</td>
				<td colspan="2"><input class="col-12 form-control mr-2"
					type="text" name="emp_email" value="${emp.emp_email }"> <span
					class="error">${errors["emp_email"] }</span></td>

				<td>연락처</td>
				<td colspan="2"><input class="col-12 form-control mr-2"
					type="text" name="emp_phone" value="${emp.emp_phone }"> <span
					class="error">${errors["emp_phone"] }</span></td>
			</tr>
			<tr>
				<td colspan="4"><input class="form-control"
					style="width: 50%; display: inline;" placeholder="우편번호"
					name="emp_zip" id="addr1" type="text" readonly="readonly">
					<button type="button" class="btn btn-default"
						onclick="execPostCode();">  
						<i class="fa fa-search"></i> 우편번호 찾기
					</button></td>
				<td colspan="3"><input class="form-control" style="top: 5px;"
					placeholder="도로명 주소" name="emp_addr" id="addr2" type="text"
					readonly="readonly" /></td>
				<td colspan="3"><input class="form-control" placeholder="상세주소"
					name="emp_addr2" id="addr3" type="text" /></td>
			</tr>
		<tbody id="trsch">
			<tr id="schoolName">

				<td>학교명</td>
				<td colspan="2"><input class="col-12 form-control mr-2"
					type="text" name="eduVOList[0].edu_name" value="${emp.edu_name }">
					<span class="error">${errors["edu_name"] }</span></td>
				<td>전공</td>
				<td><input class="col-12 form-control mr-2" type="text"
					name="eduVOList[0].major" value="${edu.major }"> <span
					class="error">${errors["major"] }</span></td>
				<td>졸업여부</td>
				<td colspan="2"><select
					class="dynamicElement form-control mr-2"
					name="eduVOList[0].graduate">
						<option value="중퇴">중퇴</option>
						<option value="졸업예정">졸업예정</option>
						<option value="졸업">졸업</option>
				</select></td>
				<td><input class="btn btn-success mr-2" type="button" value="+"
					id="eduPlu" onclick="schaddRow()"> <input
					class="btn btn-success mr-2" type="button" value="-" id="eduMic"
					onclick="schdelRow()"></td>
			</tr>
		</tbody>


		<tbody id="trlic">
			<tr id="licence">
				<td>자격증구분</td>
				<td><input class="col-12 form-control mr-2" type="text"
					name="empCertVOList[0].cert_sector"
					value="${emp_certvo.cert_sector }"> <span class="error">${errors["cert_sector"] }</span>
				</td>
				<td>자격증명</td>
				<td><input class="col-12 form-control mr-2"  type="text"
					name="empCertVOList[0].cert_text" value="${emp_certvo.cert_text }">
					<span class="error">${errors["cert_text"] }</span></td>
				<td>발급기관명</td>
				<td><input class="col-12 form-control mr-2"  type="text"
					name="empCertVOList[0].issue_agency" value="${cert.issue_agency}">
					<span class="error">${errors["issue_agency"] }</span></td>
				<td>취득일</td>
				<td><input class="col-12 form-control mr-2" type="date"
					name="empCertVOList[0].cert_date"> <span class="error">${errors["cert_date"] }</span>
				</td>
				<td><input class="btn btn-success mr-2" type="button" value="+"
					id="licPlu" onclick="licaddRow()" /> <input
					class="btn btn-success mr-2" type="button" value="-" id="licMic"
					onclick="licdelRow()"></td>
			</tr>
		</tbody>
		<tbody id="trcom">
			<tr id="company">

				<td>회사명</td>
				<td><input class="col-12 form-control mr-2" type="text"
					name="careerVOList[0].company" value="${emp_career.company }">
					<span class="error">${errors["company"] }</span></td>
				<td>경력업무</td>
				<td><input class="col-12 form-control mr-2" type="text"
					name="careerVOList[0].career_task"
					value="${emp_career.career_task }"> <span class="error">${errors["career_task"] }</span>
				</td>
				<td>근속년수</td>
				<td><select class="dynamicElement form-control mr-2"
					name="careerVOList[0].work_year">
						<option value="1년 이하">1년 이하</option>
						<option value="1년~2년">1년~2년</option>
						<option value="2년~5년 ">2년~5년</option>
						<option value="5년이상">5년이상</option>
				</select> <span class="error">${errors["work_year"] }</span></td>
				<td>최종직급</td>
				<td><select class="dynamicElement form-control mr-2"
					name="careerVOList[0].final_position">
						<c:forEach items="${posList}" var="posList">
							<option value="${posList.POS_NO}">${posList.POS_NAME}</option>
						</c:forEach>
				</select></td>
				<td><input class="btn btn-success mr-2" type="button" value="+"
					id="posPlu" onclick="comaddRow()"> <input
					class="btn btn-success mr-2" type="button" value="-" id="posMic"
					onclick="comdelRow()"></td>
			</tr>
		</tbody>

	</table>
	<div>
		<div class="text-right">
			<input class="btn btn-warning mr-2" type="reset" value="다시작성"> 
			<input class="btn btn-success mr-2" type="submit" value="저장"> 
			<input class="btn btn-secondary mr-2" type="submit" value="뒤로가기" onclick="history.back();">
		</div>
	</div>
</form:form>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>

<script type="text/javascript">

$("#input_img").on("change", handleImgFileSelect); // 사진입력을 검색했을때
	
	var sel_file;  
	function handleImgFileSelect(e){
		var files = e.target.files; // 파일을 누른거 
		var filesArr = Array.prototype.slice.call(files); // 파일 형태를 메타데이터에서 파일로? 변형시키는거 
		
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){ // 이미지 파일이 아니면 
// 				alert("확장자는 이미지 확장자만 가능합니다.");
				return;  // 리턴 
			}
			
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img").attr("src", e.target.result);
				
			}
			reader.readAsDataURL(f);
		});

	}
<%-- 	<%=request.getRealPath("/")%>  // 현재 프로젝트의 실제경로를 표시  --%>

	// 모달창 확인 버튼 이벤트 걸기
	$("#confirm_btn").click(function() {
		$("#exampleModal").modal('hide')
		window.location.href = "${cPath}/emp/manage/empinformation";
	});

	var lic_num = 1;
	// 자격증 추가 행 
	function licaddRow() {
		let lic = $("#licence").clone();
		lic.find("input").eq(0).attr("name",
				"empCertVOList[" + lic_num + "].cert_sector");
		lic.find("input").eq(1).attr("name",
				"empCertVOList[" + lic_num + "].cert_text");
		lic.find("input").eq(2).attr("name",
				"empCertVOList[" + lic_num + "].issue_agency");
		lic.find("input").eq(3).attr("name",
				"empCertVOList[" + lic_num + "].cert_date");

		lic.find("input").val("");
		lic.find("td:last").remove();
		$("#trlic").append(lic);
		lic_num++;
	}
	function licdelRow() {
		// jquery 로 테이블 삭제 
		if ($("#trlic tr").length < 2) {
			return;
		}
		$("#trlic tr:last").remove();

	}

	var sch_Num = 1;
	// 학력 추가 행 
	function schaddRow() {
		let sch = $("#schoolName").clone();
		sch.find("input").eq(0).attr("name",
				"eduVOList[" + sch_Num + "].edu_name");
		sch.find("input").eq(1)
				.attr("name", "eduVOList[" + sch_Num + "].major");
		sch.find("input").eq(2).attr("name",
				"eduVOList[" + sch_Num + "].graduate");

		sch.find("input").val("");
		sch.find("td:last").remove();
		$("#trsch").append(sch);
		sch_Num++;
	};

	function schdelRow() {
		// jquery 로 테이블 삭제 
		if ($("#trsch tr").length < 2) {
			return;
		}
		$("#trsch tr:last").remove();

	}

	var car_Num = 1;
	// 경력사항  추가 행 
	function comaddRow() {
		let career = $("#company").clone();
		career.find("input").eq(0)
				.attr("name", "list[" + car_Num + "].company");
		career.find("input").eq(1).attr("name",
				"list[" + car_Num + "].career_task");
		career.find("input").eq(2).attr("name",
				"list[" + car_Num + "].work_year");
		career.find("input").eq(3).attr("name",
				"list[" + car_Num + "].final_position");

		career.find("input").val("");
		career.find("td:last").remove();

		$("#trcom").append(career)
		car_Num++;
	}

	function comdelRow() {
		// jquery 로 테이블 삭제 
		if ($("#trcom tr").length < 2) {
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
					html += optionPtrn.replace("%V", dep.dep_no).replace("%T",
							dep.dep_name)
					/* +"<input type='hidden' name='depVO.dep_name' value='"+dep.dep_name+"'/>"; */
				});
				dep_no2.html(html)
			});

	$(".dynamicElement").dynamicSelect();

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
	

</script>