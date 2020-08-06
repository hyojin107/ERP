<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>구매요청서</h2>
<form action="${cPath}/buy/document" method="post">
작성 담당자<input type="button" id="empBtn" value="찾기"/>
<input type="text" name="emp_no" id="empNo"/><input type="text" id="empName"/>
납기 요청일자 <input type="date" name="doc_inDate"/>
<br>
<input type="button" id="matBtn" value="원자재 추가"/>
<input type="button" value="엑셀 파일 불러오기"/>
<input type="button" value="구매요청서 형식 다운로드"/>

<c:if test="${not empty message }">
<!-- 	<input type="hidden" id="insertError" value="insert 오류"/> -->
	<script type="text/javascript">
		alert(message);
	</script>
</c:if>

<br/><h4>'원자재추가' 버튼을 클릭하여, 요청목록을 추가하세요!</h4>
<table id="formTable" class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">품목코드</th>
      <th scope="col">품목명</th>
      <th scope="col">분류명</th>
      <th scope="col">규격</th>
      <th scope="col">수량</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
<input type="button" id="delBtn" value="선택삭제"/>
<br/>
<input type="submit" value="등록"/>
</form>

<!-- 모달창 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      </div>
      <div class="modal-footer">
      	<button type="button" id="matAddBtn" class="btn btn-primary mr-2" data-dismiss="modal">추가</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript">
	
	var exampleModal = $("#exampleModal").modal({
	   show:false
	}).on("hidden.bs.modal", function(){
	   exampleModal.find(".modal-body").empty();
	});
	//사원 목록 모달창
	modalView({
	  noText : "#empNo",      //사원 클릭 시, 입력될 태그 지정
	  nameText : "#empName",  //사원 클릭 시, 입력될 태그 지정
	  clickBtn : "#empBtn",        //모달창을 띄울 버튼 지정
	  urlPath : "${cPath}/buy/document/empModal",
	  title:"사원 목록"            //제목
	});

	
	//원자재 모달창
	function loadMatView(){
		$("#matAddBtn").show();
		$("#exampleModalLabel").text("원자재 목록");
		$.ajax({
			url : "${cPath}/buy/document/matModal",
			dataType : "html",
			success : function(resp) {
				exampleModal.find(".modal-body").html(resp); 
				exampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
		$(document).off("click", "#matTable td");
	}
	//테이블에 원자재 추가
	var index = 0;
	$(document).on("click", "#matAddBtn", function(){
		$("input[name=checkMat]:checked").each(function() {
			let mat_no = $(this).val();
			let mat_name = $(this).parent().parent().find(".mat_name").text();
			let lprod_name = $(this).parent().parent().find(".lprod_name").text();
			let mat_stand_size = $(this).parent().parent().find(".mat_stand_size").text();
			
			let str = $("<tr/>").addClass('trTag').append(
					$("<th>").html($("<input/>").addClass('formCheck').attr({type:"checkbox"})),
					$("<td>").html($("<input readonly/>").attr({type:"text", name:"matList["+index+"].mat_no", value:mat_no})),
					$("<td>").html($("<input readonly/>").attr({type:"text", value:mat_name})),
					$("<td>").html($("<input readonly/>").attr({type:"text", value:lprod_name})),
					$("<td>").html($("<input readonly/>").attr({type:"text", value:mat_stand_size})),
					$("<td>").html($("<input/>").attr({type:"text", name:"matList["+index+"].qty"}))
			);
			$("#formTable tbody").append(str);
			index++;
		});
	});
	$("#matBtn").on("click", function(){
		loadMatView();
	});
	
	//체크박스 체크
	$(document).on("click", "#formTable td", function(){
		let check = $(this).parent().find(".formCheck").prop("checked");
		if(check==false){
			$(this).parent().find(".formCheck").prop("checked", true);			
		}else{
			$(this).parent().find(".formCheck").prop("checked", false);
		}
	});

	$(document).on("click", "#delBtn", function(){
		console.log(this);
		$("input[class=formCheck]:checked").each(function() {
			$(this).parent().parent().remove();	//tr삭제
		})
	});
	
	
	
</script>


