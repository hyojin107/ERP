<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- jQuery -->
<script src="${pageContext.request.contextPath }/resources/plugins/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fontawesome-free/css/all.min.css">
<!-- IonIcons -->
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/adminlte.min.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/bootstrap-4.5.0-dist/js/bootstrap.bundle.min.js"></script>
<!-- 부트스트랩 -->
<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<h1>출고관리</h1>
<!-- : 출하지시서 상세보기: 생산팀에서작성한 출하지시서를 토대로 상품의 갯수가 넉넉하면 바로 출고로 등록하지만 갯수가 넉넉하지 않다면 '생산요청'을 눌러서 '생산요청서'로 이동한다. -->
	<table class="table" border="1">
		<thead id="documentbody">
			<tr>
				<th><spring:message code="delivery.deliv_no"/></th>
				<td>
					${delOrVO.deliv_no }
					<input type="hidden" name="deliv_no" value="${delOrVO.deliv_no }">
				</td>
				<th><spring:message code="writedate"/></th>
				<td>${delOrVO.write_date }</td>
			</tr>
			<tr>
				<th><spring:message code="id"/></th>
				<td>${delOrVO.emp_no }</td>
				<th><spring:message code="name"/></th>
				<td>${delOrVO.emp_name }</td>
			</tr>
			<tr>
				<th><spring:message code="delivery.deliv_schd"/></th>
				<td>${delOrVO.out_date }</td>
			</tr>
			<tr>
				<th>책임자</th>
				<td>
					<input type="number" placeholder="사원코드입력" name="emp_no">
				</td>
				<th>
					<spring:message code="shipment.endday"/>
				</th>
				<td>
					<input type="date" id="currentDay" readonly="readonly" name="prod_out_date">
				</td>
			</tr>
		</thead>
</table>

<div>
	<h3>출하상품 목록</h3>
	<input type="button" id="deliveryBtn" value="출고">
</div>
	<table class="table" border="1">
		<tr>
			<th>
				<spring:message code="prod.prod_name"/>
			</th>
			<th>
				<spring:message code="prod.prod_no"/>
			</th>
			<th>
				<spring:message code="delivery.orp_qty"/>
			</th>
			<th>
				<spring:message code="stock_size"/>
			</th>
			<th>
				<spring:message code="store.store_no"/>
			</th>
			<th>
				<spring:message code="sector.sector_no"/>
			</th>
			<th>
				창고저장수량 
			</th>
			<th>#</th>
		</tr>
		<c:if test="${not empty delOrVO}">
			<c:forEach items="${delOrVO.order }" var="order">
				<c:if test="${not empty order.orderList }">
					<c:forEach items="${order.orderList }" var="orderList">
						<c:if test="${not empty orderList.prodList }">
							<c:forEach items="${orderList.prodList }" var="prodList">
								<tr>
									<td>${prodList.prod_name }</td> 
									<td class="prod_no">${prodList.prod_no }</td>
									<td>
										${orderList.orp_qty }
										<input type="hidden" name="prod_out_qty" value="${orderList.orp_qty }">
									</td>
									<td>${prodList.prod_stock_size }</td>
									<td>
										<select name="prod_store" class="dynamicElement storeSelect"  data-source="${prodList.prod_no }" >
											<option value="">창고선택</option>
											<c:forEach items="${storeList }" var="store">
											<c:forEach items="${store}" var="zz">
												<option value="${zz.store_no }">${zz.store_no }</option>
											</c:forEach>
											</c:forEach>
										</select>
									</td>
									<td>
										<select name="prod_sector" class="dynamicElement sectorSelect" data-target="${prodList.prod_no }" data-url="<c:url value='/ware/lprod/outPSectorList'/>">
										</select>
									</td>
									<td>
										<input type="number" class="prod_cnt" readonly="readonly">
									</td>
									<td>
									<c:choose>
										<c:when test="${prodList.prod_stock gt orderList.orp_qty }">
											<button type="button" id="orderBtn" onclick="opener.location.href='${cPath}/outer/prod/pduct/insert/${prodList.prod_no }'">생산요청</button>
										</c:when>
									</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
			</c:forEach>
		</c:if>
	</table>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">

	//오늘 날짜 뿌려주기 
	$('#currentDay').val(new Date().toISOString().substring(0,10));

	// 상품이 저장된 창고와 창고 구역 불러오기 
	var optionPtrn = "<option value='%V' %S>%T</option>";
	var data_source = "";
	var store_Tag = $(".storeSelect").on("change",function(){
		data_source = $(this).attr("data-source");
		let store_no = $(this).val();
		let prod_no = $(this).parent().parent().find(".prod_no").text();
		
		let zz = $("select[data-target='"+data_source+"']");
		
		zz.trigger("renew",{
			store_no : store_no,
			prod_no : prod_no
		});
	});
	
	var sector_Tag = $(".sectorSelect").data("success", function(resp){
		var html = "<option value=''>구역선택</option>";
		$.each(resp, function(idx,sector){
			html += optionPtrn
						.replace("%V",sector.sector_no)
						.replace("%T",sector.sector_no)
						.replace("%S","data-cnt='"+sector.prod_cnt+"' class='prod_cnt'");
		});
		let sector_Tag_target = $("select[data-target='"+data_source+"']");
		sector_Tag_target.html(html);
	});
	
	$(".sectorSelect").on("change",function(){
		let cnt = $(this).children("option:selected").data("cnt");
		let aa = $(this).parent().parent().find("input[class=prod_cnt]");
		aa.val(cnt);
	});
	
	$(".dynamicElement").dynamicSelect();
	
	// 상품 출고 버튼 누르고 성공 하면 alert 띄우고 새창 닫기 
	// 컨트롤러에서 성공했다는 걸 받아와야한다. 
	$("#deliveryBtn").on("click",function(){
		let emp_no = $("#documentbody").find("input[name='emp_no']").val();
		console.log(emp_no);
		let prod_out_date = $("#documentbody").find("input[name='prod_out_date']").val();		
		console.log(prod_out_date);
		// ajax로 전송 하기 
		// 객체생성 
		// deliveOr(출하지시서 vo, prodList(prodVO))
		var deliveOr = new Object(); // 출하지시서 vo
		deliveOr.deliv_no="${delOrVO.deliv_no}"; // deliv_no : 출하지시서번호
		deliveOr.emp_no=emp_no;
		deliveOr.prod_out_date=prod_out_date; // 출고일자
		deliveOr.or_no="${delOrVO.or_no}"; // 주문서번호
		
		var prodList = new Array(); // prodlist
		
		<c:if test="${not empty delOrVO}">
			<c:forEach items="${delOrVO.order }" var="order">
				<c:if test="${not empty order.orderList }">
					<c:forEach items="${order.orderList }" var="orderList">
						<c:if test="${not empty orderList.prodList }">
							<c:forEach items="${orderList.prodList }" var="prodList">
								var prodVO = new Object(); // prodvo 

								prodVO.prod_no = "${prodList.prod_no}"; //상품 코드 
								prodVO.prod_sector = "${delOrVO.prod_sector}"; // 상품창고구역
								prodVO.prod_out_qty = "${orderList.orp_qty}"; // 출고수량
								prodVO.sector_no = "${prodList.sector_no}"; // sector_no
								
// 								deliveOr.prod_out_qty="${orderList.orp_qty}"; // 출고수량 
// 								deliveOr.prod_sector="${delOrVO.prod_sector}"; // 상품 창고 구역 
// 								deliveOr.sector_no="${prodList.sector_no}"; // 상품창고코드 
// 								deliveOr.prod_no="${prodList.prod_no}";
// 								prodList.push(deliveOr);

								prodList.push(prodVO);
								deliveOr.prodList=prodList; // 객체에 list 담기 
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
			</c:forEach>
		</c:if>
// 	 	console.log(JSON.stringify(prodList));
		console.log(JSON.stringify(deliveOr));
		// JSON.stringify : json문자열로 변환할 값
		$.ajax({
			url : "${cPath}/outer/doc",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify(deliveOr),
			method : "post",
			dataType : "text",
			success : function(resp){
				console.log("resp          "+resp);
				let res = resp;
				if(res="ok"){
					alert("상품 출고완료");
			 		window.close();
				}else{
					alert("상품출고 실패");
				}
		 		
			},
			error : function(errorResp){
				console.log(errorResp.status + ":"+ errorResp.responseText);
			}
		});
	});
	
	// 생산요청 버튼을 누르면 부모창 전환 및 popup종료
	$("#orderBtn").on("click",function(){
		window.close();
	});
	
</script>

























