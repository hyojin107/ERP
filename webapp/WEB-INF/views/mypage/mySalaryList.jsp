<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>급여내역 조회</h1>  
 <thead class="table-primary">
		<tr>
			<th>급여년월</th>
			<td><input type="date"></td>
			<td><input type="button" value="검색"></td>
		</tr>
</thead>
 
 


<div>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr >
			<td>사원ID  : ${emp.emp_no}</td> 
			<td>부서        : ${dep.dep_name}</td>
			<td>직급         : ${position.pos_name}</td>
			<td>지급일 : ${salary.sal_date} </td>
		</tr>
		<tr>
			<td>근무기간 :</td>
			<td>  <text id="work"></text></td>
			<td>소속 : </td>
			<td> ${dep.dep_no}</td>
		</tr>
		<tr>
			<td>은행명 : ${emp.bank}</td>
			<td>예금주 : ${emp.emp_name} </td>
			<td>계좌번호 : </td>
			<td>${emp.emp_bankno}</td>
			
		</tr>
		
	</thead>
</table>	
 </div> 
  
 <div>
<table class="table table-bordered table-hover text-left">	
	<tbody id="listBody">
		<tr>
			<th>지급항목</th>
			<th>지급액 </th>
			<th>공제항목 </th>
			<th>공제액</th>
			
		</tr>
		<tr>
			<td>기본급 </td>
			<td>${salary.my_basicsalary} 원</td>
			<td>소득세 </td>
			<td>${salary.my_basicsalary / 168 } 원</td>
			
		</tr>
		<tr>
			<td>연장수당 </td>
			<td>${salary.extension_pay} 원</td>
			<td>주민세</td>
			<td>${salary.my_basicsalary / 168 * 0.1 } 원</td>
			
			
		</tr>
		<tr>
			<td>식대</td>
			<td>${7000 * work.work_date } 원 </td>
			<td>고용보험 </td>
			<td>${salary.my_basicsalary * 0.0065 } 원  </td>
			
		</tr>
		<tr>
			<td>교통비</td>
			<td>${1250 * 2 * work.work_date } 원 </td>
			<td>국민연금 </td>
			<td>${salary.my_basicsalary * 0.045 } 원</td>
			
		</tr>
		<tr>
			<td>기타</td>
			<td></td>
			<td>건강보험 </td>
			<td>${salary.my_basicsalary * 0.03035 } 원</td>
			
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td>결근공제 </td>
			<td></td>
			
		</tr>
		<tr>
			<td>급여계</td>
			<td>${salary.extension_pay + salary.my_basicsalary + (7000 * work.work_date) + (1250 * 2 * work.work_date)}</td>
			<td>공제합계 </td>
			<td>${(salary.my_basicsalary / 168) + (salary.my_basicsalary / 168 * 0.1)+(salary.my_basicsalary * 0.0065)+(salary.my_basicsalary * 0.045 )
			     +(salary.my_basicsalary * 0.03035) }</td>
			
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td>차감수령액 </td>
			<td>${(salary.extension_pay + salary.my_basicsalary + (7000 * work.work_date) + (1250 * 2 * work.work_date))
			  - ((salary.my_basicsalary / 168) + (salary.my_basicsalary / 168 * 0.1)+(salary.my_basicsalary * 0.0065)+(salary.my_basicsalary * 0.045 )+(salary.my_basicsalary * 0.03035)  )}
			 </td>
			
		</tr>
	</tbody>
	
</table>
</div>
<%-- <form id="searchForm" action="${pageContext.request.contextPath }/board">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
</form> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paiging.js"></script>
<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let boardList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(boardList.length>0){
				$.each(boardList, function(idx, board){
					let trTag = $("<tr>").append(
									$("<td>").text(board.rnum)
									, $("<td>").html(
										$("<a>").attr("href", "${pageContext.request.contextPath }/board/"+board.bo_no)
												.html(board.bo_title)													
									)
									, $("<td>").text(board.bo_writer)
									, $("<td>").text(board.bo_date)
									, $("<td>").text(board.bo_hit));
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

</script> --%>