<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 16      	이제경       	최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>




<br>
<h1>출하 폼</h1>
<br>

<style>  
table { border-collapse:collapse; }  
th, td { border:1px solid gray; }
</style>


<form:form id="shipmentForm" modelAttribute="shipment" method="post" enctype="multipart/form-data" class="#"
	action="${cPath }/order/shipment/${shipment.ship_no }">
		<input type="hidden" name="ship_no" value="${shipment.ship_no }">
	
	<c:if test="${not empty shipment.deliv_no }">
		<input type="hidden" name="_method" value="${'delete' eq methodType ?'delete':'put' }">
	</c:if>
	
	<input class="form-control" type="hidden" name="currentPage" value="${param.currentPage }"/>
	
	<table>
		<tr>
			<th><spring:message code="delivery.deliv_no" /></th>
			<td><input type="text" name="deliv_no" value="${shipment.deliveryList[0].deliv_no }"></td>
		</tr>
		<tr>
			<th>출고요청일</th>
			<td><input type="date" name="deliv_schd" value="${shipment.deliveryList[0].deliv_schd }"></td>
		</tr>
		<tr>
			<th>작성일자</th>
			<td><input type="date" name="ship_date" value="${shipmnet.ship_date }"></td>
		</tr>
<!-- 					<tr> -->
<%-- 						<th><spring:message code="shipment.ship_no" /></th> --%>
<%-- 						<td><input type="text" name="deliv_no" value="${shipment.ship_no }"></td> --%>
<!-- 					</tr> -->
		<tr>
			<th><spring:message code="emp.emp_name" /><input type="button" id="empBtn" value="찾기"/>
			</th>
			<td><input type="text" name="emp_no" id="empNo" value="${shipment.deliveryList[0].emp_no }"/>
				<input type="text" id="empName" value="${shipment.deliveryList[0].emp_name }"/></td>
<!-- 			<td><input type="button" id="empBtn" value="찾기"/></td> -->
		</tr>
		<tr>
			<th><spring:message code="buyer.buyer_name" />
				<input type="button" id="buyerBtn" value="찾기"/>
			</th>
<%-- 						<td><input type="text" name="buyer_no" id="buyer_no" value="${shipmnet.deliveryList.order.buyer_no }"/> --%>
			
			<td><input type="text" name="buyer_no" id="buyer_no" value="${shipment.buyer_no }"/>
				<input type="text" id="buyer_name" value="${shipment.buyer_name }" /></td>
		</tr>
		<tr>
			<th>출하일</th>
			<td><input type="date" name="ship_p_date" value="${shipment.ship_p_date }"></td>
		</tr>
<!-- 		<tr> -->
<%-- 			<th><spring:message code="status" /></th> --%>
<%-- 			<td><input type="" name="ship_prog" value="${shipmnet.ship_prog }"></td> --%>
<!-- 		</tr> -->
		<tr>
			<th><spring:message code="buyer.charger_name" /></th>
			<td><input type="text" value="${shipment.buyerVO.charger_name }" readonly="readonly"></td>
<%-- 			<td><input type="text" name="charger_name" value="${shipment.buyerVO.buyer_addr1 } ${shipment.buyerVO.buyer_addr2 }"></td> --%>
		</tr>
	</table>
	
	<table>

		<tbody>
			<tr>
				<td>
					<table id="shipmentTable">
						<tr>
							<th><spring:message code="prod_code" /></th>
							<th><spring:message code="prod_name" /></th>
							<th><spring:message code="prod_standard" /></th>
							<th><spring:message code="prod_qty" /></th>
							<th><spring:message code="summary" /></th>
						</tr>
						<tr>
							<c:choose>
							<c:when test="${not empty shipment }">
								<c:if test="${shipment.deliveryList!=null }">
								<c:forEach items="${shipment.deliveryList }" var="delivery">
									<c:if test="${delivery!=null }">
									<c:forEach items="${delivery.order }" var="order">
										<c:if test="${order!=null }">
										<c:forEach items="${order.orderList }" var="list">
											<c:if test="${list.prodList!=null }">
											<c:forEach items="${list.prodList }" var="pList">
												<tr>
													<td>${pList.prod_no }</td>
													<td>${pList.prod_name }</td>
													<td>${pList.prod_standard }</td>
													<td>${list.orp_qty }</td>
													<td><input type="text" id="summary"></td>
												</tr>
											</c:forEach>
											</c:if>
										</c:forEach>
										</c:if>
									</c:forEach>
									</c:if>
								</c:forEach>
								</c:if>
							</c:when>
							</c:choose>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5">
					<input type="submit" value="저장">
					<input type="button" value="초기화">
					<input type="button" value="목록으로" onclick="location.href='<c:url value="/order/shipment"/>'" />
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


//모달---------------------------------------------------------------------------------------------
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
//모달---------------------------------------------------------------------------------------------



</script>



