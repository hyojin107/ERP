<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>손익계산서</h1><br>
<table>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<text>기준</text>
					<select name="standard" id="standard" class="form-control mr-2">
						<option value>년도</option>
					</select>
					<text>비교</text>
					<select name="compare" id="compare" class="form-control mr-2">
						<option value>년도</option>
					</select>
					<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn" onclick="page();">
				</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr style="text-align:center">
			<th>재무제표표시명</th>
			<th colspan='2' id="standardth">기준</th>
			<th colspan='2' id="compareth">비교</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
</table>
<form id="searchForm" action="${cPath }/account/plusMinus">
	<input type="hidden" name="base_year" value="${param.base_year }"/>
	<input type="hidden" name="compare_year" value="${param.compare_year }"/>
</form>

<script>
for(var i = new Date().getFullYear(); i >= ${year}; i--){
	$("#standard").append($("<option>").text(i).val(i));
	$("#compare").append($("<option>").text(i).val(i));
}
function page(){
	var standard = $("#standard").val();
	var compare = $("#compare").val();
	if(standard) $("#standardth").text("기준 (" + standard + "년)");
	else $("#standardth").text("기준 (" + new Date().getFullYear() + "년)");
	if(compare) $("#compareth").text("비교 (" + compare + "년)");
	else $("#compareth").text("비교 (" + (new Date().getFullYear() - 1) + "년)");
	$.ajax({
		url : "${cPath}${currentPage}",
		data : {
			standard:standard,
			compare:compare
		},
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			let result = resp;
			let division = "";
			let standard_name = "";
			let standardsum = 0;
			let comparesum = 0;
			let standardsumsum = 0;
			let comparesumsum = 0;
			let standardtotal = 0;
			let comparetotal = 0;
			let sumtag = [];
			let trTags = [];
			let trTag = null;
			let standardTd = null;
			let compareTd = null;
			var cnt = 0;
			$.each(result,function(idx, list){
					if(division!=list.division){
						division = list.division;
						if(idx != 0){
							$(standardTd).text(standardsum);
							$(compareTd).text(comparesum);
							if(cnt==0||cnt==3){
								standardtotal += standardsum;
								comparetotal += comparesum;
								cnt++;
							}else{
								standardtotal -= standardsum;
								comparetotal -= comparesum;
							}
						}
						trTag = $("<tr>").append(
							$("<td>").text("  " + division).css("text-align","center")
							,$("<td>")
							,standardTd = $("<td>")
							,$("<td>")
							,compareTd = $("<td>")
						).css("color","green");
						standardsum = 0;
						comparesum = 0;
						trTags.push(trTag);
					}
				
					trTag = $("<tr>").append(
						$("<td>").text("    "+list.account_name)
						,$("<td>").text(list.standard)
						,$("<td>")
						,$("<td>").text(list.compare)
						,$("<td>")
					)
					trTags.push(trTag);
						standardsum += list.standard;
						comparesum += list.compare;
						
						if(idx==result.length-1){
							$(standardTd).text(standardsum);
							$(compareTd).text(comparesum);
							trTag = $("<tr>").append(
								$("<th>").text("당기순이익")
								,$("<td>")
								,$("<td>").text(standardtotal)
								,$("<td>")
								,$("<td>").text(comparetotal)
							).css("background-color","lightgray");
							trTags.push(trTag);
						}
			})
			$("#listBody").html(trTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
}
</script>
