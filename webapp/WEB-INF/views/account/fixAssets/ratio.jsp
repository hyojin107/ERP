<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>감가상각률표</h1><br>
<div class="d-block d-md-flex align-items-center d-print-none">
<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
	<text>내용연수</text>
	<form id="searchForm" action="${cPath }/account/fixAssets/ratio">
		<input type="text" name='life_year' id='life_year'>
		<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn">
	</form>
</div>
</div>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr class="head">
			<th>내용연수</th>
			<th>정률법</th>
			<th>정액법</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
</table>
<script>
	$.ajax({
		url : $("#searchForm").attr("action"),
		method : "get",
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			let trTags = [];
			if(resp.length>0){
				$.each(resp, function(idx, ratio){
					let trTag = $("<tr>").append(
									$("<td>").text(ratio.life_year)
									, $("<td>").text(ratio.ratio)
									, $("<td>").text(ratio.fix)
								);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='3' class='col'>").text("조건에 맞는 감가상각비가 없음.")));
			}
			$("#listBody").html(trTags);			
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
	$("#searchBtn").on("click", function(){
		$("tr").not(".head").hide();
		let life = $("#life_year").val();
		if(!life) $("tr").show();
		$.each($("tr"), function(idx, tr){
			if($("tr").eq(idx).find("td").eq(0).text() == life) $("tr").eq(idx).show();
		});
	});
</script>