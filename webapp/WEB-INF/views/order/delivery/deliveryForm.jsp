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
<h1>출하지시서 폼</h1>
<br>

<style>  
table { border-collapse:collapse; }  
th, td { border:1px solid gray; }
</style>


<form:form id="deliveryForm" modelAttribute="delivery" method="post" enctype="multipart/form-data" class="#"
	action="${cPath }/order/delivery/${delivery.deliv_no }">
	
	<c:if test="${not empty delivery.deliv_no }">
		<input type="hidden" name="_method" value="${'delete' eq methodType ?'delete':'put' }">
	</c:if>
	
<%-- 	<c:if test="${empty order.or_no }"> --%>
		
<%-- 	</c:if> --%>
	
	<input class="form-control" type="hidden" name="currentPage" value="${param.currentPage }"/>
<!-- 	<input type="hidden" name="deliv_no"> -->
	
	<table>
		<tr>
			<th><spring:message code="delivery.deliv_no" /></th>
			<td><input type="text" value="${delivery.deliv_no }"></td>
		</tr>
		<tr>	
			<th><spring:message code="order.or_no" /></th>
			<td>
				<input type="text" name="or_no" value="${delivery.order[0].or_no }">
				
<!-- 				<input type="button" id="orderBtn" value="주문서검색"> -->
			</td>
		</tr>
		<tr>
			<th><spring:message code="date" /></th>
			<td><input type="date" name="deliv_date" value="${delivery.deliv_date }"></td>
		</tr>
		<tr>
			<th><spring:message code="emp.emp_name" />
			</th>
			<td><input type="text" name="emp_no" id="empNo" value="${delivery.order[0].emp_no }"/>
				<input type="text" id="empName" value="${delivery.order[0].emp_name }"/></td>
			<td><input type="button" id="empBtn" value="찾기"/></td>
		</tr>
		
<!-- 		<tr> -->
<%-- 			<th><spring:message code="buyer.buyer_name" /></th> --%>
<%-- 			<td><input type="text" name="est_buyer" value="${delivery.deliv }"></td> --%>
<!-- 		</tr> -->
		<tr>
			<th><spring:message code="delivery.deliv_schd" /></th>
			<td><input type="date" name="deliv_schd" value="${delivery.deliv_schd }"></td>
		</tr>
		<!-- 작성일자 당일 날자로 넣기 -->
<!-- 		<tr> -->
<%-- 			<th><spring:message code="writedate" /></th> --%>
<%-- 			<td><input type="date" name="deliv_date" value="${delivery.deliv_date }"></td> --%>
<!-- 		</tr> -->
<!-- 		<TR> -->
<!-- 			<TH><SPRING:MESSAGE CODE="BUYER.BUYER_ZIP" /></TH> -->
<!-- 			<TD><INPUT TYPE="TEXT" NAME="BUYER_ZIP"></TD> -->
<!-- 		</TR> -->
<!-- 		<TR> -->
<!-- 			<TH><SPRING:MESSAGE CODE="BUYER.BUYER_ADDR" /></TH> -->
<!-- 			<TD><INPUT TYPE="TEXT" NAME="BUYER_ADDR"></TD> -->
<!-- 		</TR> -->
<!-- 		<tr> -->
<%-- 			<th><spring:message code="order.or_req_date" /></th> --%>
<!-- 			<td><input type="date" name="or_req_date"></td> -->
<!-- 		</tr> -->
	</table>
	
	<table >
		<tbody>
			<tr>
				<td>
				<table id="delivTable">
					<tr>
						<th>#</th>
						<th><spring:message code="prod_code" /></th>
						<th><spring:message code="prod_name" /></th>
						<th><spring:message code="prod_standard" /></th>
						<th><spring:message code="prod_qty" /></th>
						
					</tr>
					<tr>
						<c:choose>
						<c:when test="${not empty delivery }">
<%-- 						<c:if test="${delivery!=null }"> --%>
						<c:if test="${delivery.order!=null }">
						<c:forEach items="${delivery.order }" var="order">
							<c:if test="${order.orderList!=null }">
							<c:forEach items="${order.orderList }" var="oList">
								<c:if test="${oList.prodList!=null }">
								<c:forEach items="${oList.prodList }" var="pList">
									<tr>
										<td>#</td>
										<td>${pList.prod_no }</td>
										<td>${pList.prod_name }</td>
										<td>${pList.prod_standard }${pList.prod_stand_size }</td>
										<td>${oList.orp_qty }</td>
									</tr>
								</c:forEach>
								</c:if>
							</c:forEach>
							</c:if>
						</c:forEach>
						</c:if>
<%-- 						</c:if>	 --%>
						</c:when>		
						</c:choose>
					</tr>
				</table>
			</td>
		</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<input type="submit" value="저장">
					<input type="button" value="초기화">
					<input type="button" value="목록으로" onclick="location.href='<c:url value="/order/delivery"/>'" />
<!-- 				<input type="button" onclick="addRow()" value="행 추가"/> -->
<!-- 				<input type="button" onclick="delRow()" value="행 삭제"/> -->
				</td>
			</tr>
		</tfoot>
	</table>
	
</form:form>

<!-- 담당자 모달창 -->
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

//탭버튼---------------------------------------------------------------------------------------------
// 	function addRow(){

// 		var tableData = document.getElementById('delivTable');
// 		var row = tableData.insertRow(tableData.rows.length);

// 		var tableData = document.getElementById('delivTable');
// 		var row = tableData.insertRow(tableData.rows.length);

		 
// 		$("#delivTable").append("<tr><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td>")
		
// 	}
// 	function delRow(){
		
// 		// jquery 로 테이블 삭제 
// 		if($("#delivTable tr").length < 3)
// 		{
// 			return;
// 		}
// 		$("#delivTable tr:last").remove();
		
// 	}

//담당자모달창---------------------------------------------------------------------------------------------
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

//상품붙이기---------------------------------------------------------------------------------------------
// 	function addProd(){
// 				$.ajax({
// 					type:"get",
// 					url:"${cPath}/order/estimate/prod/"+order.orderList.prodList.prod_no
// 				}).done(function(resp){
// 						let prod = resp;
// 						var trTags = [];
// 								trTag = $("<tr>").append(
// // 										$("<td>").html($("<input>").attr({type:"checkbox", name:"inputChk"})),
// 										$("<td>").html($("<input readonly>").attr("type",'text').attr("name","orderList["+index+"].prod_no").val(prod.prod_no)),
// 										$("<td>").text(prod.prod_name),
// 										$("<td>").text(prod.prod_standard).attr("name", "prod_standard"),
// 										$("<td>").html($("<input>").attr("type",'text').attr("name","orderList["+index+"].orp_qty").val(orderList.orp_qty)),
// // 										$("<td>").text(prod.prod_out_price),
// // // /										$("<td>").text(prod.prod_totalPrice),
// // 										$("<td>").text(prod.prod_validity),
// 										$("<td>").html($("<input readonly/>").attr({type:"text", name:"orderlist["+index+"].orp_price"}))
// 										.data("prod_no", prod.prod_no));
// 							totalPrice(trTag, index);
// 								index++;
// 							$("#listBody").append(trTag);
	
// 							$(select).prop("select[name=prod_no]",0);
// 							$(select).prop("select[name=lprod_no]",0);
// 				});
// 	}

</script>



