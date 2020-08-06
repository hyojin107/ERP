<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 2        송효진      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<h2>발주 신청서</h2>
<form action="${cPath}/buy/order" method="post">
납기요청일자 <input type="date" name="req_date"/>
<br/>거래처 <input type="button" id="buyerBtn" value="찾기"/>
<input type="text" id="buyer_no" name="buyer_no" readonly/><input type="text" id="buyer_name" readonly/>
<br>
<input type="button" id="matBtn" value="원자재 추가"/>
<input type="button" onclick="addRow()" value="일반발주 추가"/>
<input type="button" value="엑셀 파일 불러오기"/>
<input type="button" value="발주서 형식 다운로드"/>

<c:if test="${not empty message }">
<!-- 	<input type="hidden" id="insertError" value="insert 오류"/> -->
	<script type="text/javascript">
		alert(message);
	</script>
</c:if>

<!-- ------------------------------------------------------------------------------------ -->
<h5>구매요청 원자재목록</h5>
<div id="docDiv" style="height:220px;">
<table id="docTable" class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">구매요청번호</th>
      <th scope="col">품목코드</th>
      <th scope="col">품목명</th>
      <th scope="col">분류명</th>
      <th scope="col">규격</th>
      <th scope="col">수량</th>
      <th scope="col">요청 삭제</th>
    </tr>
  </thead>
  <tbody>
  	<c:if test="${not empty docMatList }">
  		<c:forEach items="${docMatList}" var="docMat">
  			<tr>
  				<th><input type="checkbox" class="docCheck" style="width:40px;"/></th>
  				<td class="buy_no">${docMat.buy_no }</td>
  				<td class="mat_no">${docMat.matVO.mat_no }</td>
  				<td class="mat_name">${docMat.matVO.mat_name }</td>
  				<td class="lprod_name">${docMat.matVO.lprodVO.lprod_name }</td>
  				<td class="stand_size">${docMat.matVO.mat_stand_size }</td>
  				<td class="qty">${docMat.qty }</td>
	  			<th><input type="button" class="docDelBtn" value="삭제" style="width:80px;"/></th>
  			</tr>
  		</c:forEach>
  	</c:if>
  	<c:if test="${empty docMatList }">
  		<tr>
  			<td colspan="7">구매 요청된 원자재가 없습니다.</td>
  		</tr>
  	</c:if>
  </tbody>
</table>
</div>
<input type="checkbox" id="allDocChk"/><label for="allDocChk">모두 선택</label>
<input type="button" id="docMoveBtn" value="발주이동"/>
<!-- ------------------------------------------------------------------------------------ -->


<table id="formTable" class="table table-hover" data-idx="0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">품목코드</th>
      <th scope="col">품목명</th>
      <th scope="col">분류명</th>
      <th scope="col">규격</th>
      <th scope="col">수량</th>
      <th scope="col">단가</th>
      <th scope="col">공급가액</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
<input type="checkbox" id="allChk"/><label for="allChk">모두 선택</label>
<input type="button" id="delBtn" value="선택삭제"/><br/>
<input type="submit" value="발주등록"/>
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
      	<button type="button" id="matAddBtn" class="btn btn-primary mr-2" data-dismiss="modal" style="display:none">추가</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<style type="text/css">
  tbody td input {width:100px;}
  #docDiv {overflow-y:scroll}
</style>
<script type="text/javascript" src="${cPath}/resources/js/modalView.js"></script>
<script type="text/javascript">
	
	//구매요청 체크박스
	$(document).on("click", "#docTable tr", function(){
		let check = $(this).find(".docCheck").prop("checked");
		if(check==false){
			$(this).find(".docCheck").prop("checked", true);			
		}else{
			$(this).find(".docCheck").prop("checked", false);
		}
	});
	$("#allDocChk").click(function(){	//전체선택, 전체 해제
		var chk = $("#allDocChk").prop("checked");
		if(chk){
			$(".docCheck").prop("checked",true);
		}else{
			$(".docCheck").prop("checked",false);
		}
	});
	$("#allChk").click(function(){	//전체선택, 전체 해제
		var chk = $("#allChk").prop("checked");
		if(chk){
			$(".formCheck").prop("checked",true);
		}else{
			$(".formCheck").prop("checked",false);
		}
	});
	
	//요청항목 삭제
	$(".docDelBtn").on("click", function(){
		let buyNo = $(this).parent().parent().find(".buy_no").text();
		let matNo = $(this).parent().parent().find(".mat_no").text();
		let matName = $(this).parent().parent().find(".mat_name").text();
		let trTag = $(this).parent().parent();
		
		if(confirm("요청 항목 '"+matName+"'을 정말로 삭제하시겠습니까?")){
			$.ajax({
				url : "${cPath}/buy/order/docDel",
				data : {
					buy_no : buyNo,
					mat_no : matNo
				},
				method : "post",
				dataType : "text",
				success : function(resp) {
					trTag.remove();
					alert(resp);
				},
				error : function(errorResp) {
					console.log(errorResp.status + ":" + errorResp.responseText);
				}
			});
		}
	});
	
	//발주리스트로 이동
	$("#docMoveBtn").on("click", function(){
		let index = $("#formTable").attr("data-idx");
		$("input[class=docCheck]:checked").each(function() {
			$(this).parent().parent().remove();	//tr삭제
			
			let buy_no = $(this).parent().parent().find(".buy_no").text();
			let mat_no = $(this).parent().parent().find(".mat_no").text();
			let mat_name = $(this).parent().parent().find(".mat_name").text();
			let lprod_name = $(this).parent().parent().find(".lprod_name").text();
			let stand_size = $(this).parent().parent().find(".stand_size").text();
			let qty = $(this).parent().parent().find(".qty").text();
			
			let trTag = "<tr><th><input type='checkbox' class='formCheck' style='width:40px;'/></th>";
			trTag += "<input type='hidden' class='buy_no' name='matList["+index+"].buy_no' value='"+ buy_no +"'/>";	//구매요청번호
			trTag += "<td><input type='text' name='matList["+index+"].mat_no' class='mat_no' value='"+ mat_no +"' readonly/></td>";	//품목코드
			trTag += "<td><input type='text' class='mat_name' value='"+ mat_name +"' readonly/></td>";	//품목명
			trTag += "<td><input type='text' class='lprod_name' value='"+ lprod_name +"' readonly/></td>";	//분류명
			trTag += "<td><input type='text' class='stand_size' value='"+ stand_size +"' readonly/></td>";	//규격
			trTag += "<td><input type='text' name='matList["+index+"].ormat_qty' class='qty' value='"+ qty +"' readonly/></td>";	//수량
			trTag += "<td><input type='number' name='matList["+index+"].cost'/></td>";	//단가
			trTag += "<td><input type='number'/></td></tr>";	//공급가액
			$("#formTable tbody").append(trTag);
			index++;
		});
		$("#formTable").attr("data-idx", index);
	});
	
	
	//테이블 행 추가 삭제
	var itemidx = 0;
	function addRow(){
		let str = "<tr><th><input type='checkbox' class='formCheck' style='width:40px;'/></th>";
		str += "<td></td>";
		str += "<td><input type='text' name='itemList["+itemidx+"].item_name'/></td>";	//품목명
		str += "<td><input type='text' name='itemList["+itemidx+"].item_lprod'/></td>";	//분류명
		str += "<td><input type='text' name='itemList["+itemidx+"].item_stand_size'/></td>";	//규격
		str += "<td><input type='number' name='itemList["+itemidx+"].item_qty'/></td>";	//수량
		str += "<td><input type='number' name='itemList["+itemidx+"].item_cost'/></td>";	//단가
		str += "<td><input type='text'/></td></tr>";	//공급가액
		$("#formTable").append(str);
		itemidx++;
	}
// 	function delRow(){
// 		if($("#formTable tr").length < 3) return;
// 		$("#formTable tr:last").remove();	//마지막 행 삭제
// 	}

	var exampleModal = $("#exampleModal").modal({
	   show:false
	}).on("hidden.bs.modal", function(){
	   exampleModal.find(".modal-body").empty();
	});
	//거래처 목록 모달창
	modalView({
	  noText : "#buyer_no",      //사원 클릭 시, 입력될 태그 지정
	  nameText : "#buyer_name",  //사원 클릭 시, 입력될 태그 지정
	  clickBtn : "#buyerBtn",         //모달창을 띄울 버튼 지정
	  urlPath : "${cPath}/buy/document/buyerModal",
	  title:"거래처 목록"            //제목
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
	$(document).on("click", "#matAddBtn", function(){
		let index = $("#formTable").attr("data-idx");
		$("input[name=checkMat]:checked").each(function() {
			let mat_no = $(this).val();
			let mat_name = $(this).parent().parent().find(".mat_name").text();
			let lprod_name = $(this).parent().parent().find(".lprod_name").text();
			let mat_stand_size = $(this).parent().parent().find(".mat_stand_size").text();
			
			let str = $("<tr/>").addClass('trTag').append(
					$("<td>").html($("<input/>").addClass('formCheck').attr({type:"checkbox", style:"width:40px;"})),
					$("<td>").addClass('inputStyle').addClass('mat_no').html($("<input readonly/>").attr({type:"text", name:"matList["+index+"].mat_no", value:mat_no})),
					$("<td>").addClass('inputStyle').html($("<input readonly/>").attr({type:"text", value:mat_name})),
					$("<td>").addClass('inputStyle').html($("<input readonly/>").attr({type:"text", value:lprod_name})),
					$("<td>").addClass('inputStyle').html($("<input readonly/>").attr({type:"text", value:mat_stand_size})),
					$("<td>").addClass('inputStyle').html($("<input/>").attr({type:"number", name:"matList["+index+"].ormat_qty"})),
					$("<td>").addClass('inputStyle').html($("<input/>").attr({type:"number", name:"matList["+index+"].cost"})),
					$("<td>").addClass('inputStyle').html($("<input/>").attr({type:"number"}))
			);
			$("#formTable tbody").append(str);
			index++;
		});
		$("#formTable").attr("data-idx", index);
	});
	$("#matBtn").on("click", function(){
		loadMatView();
	});
	
	//발주서 부분 체크박스 체크
	$(document).on("click", "#formTable td", function(){
		let check = $(this).parent().find(".formCheck").prop("checked");
		if(check==false){
			$(this).parent().find(".formCheck").prop("checked", true);			
		}else{
			$(this).parent().find(".formCheck").prop("checked", false);
		}
	});
	
	//발주서 부분 선택삭제
	$(document).on("click", "#delBtn", function(){
		$("input[class=formCheck]:checked").each(function(){
			$(this).parent().parent().remove();	//tr삭제
			let mat_no = $(this).parent().parent().find(".mat_no").val();
			let buy_no = $(this).parent().parent().find(".buy_no").val();
			if(mat_no != null && buy_no != null){
 				let mat_name = $(this).parent().parent().find(".mat_name").val();
				let lprod_name = $(this).parent().parent().find(".lprod_name").val();
				let stand_size = $(this).parent().parent().find(".stand_size").val();
				let qty = $(this).parent().parent().find(".qty").val();
				
				let trTag = "<tr><th><input type='checkbox' class='docCheck' style='width:40px;'/></th>";
  				trTag += "<td class='buy_no'>"+buy_no+"</td>";
  				trTag += "<td class='mat_no'>"+mat_no+"</td>";
  				trTag += "<td class='mat_name'>"+mat_name+"</td>";
  				trTag += "<td class='lprod_name'>"+lprod_name+"</td>";
  				trTag += "<td class='stand_size'>"+stand_size+"</td>";
  				trTag += "<td class='qty'>"+qty+"</td>";
	  			trTag += "<th><input type='button' class='docDelBtn' value='삭제' style='width:80px;'/></th></tr>";
				$("#docTable tbody").append(trTag);
			}
		});
	});


</script>


