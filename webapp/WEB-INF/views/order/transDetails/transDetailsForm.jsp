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
<h1>거래명세서폼</h1>
<br>

<style>  
table { border-collapse:collapse; }  
th, td { border:1px solid gray; }
</style>


<form:form id="transDForm" modelAttribute="transD" method="post" enctype="multipart/form-data" class="#"
	action="${cPath }/order/transDetails/${transDetails.tran_no }">
	
	<c:if test="${not empty transDetails.tran_no }">
		<input type="hidden" name="_method" value="${'delete' eq methodType ? 'delete':'put' }">
	</c:if>
	
		<input class="form-control" type="hidden" name="currentPage" value="${param.currentPage }"/>
<!-- 		<input type="hidden" name="tran_no"> -->
	<table>
					<tr>
						<th>거래명세서번호</th>
						<td><input type="text" name="tran_no" value="${transDetails.tran_no }"></td>
					</tr>
					<tr>
						<th>작성일자</th>
						<td><input type="date" name="tran_date" value="${transDetails.tran_date }"></td>
					</tr>
					<tr>
						<th>출하일</th>
						<td><input type="date" name="ship_p_date" value="${transDetails.shipment[0].ship_p_date }"></td>
					</tr>
					<tr>
						<th><spring:message code="buyer.buyer_name" />
							<input type="button" id="buyerBtn" value="찾기"/>
						</th>
<%-- 						<td><input type="text" name="buyer_no" id="buyer_no" value="${shipmnet.deliveryList.order.buyer_no }"/> --%>
						
						<td><input type="text" name="buyer_no" id="buyer_no" value="${transDetails.shipment[0].buyer_no }"/>
							<input type="text" id="buyer_name" value="${transDetails.shipment[0].buyer_no }" /></td>
					</tr>
					<tr>
						<th><spring:message code="emp.emp_name" /><input type="button" id="empBtn" value="찾기"/>
						</th>
						<td><input type="text" name="emp_no" id="empNo" value="${transDetails.shipment[0].emp_no }"/>
							<input type="text" id="empName" value="${transDetails.shipment[0].emp_name }"/></td>
<!-- 			<td><input type="button" id="empBtn" value="찾기"/></td> -->
					</tr>
					<tr>
						<th><spring:message code="shipment.ship_no" /></th>
						<td><input type="text" name="ship_no" value="${transDetails.shipment[0].ship_no }"></td>
					</tr>
	</table>
	<table >

		<tbody>
			<tr>
			
			<td>

				
				<table id="tranTable">
					<tr>
						<th>#</th>
						<th><spring:message code="prod_code" /></th>
						<th><spring:message code="prod_name" /></th>
						<th><spring:message code="prod_standard" /></th>
						<th><spring:message code="prod_price" /></th>
						<th><spring:message code="prod_qty" /></th>
						<th><spring:message code="prod_totalprice" /></th>
						<th>부가세</th>
						<th><spring:message code="add_price" /></th>
						<th>총합</th>
					</tr>
					<tr>
					<c:choose>
					<c:when test="${not empty transDetails }">
					<c:if test="${transDetails.prod!=null }">
						<c:forEach items="${transDetails.prod }" var="pList" begin="0" step="1" varStatus="i">
								<tr>
									<td></td>
									<td>${pList.prod_no }</td>
									<td>${pList.prod_name }</td>
									<td>${pList.prod_standard }</td>
									<td>${transDetails.orderList[i.count-1].orp_qty }</td>
									<td>${transDetails.orderList[i.count-1].orp_price}</td>
									<td>${pList.prod_out_price }</td>
									<td><input type="text" id="summary"></td>
								</tr>
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
				<td colspan="1">
					<input type="submit" value="저장">
					<input type="button" value="초기화">
					<input type="button" value="목록으로" onclick="location.href='<c:url value="/order/transDetails/"/>'" />
				</td>
				<td>
				<input type="button" onclick="addRow()" value="행 추가"/>
				<input type="button" onclick="delRow()" value="행 삭제"/>
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

//행추가---------------------------------------------------------------------------------------------
	function addRow(){
		var tableData = document.getElementById('tranTable');
		var row = tableData.insertRow(tableData.rows.length);
		 
		$("#tranTable").append("<tr><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td><td><input type='text'/></td></tr>")
		
	}
	function delRow(){
		var tableData = document.getElementById('tranTable');
		
		// jquery 로 테이블 삭제 
		if($("#tranTable tr").length < 3)
		{
			return;
		}
		$("#tranTable tr:last").remove();
		
	}

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
	//---------------------------------------------------------------------------------------------

</script>



