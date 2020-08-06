<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<h1>전표입력</h1>
<form:form id="chitForm" modelAttribute="chit"  method="post" class="w-100"
	action="${pageContext.request.contextPath }/account/chit">
	
	<table class="table table-bordered">
		<tr>
			<th>전표일자</th>
			<td colspan='8' id='date'>
			<div class="form-inline">
			<input type="date" name="chit_date" class="form-control" required="required"
				 value="${chit.chit_date }">
			<form:errors path="chit_date" element="span" cssClass="error" />
			</div>
			</td>
		</tr>
		<tr>
			<th>매입/매출</th>
			<td colspan='8'>
			<div class="form-inline">
				 <select class="dynamicElement form-control mr-2" name="buy_sell" required>
					<option value>매입/매출</option>
					<option ${'매입' eq chit.buy_sell?"selected":"" }>매입</option>
					<option ${'매출' eq chit.buy_sell?"selected":"" }>매출</option>
				</select>
			<form:errors path="buy_sell" element="span" cssClass="error" />
			</div>
			</td>
		</tr>
		<tr>
			<th>거래처</th>
			<td colspan='8'>
			<div class="form-inline">
			  	<input type="hidden" name="buyer_no" value="${chit.buyer_no }" id="buyer_no" required> 
			<div class="form-inline">
				<input type="text" name="buyer_name" class="form-control col" id="buyer_name" required readonly="readonly"
					 value="${chit.buyer_name }">
			</div>
					 			<div class="form-inline">
				 <input type="button" id="buyerBtn" value="찾기" class="form-control btn"/>
			</div>
			<form:errors path="buyer_no" element="span" cssClass="error" />
			</div>
			</td>
		</tr>
		<tr>
			<th colspan='9'>품목 리스트
			 <input type="button" class="btn btn-light" value="품목추가" id="add"/></th>
		</tr>
		<tbody id="list">
			<tr>
				<th>품목</th>
				<th>단가</th>
				<th>수량</th>
				<th>적요</th>
			</tr>
			<c:choose>
			<c:when test="${chit.chitList !=null }">
			<c:forEach items="${chit.chitList }" var="list">
			<tr id="prod">
				<td>
				<div class="form-inline">
					<input type="text" name='product' class="form-control" value="${chit.chitList.product }">
				</div>
				<td>
				<div class="form-inline">
					<input type="number" name='price' class="form-control" value="${chit.chitList.price }">
				</div>
				<td>
				<div class="form-inline">
					<input type="number" name='qty' class="form-control" value="${chit.chitList.qty }">
				</div>
				<td>
				<div class="form-inline">
					<input type="text" name='summary' class="form-control" value="${chit.chitList.summary }">
				</div>
				</td>
			</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<tr id="prod">
				<td>
				<div class="form-inline">
					<input type="text" name='product' class="form-control" value="${chit.chitList.product }">
				</div>
				<td>
				<div class="form-inline">
					<input type="number" name='price' class="form-control" value="${chit.chitList.price }">
				</div>
				<td>
				<div class="form-inline">
					<input type="number" name='qty' class="form-control" value="${chit.chitList.qty }">
				</div>
				<td>
				<div class="form-inline">
					<input type="text" name='summary' class="form-control" value="${chit.chitList.summary }">
				</div>
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
		<tr>
			<th>총액</th>
			<td colspan='8'>
			<div class="form-inline">
			<input type="text" id="pay" class="form-control" readonly="readonly"
				 value="${chit.pay }">
			<form:errors path="pay" element="span" cssClass="error" />
			</div>
			</td>
		</tr>
		<tr>
			<th>부서</th>
			<td colspan='8'>
			<div class="form-inline">
			<select
				class="dynamicElement form-control form-inline" name="dep_no2"
				data-url="${cPath }/emp/manage/departmentList/">
					<option value="">부서명</option>
			</select>
			<select
				class="dynamicElement form-control form-inline" name="dep_no"
				data-url="${cPath }/emp/manage/TeamList" required>
					<option value="">소속 팀</option>
			</select>
				<form:errors path="dep_no" element="span" cssClass="error" />
			</div>
			</td>
		</tr>
		<tr>
			<td colspan="9">
				<input type="submit" class="btn btn-success" value="저장" />
				<input type="button" class="btn btn-secondary" value="다시작성" />
				<input type="button" class="btn btn-primary" value="목록으로" 
					onclick="location='${cPath}/account/chit'"
				/>
			</td>
		</tr>
	</table>
</form:form>

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
<script type="text/javascript" src="${cPath}/resources/js/paging.js?time=${System.currentTimeMillis() }"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
	var addtag = $("#prod").clone().append("<td><input class='btn btn-success mr-2' type='button' value='-'></td>");
	$("#add").on("click",function(){
		$("#list").append(addtag);
		addtag = addtag.clone();
	});
	
	$("#list").on("click","input[type='button']",function(e) {
		$(this).parent().parent().remove();
	});
	$("#list").on("propertychange change keyup paste input","input",function(e){
		var result = 0;
		var list = $("#list");
		$.each(list.find("input[name='price']"),function(idx, item){
			result += $(item).val()*list.find("input[name='qty']")[idx].value;	
		});
		$("#pay").val(result);
	});

	var chitForm = $("#chitForm");
	
	chitForm.on("submit", function(event){
		var list = $("#list");
		var chk = false;
		$.each(list.find("input[name='price']"),function(idx, item){
			if($(item).val()!='' || list.find("input[name='qty']")[idx].value !='' || list.find("input[name='product']")[idx].value !='')
				if($(item).val()==''||$(item).val()==0 || list.find("input[name='qty']")[idx].value ==''||
						list.find("input[name='qty']")[idx].value ==0 || list.find("input[name='product']")[idx].value ==''){
					chk = true;
					return;
				}
		});
		if(chk){
			event.preventDefault();
			alert("품목을 확인해 주세요.");
			return false;
		}
	});
	
	$(".delBtn").on("click", function(){
		let att_no = $(this).data("attno");
		chitForm.append(
			$("<input>").attr({
				type:"text"
				, name:"deleteAttatches"
				, value:att_no
			})	
		);
		$(this).parent("span:first").remove();		
	});
	$(".btn-secondary").on("click", function(){
		$("input").not(".btn").val("");
	});
	
	var exampleModal = $("#exampleModal").modal({
	    show:false
	 }).on("hidden.bs.modal", function(){
	    exampleModal.find(".modal-body").empty();
	 });
	
	modalView({
		  noText : "#buyer_no",      //사원 클릭 시, 입력될 태그 지정
		  nameText : "#buyer_name",  //사원 클릭 시, 입력될 태그 지정
		  clickBtn : "#buyerBtn",         //모달창을 띄울 버튼 지정
		   urlPath : "${cPath}/buy/document/buyerModal",
		   title:"거래처 목록"            //제목
		});
	
	$("#chitForm").on("submit", function(event){
		if($("#buyer_no").val()=="") {
			alert("거래처를 입력하세요");
			return false;
		}
	});
	
	var optionPtrn = "<option value='%V' %S>%T</option>";

	var departmentCode = $("select[name='dep_no2']").data(
			// 부서코드
			"success",
			function(resp) { // 콘트롤러의 리턴 값  departmentList가 resp에 담기는거 
				var html = "";
				$.each(resp, function(idx, dep) {

					html += optionPtrn.replace("%V", dep.DEP_NO).replace("%T",
							dep.DEP_NAME)

				});
				departmentCode.append(html);
			}).on("change", function() { // 부서 선택 마다 소속팀이 바뀌는거 
		let dep_no = $(this).val();

		dep_no2.trigger("renew", {
			dep_no2 : dep_no
		// 키 : 값  dep_no2에 dep_no 를 넣어주는거  
		});
	});

	var dep_no2 = $("select[name='dep_no']").data(
			// 소속 팀
			"success",
			function(resp) {
				var html = "<option value>소속팀</option>";
				$.each(resp, function(idx, dep) {
					html += optionPtrn.replace("%V", dep.dep_no).replace("%T",
							dep.dep_name)
				});
				dep_no2.html(html)
			});

	$(".dynamicElement").dynamicSelect();
</script>