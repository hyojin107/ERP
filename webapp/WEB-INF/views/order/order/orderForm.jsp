<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 5      	이제경       	최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>




<br>
<h1>주문서폼</h1>
<br>

<style>  
table { border-collapse:collapse; }  
th, td { border:1px solid gray; }
</style>


<form:form id="orderForm" modelAttribute="order" method="post" enctype="multipart/form-data" class="#"
	action="${cPath }/order/order/${order.or_no }">
	
	<c:if test="${not empty order.or_no }">
		<input type="hidden" name="_method" value="${'delete' eq methodType ?'delete':'put' }">
	</c:if>
	<input class="form-control" type="hidden" name="currentPage" value="${param.currentPage }"/>
	
	<table>
		<tr>
			<th><spring:message code="date" /></th>
			<td><input type="date" name="or_date" value="${shipment.deliveryList[0].order.or_date }"></td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" />
				<input type="button" id="buyerBtn" value="찾기"/>
			</th>
			<td><input type="text" name="buyer_no" id="buyer_no" value="${order.buyer_no }"/>
				<input type="text" id="buyer_name" value="${order.buyer_name }"/></td>
		</tr>
			<tr>
			<th><spring:message code="emp.emp_name" />
				<input type="button" id="empBtn" value="찾기"/>
				
			</th>
			<td><input type="text" name="emp_no" id="empNo" value="${order.emp_no }"/>
				<input type="text" id="empName" value="${order.emp_name }"/></td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_zip" /></th>
			<td><input type="text" name="buyer_zip" value="${order.buyerVO.buyer_zip }"></td>
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_addr" /></th>
			<td><input type="text" name="buyer_addr" value="${order.buyerVO.buyer_addr }"></td>
		</tr>
		<tr>
			<th><spring:message code="order.or_req_date" /></th>
			<td><input type="date" name="or_req_date" value="${order.or_req_date }"></td>
		</tr>
	</table>
	<table >
		<thead>
			<tr>
				<td id="hid">
<!-- 									<div class="searchUI"> -->
						<select class="dynamicElement" id="selectLprod_no"
							data-url="<c:url value='/order/estimate/prod/lprod'/>">
							<option value="">상품분류</option>
						</select> 

						<select class="dynamicElement" id="selectProd_no"
							data-url="<c:url value='/order/estimate/prod/prod'/>">
							<option value="">상품명</option>
						</select>
				</td>	
				<td id="addProd">
					 <input type="button" value="품목추가" onclick="addProd()">
				</td>
			</tr>		
		
		</thead>

		<tbody>
			<tr>
				<td>
				<table id="orderTable">
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
						</tr>
					</thead>
					<tbody id="listBody">
						<c:choose>
							<c:when test="${not empty order }">
								<c:if test="${order.orderList!=null }">
								<c:forEach items="${order.orderList }" var="list">
									<c:if test="${list.prodList!=null }">
									<c:forEach items="${list.prodList }" var="pList">
										<tr>
											<td><input type="checkbox" name="inputChk"></td>
											<td>${pList.prod_no }</td>
											<td>${pList.prod_name }</td>
											<td>${pList.prod_standard }${pList.prod_stand_size }</td>
											<td>${list.orp_qty }</td>
											<td>${pList.prod_out_price }</td>
											<td>${pList.prod_validity }</td>
											<td>${pList.prod_out_price*list.orp_qty }</td>
										</tr>
									</c:forEach>
									</c:if>
								</c:forEach>	
								</c:if>
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
					<input type="button" value="목록으로" onclick="location.href='<c:url value="/order/order"/>'" />
<!-- 				<input type="button" onclick="addRow()" value="행 추가"/> -->
<!-- 				<input type="button" onclick="delRow()" value="행 삭제"/> -->
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

//행추가삭제---------------------------------------------------------------------------------------------
// 	function addRow(){
// 		var tableData = document.getElementById('orderTable');
// 		var row = tableData.insertRow(tableData.rows.length);
		 
// 		$("#orderTable").append("<tr><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td></tr>")
		
// 	}
// 	function delRow(){
// 		var tableData = document.getElementById('orderTable');
		
// 		// jquery 로 테이블 삭제 
// 		if($("#orderTable tr").length < 3)
// 		{
// 			return;
// 		}
// 		$("#orderTable tr:last").remove();
		
// 	}

//품목삭제---------------------------------------------------------------------------------------------

	function delProd(){
		var listBody = document.getElementById('listBody');
		var lastRow = listBody.rows.length;
		alert(lastRow);
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
	
//거래처, 담당자 모달---------------------------------------------------------------------------------------------

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

   
//상품추가---------------------------------------------------------------------------------------------
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
										$("<td>").html($("<input>").attr("type",'text').attr("name","orderList["+index+"].prod_no").val(prod.prod_no)),
										$("<td>").text(prod.prod_name),
										$("<td>").text(prod.prod_standard).attr("name", "prod_standard"),
										$("<td>").html($("<input>").attr("type",'text').attr("name","orderList["+index+"].orp_qty")),
										$("<td>").text(prod.prod_out_price),
// /										$("<td>").text(prod.prod_totalPrice),
										$("<td>").text(prod.prod_validity),
										$("<td>").html($("<input readonly/>").attr({type:"text", name:"orderList["+index+"].orp_price"}))
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

	
//주문금액합계계산
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
	
//상품추가---------------------------------------------------------------------------------------------
		
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
//	 			listBody.html(trTag);

		$(".dynamicElement").dynamicSelect();
   
//---------------------------------------------------------------------------------------------


</script>



