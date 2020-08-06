<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 20        이제경      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form modelAttribute="buyer"  action="${cPath }${currentAction }" method="post">
	<c:if test="${not empty buyer.buyer_no}">
		<input type="hidden" name="_method" value="put" />
		<h2>거래처 수정</h2>
	</c:if>
	<c:if test="${empty buyer.buyer_no }">
		<h2>거래처 등록</h2>
	</c:if>
	
	<input class="form-control" type="hidden" name="currentPage" value="${param.currentPage }"/>
	<input type="hidden" name="buyer_no" value="${buyer.buyer_no }"/>
	<table class="table table-bordered">
		<tr>
			<th>거래처명</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_name" required value="${buyer.buyer_name }" />
				</div>
				<form:errors path="buyer_name" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
		<th>업종</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_sector" required value="${buyer.buyer_sector }" />
				</div>
				<form:errors path="buyer_sector" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>대표자명</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_rep" required value="${buyer.buyer_rep }" />
				</div>
				<form:errors path="buyer_rep" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>회사 대표번호</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_tel" value="${buyer.buyer_tel }" placeholder="('-'을 포함하여 작성)" />
				</div>
				<form:errors path="buyer_tel" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>은행명</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_bank" required value="${buyer.buyer_bank }" />
				</div>
				<form:errors path="buyer_bank" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>계좌번호</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_bankno" required value="${buyer.buyer_bankno }" />
				</div>
				<form:errors path="buyer_bankno" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>예금주명</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="buyer_bankname" required value="${buyer.buyer_bankname }" />
				</div>
				<form:errors path="buyer_bankname" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<div class="input-group mb-3">
					<input type="text" name="buyer_zip" value="${buyer.buyer_zip }" id="sample4_postcode" placeholder="우편번호" readonly/>
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" readonly/><br>
					<input type="text" name="buyer_addr" value="${buyer.buyer_addr }" id="sample4_roadAddress" placeholder="도로명주소" readonly />
					<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소" readonly/>
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="buyer_addr2" value="${buyer.buyer_addr2 }" id="sample4_detailAddress" placeholder="상세주소"/>
					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목" readonly/>
				</div>
			</td>
		</tr>
		<tr>
			<th>담당자명</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="charger_name" required value="${buyer.charger_name }" />
				</div>
				<form:errors path="charger_name" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>담당자 이메일</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="charger_email" required value="${buyer.charger_email }" />
				</div>
				<form:errors path="charger_email" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>담당자 연락처</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="charger_phone" required value="${buyer.charger_phone }" placeholder="('-'을 포함하여 작성)"/>
				</div>
				<form:errors path="charger_phone" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>비고</th>
			<td><div class="input-group mb-3">
					<input class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" type="text"
						name="etc" required value="${buyer.etc }" />
				</div>
				<form:errors path="etc" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th>거래여부</th>
			<td>
				<select name="use_status">
					<c:if test="${not empty ruleList }">
						<c:forEach items="${ruleList }" var="rule">
							<option value="${rule.code }">${rule.name}</option>
						</c:forEach>
					</c:if>
				</select>
			</td>
		</tr>
	</table>
	<div id="divBtn">
		<input type="submit" class="btn btn-primary" value="저장">
	</div>
</form:form>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("sample4_roadAddress").value = roadAddr;
	            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	            
	            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	            if(roadAddr !== ''){
	                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	            } else {
	                document.getElementById("sample4_extraAddress").value = '';
	            }
	
	            var guideTextBox = document.getElementById("guide");
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if(data.autoRoadAddress) {
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                guideTextBox.style.display = 'block';
	
	            } else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                guideTextBox.style.display = 'block';
	            } else {
	                guideTextBox.innerHTML = '';
	                guideTextBox.style.display = 'none';
	            }
	        }
	    }).open();
	}
</script>