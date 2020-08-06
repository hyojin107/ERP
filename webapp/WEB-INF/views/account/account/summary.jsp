<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>적요관리</h1><br>
<a href="${cPath }/account/basic/account"><button class="btn btn-success mr-2" ><spring:message code='account'/></button></a>
<a href="${cPath }/account/basic/account/summary"><button class="btn btn-success mr-2" ><spring:message code='summary'/></button></a>
<form action="${cPath }/account/basic/account/summary">
	<div class="d-block d-md-flex align-items-center d-print-none">
		<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
			<table>
				<tr>
					<th>적요코드</th>
					<th>적요</th>
				</tr>
				<tr>
					<td><input type="text" class="form-control mr-2" name='summary_no' readonly="readonly">
					</td>
					<td>
						<input type="text" class="form-control mr-2" name="summary">
						</td>
					</tr>
				</table>
			<input class="btn btn-success mr-2" type="button"
			value='등록' id="insertBtn">
			<input class="btn btn-success mr-2" type="button"
			value='삭제' id="deleteBtn">
		</div>
	</div>
</form>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>#</th>
			<th>적요코드</th>
			<th>적요</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
</table>
<script type="text/javascript">
var listBody = $("#listBody");
var page = function(summary){
	$.ajax({
		url : "${cPath}/account/basic/account/summary",
		method : "get",
		data : {
			summary : summary
		},
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			let trTags = [];
			if(resp.length>0){
				$.each(resp, function(idx, summary){
					let trTag = $("<tr>").append(
									$("<td>").text(idx+1)
									, $("<td>").text(summary.summary_no)
									, $("<td>").text(summary.summary)
									);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='3'>").text("등록된 적요가 없습니다.")));
			}
			listBody.html(trTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
}
page();

var input_no = $("input").eq(0);
var input_word = $("input").eq(1);
var insertBtn = $("#insertBtn");
$("#insertBtn").on("click", function(){
	if($(this).val()=="새적요입력"){
		input_no.val("");
		input_word.val("");
		insertBtn.val("등록");
		return false;
	}else{
		$.ajax({
			url : "${cPath}/account/basic/account/summary",
			data : {
				summary : $("input").eq(1).val()
			},
			method : "post",
			dataType : "text", // Accept:application/json, Content-Type:application/json
			success : function(resp) {
				if(resp=='success') alert('적요 등록 성공');
				input_word.val("");
				page();
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
});
$("#deleteBtn").on("click", function(){
	if($("input").eq(0).val()=="") return false;
	var no = $("input").eq(0).val();
	$.ajax({
		url : "${cPath}/account/basic/account/summary",
		data : {
			_method : "delete",
			summary_no : no 
		},
		method : "post",
		dataType : "text", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			if(resp=='success') alert('적요 삭제 성공');
			input_no.val("");
			input_word.val("");
			insertBtn.val("등록");
			page();
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
});
$("#listBody").on("click", "tr", function(){
	let summary_no = $(this).find("td").eq(1).text();
	let summary = $(this).find("td").eq(2).text();
	input_no.val(summary_no);
	input_word.val(summary);
}).css({cursor:"pointer"});

$("input[name='summary_no']").on("input", function(){
	if($(this).val()!=""){
		insertBtn.val("새적요입력");
	}else{
		$("#insertBtn").val("등록");
	}
});

(function ($) {
    var originalVal = $.fn.val;
    $.fn.val = function (value) {
        var res = originalVal.apply(this, arguments);
 
        if (this.is('input:text') && arguments.length >= 1) {
            // this is input type=text setter
            this.trigger("input");
        }
 
        return res;
    };
})(jQuery);


</script>