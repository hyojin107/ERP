<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    
    <%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2020. 7. 6      작성자명 박정민
      최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<!DOCTYPE html>
<html>

생산보고서 작성

<form id = "Pform" action="${cPath }/report" method="post">
<table class="table table-striped" >
		<tbody><tr >
			<td>생산의뢰번호</td>
			<td>
				<input type="text" name="porder_no" data-toggle = "modal" class = "clickpop"  data-target = "#viewModal" data-remote="${cPath }/report/list" >
			</td>
		</tr>
		<tr >
			<td>상품코드</td>
			<td>
				<input type="text" name="prod_no" class = "Agroup" >
				
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<input type="number" name="emp_name" class = "Agroup" >
				<input type="hidden" name="emp_no" value = "2020070901">
			</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>
				<input type="date" name="rep_date" > 
			</td>

		</tr>
		<tr>
			<td>수량</td>
			<td>
				<input type="number" name="pduct_cnt" class = "Agroup"> 
				
			</td>
		</tr>
		<tr>
			<td>폐기수량</td>
			<td> 
				<input type="number" name="pduct_discnt">
				
			</td>
		</tr>
		
	
		<tr>
			<td colspan="2">
				<input type="submit" value="저장">
				<input type="reset" value="다시쓰기">
				<input type="button" value="뒤로가기" onclick="history.back();">
				<input type="button" value="목록으로 " onclick="location.href='/ERP/product';">
			</td>
		</tr>
	</tbody></table>
</form>

<div class="modal fade " id="viewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl"  role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">생산보고서 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id = "modalbody">
      
      </div>
      <div class="modal-footer">
      
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="OrderFirm(event)">의뢰확정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<c:if test="${not empty message}">

 <div class="alert alert-success alert-dismissible fade show">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Success!</strong> ${message }
  </div>

</c:if>
<c:if test="${not empty Failmessage}">

<div class="alert alert-light alert-dismissible fade show">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Fail!</strong> ${Failmessage }
  </div>
</c:if>


<script type="text/javascript">


 
$('.clickpop').on("click", function() {
	var modal = $(this);
	var modalbody = $(".modal-body")
	
	modalbody.load(modal.data("remote"));

}).css({
		cursor:"pointer"
	});

function inputdisable(type){
	$("#Pform").find("input.Agroup").attr("disabled",type)
}
inputdisable(true)


$(document).on("click",".order",function(){


	var child = $(this).children()
	
	let porder_no = $(child[0]).text().trim()
	let prod_no = $(child[2]).data("name")
	let pduct_cnt = parseInt($(child[4]).text())
	
	$("input[name = porder_no]").val(porder_no)
	$("input[name = prod_no]").val(prod_no)
	$("input[name = pduct_cnt]").val(pduct_cnt)
	
// 	$.each(child,function(idx,order){
		
// 		console.log($(order).text() )
		
// 	})
})
	
	
	


</script>

