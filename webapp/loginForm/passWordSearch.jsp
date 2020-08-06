<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath }/resources/plugins/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">    
<!--
	Eventually by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${cPath}/resources/assets/css/main.css" /> 
	</head>

		<!-- Header -->
<form id="form" name="send" method="post" >
<div align="center"  border="2">   
	<table>
		<tr>
		<td >사원ID  </td>
		<td><input type="text" name="emp_no" id="emp_no" ></td>
		</tr>
		
		<tr>
		<td>성명</td>
		<td><input type="text" name="emp_name" id="emp_name"></td>
		</tr>
		
		<tr>
		<td>E-mail</td>
		<td><input type="text" name="emp_email" id="emp_email"></td>
		</tr>
	</table>
	<input type="button" value="확인" id="btn" >
</div>
</form>


	

	
<!-- Scripts -->
<script src="${cPath}/resources/assets/js/main.js"></script>
<script type="text/javascript">
	$(function(){
		
		var formData = $("#form").serialize(); // 입력 받은 데이터를 form으로 묶어서  formData에 넣어줌 
		
		$("#btn").on("click",function(){
			
			$.ajax({
				url : "${cPath}/mailSender",
				dataType : "text",
				type:'post',
				data :  formData,  // 입력 받은 값을 data에 넣어줌 
				success : function(resp){// 컨트롤러에서 리턴된 값을 받는거 
				if(resp == '수정완료'){
					alert("메일이 전송되었습니다.");
					}else{
						alert("오류 발생 다시 시도해주세요.");
						}
	
// 					location.href="redirect:/{cPath}";
				},
				
			})
		})
		
	})
</script>



 
 
 
 
 
 
 
 
 
 
 
 

