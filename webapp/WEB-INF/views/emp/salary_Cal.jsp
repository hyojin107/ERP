<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
</head>
    <style>
      table {
        width: 70%;
        border: 1px solid #333333;
         padding: 20px;
         margin: 40px;
      }
      td {
        padding: 5px;
        border: 1px solid #333333;
      }
      th {
        padding: 5px;
        border: 1px solid #333333;
      }
      /* .a {
        border-collapse: separate;
      }
      .b {
        border-collapse: collapse;
      } */
    </style>
       
<h1>급여 정책 </h1>
<table>
    <thead>
    <tr>
        <th scope="cols">부서명</th>
        <th scope="cols">직급</th>
        <th scope="cols">기본급여</th>
        <th scope="cols"></th>
    </tr>
    </thead>
    <tbody  id="table-body">
	<tr>
        <td rowspan="5">인사부서</td>
          <c:forEach items="${cal}" var="salCal"> <!-- // cal 값이 무엇인가??  salCal만큼 cal을 for문으로 돌림 -->
	        	<c:if test="${salCal.dep_no == 'EM'}"><!--  // deo_no 값이 em -->
       			   <input type="hidden" value="${salCal.dep_no}">
		       		<tr>
			       		<td>${salCal.pos_name} <!--  // 직급번호를 salCal에 붙이기 -->
			       		<input type="hidden" value="${salCal.pos_no }"></td>
			        	<td><input type="text" value="${salCal.salary }" name="salary" readonly="readonly"></td>  <!-- //등록 한거  -->
				        <td><input type="button" class="btn btn-primary" value="수정"></td>
			        </tr>
		        </c:if>
	       </c:forEach>

	</tr>
    
   <!--  // td값에 해당하는 곳에 값을 새로 넣음 
    // 새로운 값을 update해서 db의 값을 변경해주는거 --> 
    
    <tr>
       <td rowspan="5">자재부서</td>            
	        <c:forEach items="${cal}" var="salCal">
	        	<c:if test="${salCal.dep_no == 'ST'}">
			        <input type="hidden" value="${salCal.dep_no}">
		       		<tr>
			       		<td>${salCal.pos_name}
			       		<input type="hidden" value="${salCal.pos_no }">
			       		</td>  
			        	<td><input type="text" value="${salCal.salary }" name="salary" readonly="readonly"></td>
				        <td><input type="button" class="btn btn-primary " value="수정" ></td>
			        </tr>
		        </c:if>
	       </c:forEach>
    </tr>
   
    
    
    <tr>
       <td rowspan="5">구매부서</td>
   		  <c:forEach items="${cal}" var="salCal">
	        	<c:if test="${salCal.dep_no == 'BU'}">
		   		  <input type="hidden" value="${salCal.dep_no}">
		       		<tr>
			       		<td>${salCal.pos_name}
			       		<input type="hidden" value="${salCal.pos_no }">
			       		</td>  
			        	<td><input type="text" value="${salCal.salary }" name="salary" readonly="readonly"></td>
				        <td><input type="button" class="btn btn-primary" value="수정"></td>
			        </tr>
		        </c:if>
	       </c:forEach>
    </tr>
    
    
    
    <tr>
       <td rowspan="5"> 영업부서</td>
        	 <c:forEach items="${cal}" var="salCal">
	        	<c:if test="${salCal.dep_no == 'OD'}">
		        	 <input type="hidden" value="${salCal.dep_no}">
		       		<tr>
			       		<td>${salCal.pos_name}
			       		<input type="hidden" value="${salCal.pos_no }">
			       		</td>  
			        	<td><input type="text" value="${salCal.salary }" name="salary" readonly="readonly"></td>
				        <td><input type="button" class="btn btn-primary" value="수정"></td>
			        </tr>
		        </c:if>
	       </c:forEach>
    </tr>
    
    
    <tr>
       <td rowspan="5" data-dep_no = "">회계부서</td>
        	<c:forEach items="${cal}" var="salCal">
	        	<c:if test="${salCal.dep_no == 'AC'}">
		        	<input type="hidden" value="${salCal.dep_no}">
		       		<tr>
			       		<td>${salCal.pos_name}
			       		<input type="hidden" value="${salCal.pos_no }">
			       		</td>  
			        	<td><input type="text" value="${salCal.salary }" name="salary" readonly="readonly"></td>
				        <td><input type="button" class="btn btn-primary" value="수정"></td>
			        </tr>
		        </c:if>
	        </c:forEach>
    </tr>
    
    
    
     <tr>
       <td rowspan="5">생산부서</td>
         	<c:forEach items="${cal}" var="salCal">
	        	<c:if test="${salCal.dep_no == 'PR'}">
	         		<input type="hidden" value="${salCal.dep_no}">
		       		<tr>
			       		<td>${salCal.pos_name}<input type="hidden" value="${salCal.pos_no}"></td>  
			        	<td><input type="text" value="${salCal.salary }" name="salary" readonly="readonly" ></td>
				        <td><input type="button" class="btn btn-primary" value="수정"></td>
			        </tr>
		        </c:if>
	        </c:forEach>
    </tr>
    </tbody>
</table>

<!-- 저장버튼을 눌렀을 때 컨트롤러로 이동 하는곳  -->
<form action="${cPath}/emp/salary" id="changeForm">
	<input type = "hidden" name="salary" id="salary"> 

</form>



<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>

<script type="text/javascript">

	// 해당하는 값의 버튼인지 어떻게 암?
	// 저장 버튼을 배열로 만들고 찾아서 해당 value 값의 버튼을 클릭하면 동작하도록?
	
// 	var xx = $("#table-body input[name=tt] ").val();
// 	alert(xx);

	// upBtn은 '수정' 이 고정 
	var upBtn =  $("input[type='button']").on("click",
		function(event){ // 수정버튼을 클릭하면 버튼의 이름이 등록으로 변경되고 활성화되게 
		 var bts = this; // 클릭한 순간을 this 
		
// 		 var ex = $("#table-body tr").eq(0).find("tr").eq(0).find("td").eq(1).val();
// 		 alert(ex);
		
			if('수정'== $(this).val()){ // 버튼 한개를 클릭한거 값이 수정이면  
				$(this).val('등록'); //  선택한 버튼의 값이 등록으로 변경되고 
				$(this).parent().parent().find("input[name='salary']").removeAttr('readonly'); // 텍스트 박스의 readonly를 지워준다. 
			return;
			}
			
		// 버튼이 등록으로 바뀌면  upBtn을 다시 타고 들어와서 	
		// 버튼의 부모를 찾는거 
		var ss = $(this).parent().parent(); // 텍스트 박스 찾는거 
		var inputtag = ss.find("input[name='salary']").val(); // inputtag의 변경된 값이 들어가는거 
		
		var position = ss.find("input[type='hidden']").val(); // 직급을 찾아서  hidden에 숨어 있는 pos_no를 찾는거 
		
		var depart = ss.parent().find("input[type='hidden']").val(); // 부서를찾는거  
		
		
		
		$.ajax({
				url : "${cPath}/emp/salary",
				method : "post",
				dataType : "text",
				data : {
					'salary' : inputtag , // 컨트롤러에 vo를 담을 값을  salary에 담음   
			//  	     키          :     값	
					 'pos_no' : position,
					 'dep_no' : depart
					 
				},
				success : function(resp){  // 컨트롤러를 타고 와서 결과 응답 결과를 판별
					
					
					$(bts).val('수정'); //  선택한 버튼의 값이 등록으로 변경되고 
					$(bts).parent().parent().find("input[name='salary']").add('readonly','readonly');
					
						alert("수정되었습니다");
					
					}
			
				});
// 				error : function(errorResp){
// 					console.log(errorResp.status + ":" + errprResp.responseText)
// 			}
	});
	
	
	
   


</script>
