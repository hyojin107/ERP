<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 3      	이제경       	최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>




<br>
<h1>견적서폼</h1>
<br>

<style>
table {
	border-collapse: collapse;
}

th, td {
	border: 1px solid gray;
}
</style>

<form:form id="estimateForm" modelAttribute="estimate" method="post" enctype="multipart/form-data" class="#"
	action="${cPath }/order/estimate/${estimate.est_no }">

	<c:if test="${not empty estimate.est_no }" >
		<input type="hidden" name="_method" value="${'delete' eq methodType ?'delete':'put' }">
	</c:if>
	
	<input class="form-control" type="hidden" name="currentPage" value="${param.currentPage }"/>
	

	<table>
		<tr>
			<th><spring:message code="date" /></th>
			<td><input type="date" name="est_date" value="${estimate.est_date }"></td>
		</tr>
		<tr>
			<th><spring:message code="estimate.est_no" /></th>
			<td><input type="text" name="est_no" value="${estimate.est_no }" readonly="readonly"></td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" />
				<input type="button" id="buyerBtn" value="찾기"/>
			</th>
			<td><input type="text" name="buyer_no" id="buyer_no" value="${estimate.buyer_no }"/>
				<input type="text" id="buyer_name" value="${estimate.buyer_name }" /></td>
		</tr>
		<tr>
			<th><spring:message code="emp.emp_name" />
				<input type="button" id="empBtn" value="찾기"/>
				
			</th>
			<td><input type="text" name="emp_no" id="empNo" value="${estimate.emp_no }"/>
				<input type="text" id="empName" value="${estimate.emp_no }" /></td>
		</tr>
	</table>
	<table>
		<thead>
		
			<tr>
				<td id="hid">
<!-- 									<div class="searchUI"> -->
						<select class="dynamicElement" id="selectLprod_no"
							data-url="<c:url value='/order/estimate/prod/lprod'/>">
							<option value="">상품분류</option>
<%-- 								<c:forEach items="${lprodList }" var="estimate"> --%>
<%-- 									<option value="${estimate.lprod_no }">${estimate.lprod_name }</option> --%>
<%-- 								</c:forEach> --%>
						</select> 
<!-- 										<select class="dynamicElement" name="lprod_no" -->
<%-- 											data-url="<c:url value='/order/estimate/form'/>"> --%>
<!-- 											<option>상품분류</option> -->
<!-- 										</select>  -->
						<select class="dynamicElement" id="selectProd_no"
							data-url="<c:url value='/order/estimate/prod/prod'/>">
							<option value="">상품명</option>
						</select>
<!-- 									</div>  -->
						
				</td>	
				<td id="addProd">
					 <input type="button" value="품목추가" onclick="addProd()">
<!-- 					 <input type="button" value="품목삭제" onclick="addProd()"> -->
<!-- 					 <button type="button" id="matAddBtn" class="btn btn-primaty mr-2" data-dismiss="modal">추가</button> -->
<!-- 					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>	 -->
				</td>
			</tr>
		</thead>			
		<tbody>
			<tr>
<%-- 				<td><input type="text" name="prod_code" value="${prod } "></td> --%>
<!-- 				<td><input type="text" name="prod_code"></td> -->

				<td>


					<table id="estimateTable">
						<thead>
							<tr>
								<th>#</th>
								<th><spring:message code="prod_code" /></th>
								<th><spring:message code="prod_name" /></th>
								<th><spring:message code="prod_standard" />단위</th>
								<th><spring:message code="prod_qty" /></th>
								<th><spring:message code="prod_price" /></th>
								<th><spring:message code="prod_validity" /></th>
								<th><spring:message code="prod_totalprice" /></th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody id="listBody">
						<c:choose>
							<c:when test="${not empty estimate }">
<%-- 								<c:forEach items="${estimate }" var="estimate"> --%>
									<c:if test="${estimate.estimateList!=null }">
									<c:forEach items="${estimate.estimateList }" var="list">
										<c:if test="${list.prodList!=null }">
										<c:forEach items="${list.prodList }" var="pList">
											<tr>
												<td><input type="checkbox" name="inputChk"></td>
												<td><input type="text" value="${pList.prod_no }" name="prod_no"></td>
												<td><input type="text" value="${pList.prod_name }" name="prod_name"></td>
												<td><input type="text" value="${pList.prod_standard }${pList.prod_stand_size}" name="prod_standard"></td>
												<td><input type="text" value="${list.est_qty }" name="est_qty"></td>
												<td><input type="text" value="${pList.prod_out_price }" name="prod_out_price"></td>
												<td><input type="text" value="${pList.prod_validity }" name="prod_validity"></td>
												<td><input type="text" value="${list.est_qty*pList.prod_out_price }" name="est_price"></td>
											</tr>								
										</c:forEach>
										</c:if>
									</c:forEach>
									</c:if>
<%-- 								</c:forEach> --%>
							</c:when>
						</c:choose>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
	<tfoot>
			<tr>
				<td id="deleteProd">
					<input type="button" id="deleteProdBtn" value="품목삭제" onclick="delProd()">
				</td>
				<td colspan="1">
					<input type="submit" value="저장"> 
					<input type="reset" value="초기화"> 
					<input type="button" value="목록으로" onclick="location.href='<c:url value="/order/estimate"/>'" />
				</td>
			</tr>
		</tfoot>
	</table>
</form:form>


<!-- 거래처 모달창 -->
<div class="modal fade" id="exampleModal"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
<script type="text/javascript"src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">

//품목 삭제
//---------------------------------------------------------------------------------
	
	function delProd(){
		var listBody = document.getElementById('listBody');
		var lastRow = listBody.rows.length;
		var confirm_val = confirm("선택한 상품을 삭제하시겠습니까?");
		if(confirm_val){
			for(var i=lastRow; i>=1; i--){
				if($("#listBody").find("input:checkbox").eq(i-1).is(":checked")){
				alert("선택");
					listBody.deleteRow(i-1);
// 					index--;
				}
			}
		}

	}
	

//거래처 모달창
//---------------------------------------------------------------------------------
// 	function loadBuyerView(){
// // 		$("#matAddBtn").hide();
// // 		$("#exampleModal").text("사원목록");
// 		$.ajax({
// 			url : "${cPath}/order/modal/estimate/buyer",
// 			dataType : "html",
// 			success : function(resp) {
// 				exampleModal.find(".modal-body").html(resp);
// 				exampleModal.modal("show");
// 			},
// 			error : function(errorResp) {
// 				console.log(errorResp.status + ":" + errorResp.responseText);
// 			}
// 		});
// 		$(document).on("click", "#buyerTable tr", function(){
// 			let buyer_no = $(this).find(".buyer_no").text();
// 			let buyer_name = $(this).find(".buyer_name").text();
// 			exampleModal.modal("hide");
			
// 			$("#buyer_no").val(buyer_no);
// 			$("#buyer_name").val(buyer_name);
// 		}).css({ cursor:"pointer" });
// 	}
// 	$("#buyerBtn").on("click", function(){
// // 		exampleModal.modal("show");
// 		loadBuyerView();
// 	});
	


//담당자 모달창
//---------------------------------------------------------------------------------
// 	function loadEmpView(){
// 		$("#matAddBtn").hide();
// // 		$("#exampleModal").text("사원목록");
// 		$.ajax({
// 			url : "${cPath}/buy/document/empModal",
// 			dataType : "html",
// 			success : function(resp) {
// 				exampleModal.find(".modal-body").html(resp);
// 				exampleModal.modal("show");
// 			},
// 			error : function(errorResp) {
// 				console.log(errorResp.status + ":" + errorResp.responseText);
// 			}
// 		});
// 		$(document).on("click", "#empTable tr", function(){
// 			let emp_no = $(this).find(".emp_no").text();
// 			let emp_name = $(this).find(".emp_name").text();
// 			exampleModal.modal("hide");
			
// 			$("#empNo").val(emp_no);
// 			$("#empName").val(emp_name);
// 		}).css({ cursor:"pointer" });
// 	}
// 	$("#empBtn").on("click", function(){
// // 		exampleModal.modal("show");
// 		loadEmpView();
// 	});

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
      title:"사원 목록"				//제목
   });
   //거래처 목록 모달창
   modalView({
	  noText : "#buyer_no",      //사원 클릭 시, 입력될 태그 지정
	  nameText : "#buyer_name",  //사원 클릭 시, 입력될 태그 지정
	  clickBtn : "#buyerBtn",         //모달창을 띄울 버튼 지정
      urlPath : "${cPath}/buy/document/buyerModal",
      title:"거래처 목록"				//제목
   });

	
//상품추가
//---------------------------------------------------------------------------------
	var index=0;
	function addProd(){
				$.ajax({
					type:"get",
					url:"${cPath}/order/estimate/prod/"+prod_no
				}).done(function(resp){
						let prod = resp;
						var trTags = [];
								trTag = $("<tr>").append(
										$("<td>").html($("<input>").attr({type:"checkbox", name:"inputChk"})),
										$("<td>").html($("<input>").attr("type",'text').attr("name","estimateList["+index+"].prod_no").val(prod.prod_no)),
										$("<td>").text(prod.prod_name),
										$("<td>").text(prod.prod_standard).attr("name", "prod_standard"),
										$("<td>").html($("<input>").attr("type",'text').attr("name","estimateList["+index+"].est_qty")),
										$("<td>").text(prod.prod_out_price),
// /										$("<td>").text(prod.prod_totalPrice),
										$("<td>").text(prod.prod_validity),
										$("<td>").html($("<input readonly/>").attr({type:"text", name:"est_price"}))
										.data("prod_no", prod.prod_no));
							totalPrice(trTag, index);
								index++;
							$("#listBody").append(trTag);
							alert(index);
							alert(result);
// 							$(select).prop("select[name=prod_no]",0);
// 							$(select).prop("select[name=lprod_no]",0);



				});
	}
	
// 	var totalPrice(){
// 		result = est_qty * prod_price;
// 		alert(result);
// 	}
	
	var result="";
	function totalPrice(trTag, index){
		let qty = trTag.find("input").eq(2).on("change", function(){
			var num1 = trTag.find("td").eq(5).text();  //가격
			var num2 = qty.val();						//수량
			result = num1*num2;
			alert(result);
			trTag.find($("input")).eq(3).val(result);
			
		});
	}

		


//품목 셀렉트박스
//---------------------------------------------------------------------------------
	
	var optionPtrn = "<option value='%V' %S>%T</option>";
	var lpord_noTag = $("#selectLprod_no").data("success", function(resp) {
		var html = "";
		$.each(resp, function(idx, estimate) {
			html += optionPtrn.replace("%V", estimate.lprod_no)
								.replace("%T", estimate.lprod_name);
		});
			lpord_noTag.append(html);
			
	}).on("change", function() {
	
		let lprod_no = $(this).val();

		prod_noTag.trigger("renew", {
			lprod_no : lprod_no
		});

	});
	
 	var prod_no="";
	var prod_noTag = $("#selectProd_no").data("success", function(resp) {
		var html = "<option value>상품명</option>";
		$.each(resp, function(idx, estimate) {
			html += optionPtrn.replace("%V", estimate.prod_no)
							.replace("%T", estimate.prod_name)
							.replace("%S", estimate.prod_no == "{estimate.prod_no}"?"selected":"");
		});
		prod_noTag.html(html);
		
	}).on("change", function(){
		prod_no = $(this).val();
		
		console.log(prod_no)
		
	});		
		var listBody = $("#listBody");
		
			var data1 = null;
			var data2 = $("#selectProd_no").clone();
// 			listBody.html(trTag);

	$(".dynamicElement").dynamicSelect();


	
	
</script>



