<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  

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
<h1>퇴직금정산</h1>  
사원정보 <input type="button" value="검색" id="search"/>
<div>
<table class="table table-bordered  text-left">
	<thead class="table-primary">
		<tr >
			<td> 소속 </td>
			<td class="emp1">${emp.dep_no}</td>	
			<td>직급 </td>
			<td class="emp1"> ${emp.pos_no} </td>	
			<td>입사일 </td> 
			<td class="emp1">${emp.hire_date}</td>
		</tr>
		<tr>
			<td>사원ID </td>
			<td class="emp1"> ${emp.emp_no}</td>
			<td>성명 </td>
			<td class="emp1">${emp.emp_name}</td>
			<td>구분</td>
			<td class="emp1">${emp.name }</td>
		</tr>
		<tr>
			<td>은행명 </td>
			<td class="emp1"> ${emp.bank}</td>
			<td>계좌번호 </td>
			<td class="emp1">${emp.emp_bankno}</td>
			<td>예금주</td>
			<td class="emp1">${emp.emp_name}</td>
		</tr>
	</thead>
</table>	
</div> 
<div>
<table class="table table-bordered  text-left">
	<thead class="table-primary">
		<tr >
			<td>퇴직일</td>
			<td><input type="date" name="retire_day"></td>	
			<td>재직일수</td>
			<td>입사일-퇴직일</td>	
			<td>퇴직금 지급일</td>
			<td><input type="date" name="paymen_day"></td>	
		</tr>
		<tr>	
			<td class="col-3">정산구분</td>
			<td>
			<select class="dynamicElement form-control mr-2" name="retire_reason" value="${emp.retire_reason}"> 
														<!-- name ==>vo에 있는거 컨트롤러에 vo 값으로 들어갈수 잇도록  -->
				<option value="">정산구분</option>
				<c:forEach items="${retireList}" var="retire">
					<option value="${retire.code}">${retire.name}</option>
				</c:forEach>					
			</select>
			</td>
			<td>퇴직사유</td>
			<td><input type="text" name="retire_reason"></td>
		</tr>	
	</thead>
</table>	
 </div> 
  <h3>퇴직전  3개월 임금 총액 계산 내역</h3>
 <div>
<table class="table table-bordered  text-left">	
	<!-- <tbody id="listBody2"> -->
		<tr>
			<th>퇴직금근속기간</th>
			<th>일수</th>
			<th>급여 </th>
			
			
		</tr>
		<tr>
			<td><input type="date">  ~ <input type="date">  </td>
			<td>${date}</td>
			<td>${emp.my_basicsalary }원</td>
			
			
		</tr>
		<tr>
			<td><input type="date">  ~ <input type="date">  </td>
			<td>${date}</td>
			<td>${emp.my_basicsalary }원</td>
			
			
		</tr>
		<tr>
			<td><input type="date">  ~ <input type="date">  </td>
			<td>${date}</td>
			<td>${emp.my_basicsalary }원</td>
		
			
		</tr>
		<tr>
			<td><input type="date">  ~ <input type="date">  </td>
			<td>${date}</td>
			<td>${emp.my_basicsalary }원</td>
		</tr>
		<tr>
			<td>계</td>
			<td>총근무일수</td>
			<td>${emp.my_basicsalary*3}원 </td>
						
		</tr>
</table>		
		<h3>퇴직금 계산</h3>
<table class="table table-bordered  text-left">
		<tr>
			<td>일평균 임금</td>
			<td>총근무일수</td>
			<td>퇴직금 </td>
			<td>원</td>
			
		</tr>
		<tr>
			<td>퇴직소득세</td>
			<td>연수에 따라 세금 달라짐 계산해야함</td>
			<td>차인지급액</td>
			<td>퇴직금-퇴직소득세</td>
			
		</tr>
		
	<!-- </tbody> -->
	
</table>
</div>
<tr class="row">
	<td class="col text-right">
	<input class="btn btn-success mr-2" type="submit" value="등록"> 
	<input 	class="btn btn-secondary mr-2" type="submit" value="뒤로가기"	onclick="history.back();">
	</td>
</tr>

<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
	
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
	
			// 행하나 클릭시 선택한 사원의 정보가 화면에 뿌져지도록
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
						$(".emp1").eq(4).text(resp.emp_name);
						$(".emp1").eq(5).text(resp.name); 
						$(".emp1").eq(6).text(resp.bank); 
						$(".emp1").eq(7).text(resp.emp_bankno); 
						$(".emp1").eq(8).text(resp.emp_name); 
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