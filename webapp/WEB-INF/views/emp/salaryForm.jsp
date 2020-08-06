<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


 <!--  급여내역 상세페이지 -->
<div>
<table class="table table-bordered  text-left">
	<thead class="table-primary">
		<tr >
			<td>사원ID</td>  
			<td> ${emp.emp_no}</td> 
			<td>소속팀</td>
			<td class=col-3> ${emp.dep_no} </td>
			<td>성명</td>
			<td class=col-3> ${emp.emp_name} </td>
		</tr>
		<tr>
			<td>근무기간</td>
			<td> 날짜 계산해서 넣어야 함  </td>
			<td>직급 </td>
			<td> ${emp.pos_no}</td>
			<td>지급일 </td>
			<td>${emp.sal_date} </td>
			
		</tr>
		<tr>
			<td>은행명 </td>
			<td> ${emp.bank}</td>
			<td>예금주 </td>
			<td> ${emp.emp_name} </td>
			<td>계좌번호  </td>
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
			<fmt:parseNumber var="mySalary" value="${ salary.my_basicsalary}" integerOnly="true" />
			<fmt:formatNumber type="number" var="mySalary1" value="${mySalary}" />
			<td>${mySalary1} 원</td>
			<td>소득세 </td>
			<fmt:parseNumber var="percent" value="${ salary.my_basicsalary / 168}" integerOnly="true" />
			<fmt:formatNumber type="number" var="percent1" value="${percent }" />
			<td>${percent1} 원</td>
			
		</tr>
		<tr>
			<td>연장수당 </td>
			<fmt:parseNumber var="extense" value="${ salary.extension_pay}" integerOnly="true" />
			<fmt:formatNumber type="number" var="extense1" value="${extense }" />
			<td>${extense1} 원</td>
			<td>주민세</td>
			<fmt:parseNumber var="juminTax" value="${ salary.my_basicsalary / 168 * 0.1}" integerOnly="true" />
			<fmt:formatNumber type="number" var="juminTax1" value="${juminTax }" />
			<td>${juminTax1} 원</td>
			
			
		</tr>
		<tr>
			<td>식대</td>
			<fmt:parseNumber var="eatPrice" value="${7000 * work.work_date }" integerOnly="true" />
			<fmt:formatNumber type="number" var="eatPrice1" value="${eatPrice }" />
			<td>${eatPrice1 } 원 </td>
			<td>고용보험 </td>
			<fmt:parseNumber var="goBOHUM" value="${salary.my_basicsalary * 0.0065 }" integerOnly="true" />
			<fmt:formatNumber type="number" var="goBOHUM1" value="${goBOHUM }" />
			<td>${goBOHUM1 } 원  </td>
			
		</tr>
		<tr>
			<fmt:parseNumber var="BUS" value="${1250 * 2 * work.work_date}" integerOnly="true" />
			<fmt:formatNumber type="number" var="BUS1" value="${BUS }" />
			<td>교통비</td>
			<td>${BUS1 } 원 </td>
			<td>국민연금 </td>
			<fmt:parseNumber var="KUKMIN" value="${salary.my_basicsalary * 0.045}" integerOnly="true" />
			<fmt:formatNumber type="number" var="KUKMIN1" value="${KUKMIN }" />
			<td>${KUKMIN1} 원</td>
			
		</tr>
		<tr>
			<td>기타</td>
			<td></td>
			<td>건강보험 </td>
			<fmt:parseNumber var="KUNKANG" value="${salary.my_basicsalary * 0.03035}" integerOnly="true" />
			<fmt:formatNumber type="number" var="KUNKANG1" value="${KUNKANG }" />
			<td>${KUNKANG1} 원</td>
			
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td>결근공제 </td>
			<td></td>
			
		</tr>
		<tr>
			<td>급여계</td>
			<fmt:parseNumber var="SALARYSUM" value="${salary.extension_pay + salary.my_basicsalary + (7000 * work.work_date) + (1250 * 2 * work.work_date)}" integerOnly="true" />
			<fmt:formatNumber type="number" var="SALARYSUM1" value="${SALARYSUM }" />
			<td>${SALARYSUM1}</td>
			<td>공제합계 </td>
			<fmt:parseNumber var="GONGJAE" value="${(salary.my_basicsalary / 168) + (salary.my_basicsalary / 168 * 0.1)+(salary.my_basicsalary * 0.0065)+(salary.my_basicsalary * 0.045 )+(salary.my_basicsalary * 0.03035) }" integerOnly="true" />
			<fmt:formatNumber type="number" var="GONGJAE1" value="${GONGJAE }" />
			<td>${GONGJAE1}</td>
			
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td>차감수령액 </td>
			<fmt:parseNumber  var="REMO" value="${(salary.extension_pay + salary.my_basicsalary + (7000 * work.work_date) + (1250 * 2 * work.work_date)) - ((salary.my_basicsalary / 168) + (salary.my_basicsalary / 168 * 0.1)+(salary.my_basicsalary * 0.0065)+(salary.my_basicsalary * 0.045 )+(salary.my_basicsalary * 0.03035))}"  integerOnly="true" />
			<fmt:formatNumber type="number" var="REMO1" value="${REMO }" />
			<td>${REMO1} </td>
			
		</tr>
	</tbody>
	
</table>
</div>