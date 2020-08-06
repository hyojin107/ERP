<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>출고관리 : 상품 생산의뢰서  작성 폼,생산할 상품의 정보(기본정보 + 사용되는 원자재)불러오고 요청수량 입력후 저장 </h1>
<form:form id="pductForm" modelAttribute="prodVO" action="${cPath }/outer/prod/pduct" method="post">
	<table class="table" id="pduct_table">
		<tr>
			<td>
				<spring:message code="pductor.poroder_no"/>
			</td>
			<td><!-- name="porder_no" -->
				<input type="number" readonly="readonly" placeholder="자동생성">
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="writedate"/>
			</td>
			<td>
				<input type="date" name="porder_date" id="currentDay" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="writer"/>
			</td>
			<td><!-- 사원의 emp_no 불러오기 , readonly -->
				<input type="text" name="emp_no">
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="pductlist.pduct_no"/>
			</td>
			<td> <!-- name="pduct_no" , name="prod_no" class="addName"-->
				<input type="text" id="prod_no" value="${prodVO.prod_no }" readonly="readonly" >
				<input type="hidden" id="pduct_no" value="1" />
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="prod.prod_name"/>
			</td>
			<td>
				<input type="text" name="prod_name" value="${prodVO.prod_name }" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td>
				<spring:message code="pductlist.pduct_cnt"/>
			</td>
			<td> <!-- name="pduct_cnt" -->
				<input type="number" id="pduct_cnt"/>
			</td>
		</tr>
		<tr>
			<td>BOM</td>
			<td>
				<table id="matTable">
				<thead class="table-info">
					<tr>
						<th>
							<spring:message code="bom.mat_no"/>
						</th>
						<th>
							<spring:message code="mat.mat_name"/>
						</th>
						<th>
							<spring:message code="bom.mat_number"/>
						</th>
						<th>
							<spring:message code="bom.mat_size"/>
						</th>
						<th>창고</th>
						<th>창고구역</th>
						<th>창고에 남은 수량</th>
						<th>원자재 사용 수량</th>
					</tr>
				</thead>
					<tr>
						<c:choose>
							<c:when test="${not empty prodVO.bomlist and not empty prodVO.bomlist.get(0).getMat_no()}">
								<c:forEach items="${prodVO.bomlist }" var="bom">
									<tr>
										<!--  name="pductList[0].mat_no"  -->
										<td class="mat_no">${bom.mat_no}<input type="hidden" value="${bom.mat_no}" class="inputhidden"/></td>
										<td>${bom.matVO.mat_name }</td>
										<td class="mat_number">${bom.mat_number }</td>
										<td>${bom.mat_size }</td>
										<td> <!-- name="store_no" name="pductList[0].matoutList[0].store_no -->
											<select  class="dynamicElement sel_${bom.mat_no } firstSel" data-source="${bom.mat_no }">
												<option value="">창고 선택</option>
												<c:forEach items="${storeList }" var="store">
													<option value="${store.store_no }">${store.store_name }</option>
												</c:forEach>
											</select>
										</td>
										<td><!--  name="sector_no"  -->
											<select class="dynamicElement sel_${bom.mat_no } secondSel" data-target="${bom.mat_no }" data-url="<c:url value='/ware/lprod/outSectorList'/>">
											</select>
										</td>
										<td><!--  name="mat_cnt" -->
											<input type="number" class="sel_${bom.mat_no } thirdSel" readonly="readonly">
										</td>
										<td>
											<input type="number" class="resultCnt" readonly="readonly">
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th></th>
									<th colspan="3">BOM 정보 없음</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="저장"/>
				<input type="reset" class="btn btn-secondary" value="다시쓰기"/>
				<input type="button"  class="btn btn-info" value="뒤로가기" onclick="history.back();"/>
				<input type="button" class="btn btn-primary" value="목록으로 " onclick="location.href='${pageContext.request.contextPath}/outer/prod/pduct/list';"/>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">

	// 오늘 날짜 뿌려주기 
	document.getElementById('currentDay').value = new Date().toISOString().substring(0,10);
	
	//========================== form으로 전송되는 name값 정해주기 
// 	$("#pduct_no").attr("name","pductList[0].pduct_no");
	$("#prod_no").attr("name","pductList[0].prod_no");
	$("#pduct_cnt").attr("name","pductList[0].pduct_cnt");

	$(".mat_no").each(function(idx,item){
		$(this).parent().find(".inputhidden").attr("name",'pductList[0].matOutList['+idx+'].mat_no');
	});
	$(".thirdSel").each(function(idx,item){
		$(this).attr("name",'pductList[0].matOutList['+idx+'].mat_cnt');
	});
	$("#pduct_no").each(function(idx,item){
		$(this).attr("name",'pductList[0].matOutList['+idx+'].pduct_no');
	});
	
// 	var selectClz = $("select").attr("class");
// 	var ClzSize = selectClz.indexOf('first');
// 	selectClz = selectClz.substr(ClzSize);
	$(".firstSel").each(function(idx){
		$(this).attr("name",'pductList[0].matOutList['+idx+'].store_no');
	});
	$(".secondSel").each(function(idx){
		$(this).attr("name",'pductList[0].matOutList['+idx+'].sector_no');
	});
	
	//========================== 원자재가 저장된 창고와 창고구역 불러오기
		
	// bom 목록에 출력된 원자재가 저장된 창고가 select 박스에 출력된다. 
	// 창고를 선택하면 해당창고에 등록된 창고구역을 셀렉트박스로 선택할 수 있다. 
	var optionPtrn = "<option value='%V' %S>%T</option>";
	var data_source ="";
// 	var xx = "";
	
// 	var store_Tag = $("select[name='store_no']").on("change",function(){
	var store_Tag = $(".firstSel").on("change",function(){
		data_source= $(this).attr("data-source");
		let store_no = $(this).val();
		let mat_no = $(this).parent().parent().find(".mat_no").text();
		
// 		xx =$(this).attr("class"); // 현재 선택된 select의 class를 담는다. 
// 		var yy = xx.indexOf('sel_'); // 'sel_' 만큼의 길이를 가져온다.  
// 		xx = xx.substr(yy); // 가져온길이로 substr 하여 sel_mat_no 만 가져온다.

		let zz = $("select[data-target='"+data_source+"']"); // select box중 data-target의 data-source를 받아서 trigger를 실행시킨다. 
		zz.trigger("renew",{
			store_no : store_no,
			mat_no : mat_no
		});
	});
	
// 	var sector_Tag = $("select[name='sector_no']").data("success",function(resp){		
	var sector_Tag = $(".secondSel").data("success",function(resp){		
		var html = "<option value>구역선택</option>";
		$.each(resp, function(idx, sector){
			html += optionPtrn
					.replace("%V",sector.sector_no)
					.replace("%T", sector.sector_no)
					.replace("%S", "data-cnt='"+sector.mat_cnt+"' class='mat_cnt'");
		});
		let sector_Tag_target=$("select[data-target='"+data_source+"']"); // 해당 data_source를 가지고 있는 select box 만 값을 바꾼다.
		sector_Tag_target.html(html);
	});	
	
	$(".dynamicElement").dynamicSelect();
	
	// 해당 창고구역에 남은 수량 input에 뿌려주기
// 	$("select[name='sector_no']").on("change",function(){
	$(".secondSel").on("change",function(){
		let cnt = $(this).children("option:selected").data("cnt");
// 		let ww = $(this).parent().parent().find("input[name=mat_cnt]");
		let ww = $(this).parent().parent().find(".thirdSel");
		ww.val(cnt);
	});
	
	// 생산수량을 입력하면 생산수량 * bom의 원자재 수량을 곱해서 input 박스에 나오도로한다. 
	var result = "";
	let qty = $("#pduct_cnt").on("change",function(){
			let num = $(this).val();
			// 반복문을 돌면서.. mat_number를 class로 가지고 있는 곳에 곱해준 값에 넣어준다. 
			$("#matTable tr .mat_number").each(function(idx){
				let num1 = $(this).text();
				$(".resultCnt").eq(idx).val(num*num1);
			});
	});
	
</script>
