<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="retireMail">
<table class="table table-bordered  text-left" border="1">
	<thead class="table-primary">
		<tr >
			<td>입사일 </td> 
			<td>${emp.hire_date}</td>
			<td>퇴사일 </td> 
			<td>${emp.retire_date}</td>
			<td>퇴직금지급일 </td> 
			<td>${emp.payment_day}</td>
			<td>퇴직 기준일</td> 
			<td>${emp.payment_day}</td>
		</tr>
		<tr>
			<td>사원ID </td>
			<td>${emp.emp_no}</td>
			<td>소속</td>
			<td>${emp.dep_no}</td>
			<td>직급</td>	
			<td>${emp.pos_no}</td>		
			<td> 성명 </td>
			<td>${emp.emp_name}</td>	
		</tr>
		<tr >
			<td>근속일수 </td> 
			<td>근속일수 계산해야함</td>
			<td>일평균 임금</td>
			<fmt:parseNumber var="eatPrice" value="${7000 * work.work_date }" integerOnly="true" />
			<fmt:formatNumber type="number" var="eatPrice1" value="${eatPrice }" />
			<td>${eatPrice1} </td>
			<td>퇴직금 </td>
			<fmt:parseNumber var="retireMoney" value="${emp.my_basicsalary * 0.03035 }" integerOnly="true" />
			<fmt:formatNumber type="number" var="retireMoney1" value="${retireMoney }" />
			<td>${retireMoney1 } 원</td>
			<td>퇴직사유 </td> 
			<td>${emp.retire_reason}</td>
		</tr>
		<tr>
			<td>퇴직소득세</td>
			<fmt:parseNumber var="retireTax" value="${emp.my_basicsalary * 0.03035 }" integerOnly="true" />
			<fmt:formatNumber type="number" var="retireTax2" value="${retireTax }" />
			<td>${retireTax2 } 계삲야함 </td>
			<td>차인지급액</td>
			<fmt:parseNumber var="payment" value="${emp.my_basicsalary * 0.03035 }" integerOnly="true" />
			<fmt:formatNumber type="number" var="payment2" value="${payment }" />
			<td>${payment2 } 계산해야함 </td>
			<td>은행명</td>
			<td>${emp.bank }</td>
			<td>계좌번호</td>
			<td>${emp.emp_bankno}</td>
			
		</tr>
		
		</thead>
	</tbody>
	
</table>
</div>
<tr class="row">
	<td class="col text-right">
	<input class="" type="text" value="${emp.emp_email}" > 
	<input class="btn btn-success mr-2" type="submit" value="전송"> 
	</td>
</tr>


<script type="text/javascript">
    // 메일 내용하고 메일주소를 같이 묶어서 보내야 함
     // map형태로 만들어서 mail로 묶어서  data에 보냄 
    

     $("input[type='submit']").on("click",function(){
    	  
	     var mail = { content : $("#retireMail").html(),  mailadd : $("input[type='text']").val() }
    	
	     $.ajax({
    		  url : "${cPath}/emp/retire/retireMail",
    		  headers:{
	    		  "Content-Type" : 'application/json'
    		  },
    		  dataType : "html", // 컨트롤러에서 결과 값을 받을거
    		  type : 'post',
    		  data : JSON.stringify(mail),  // div로 묶은 내용을 mail에 담아서 보내기
    		  // 스크립트를 json으로 마쉘링 하는거 
    		  success : function(resp){
    			 	
    				  alert("메일이 전송되었습니다.");
    				 $("#exampleModal").modal("hide");
    		  }
    		  
    	  });
     });

</script>