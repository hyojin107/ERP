<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>월별손익현황</h1><br>
<table>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<text>년도</text>
					<select name="standard" id="standard" class="form-control mr-2">
					</select>
				<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn" onclick="page();">
				</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary" id="head">
		<tr>
			<th>재무제표표시명</th>
		</tr>
	</thead>
	<tbody id="listBody">
		<tr class='trtags'>
			<th>
				매출
			</th>
		</tr>
		<tr class='trtags'>
			<th>
				상품매출
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			매출원가
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			상품매출원가
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			매출총이익
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			판매비 및 일반관리비
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			퇴직급여
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			일반급여
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			보험료
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			영업손익
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			영업외비용
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			상품폐기비용
			</th>
		</tr>
		<tr class='trtags'>
			<th>
			당기순이익
			</th>
		</tr>
	</tbody>
</table>
<form id="searchForm" action="${cPath }/account/plusMinus">
	<input type="hidden" name="base_year" value="${param.base_year }"/>
	<input type="hidden" name="compare_year" value="${param.compare_year }"/>
</form>

<script>
var today = new Date();
for(var i = today.getFullYear(); i >= ${year}; i--){
	$("#standard").append($("<option>").text(i).val(i));
}
function page(){
	var standard = $("#standard").val();
	var trTags = [$("<tr>").html("<th>재무제표표시명</th>"),
			$("<tr>").append($("<th>").text("매출").css("color","blue").css("text-align","center")),
			$("<tr>").append($("<th>").text("상품매출")),
			$("<tr>").append($("<th>").text("매출원가")),
			$("<tr>").append($("<th>").text("상품매출원가")),
			$("<tr>").append($("<th>").text("매출총이익").css("color","blue").css("text-align","center")),
			$("<tr>").append($("<th>").text("판매비 및 일반관리비")),
			$("<tr>").append($("<th>").text("퇴직급여")),
			$("<tr>").append($("<th>").text("일반급여")),
			$("<tr>").append($("<th>").text("보험료")),
			$("<tr>").append($("<th>").text("영업이익").css("color","blue").css("text-align","center")),
			$("<tr>").append($("<th>").text("영업외비용")),
			$("<tr>").append($("<th>").text("원자재폐기비용")),
			$("<tr>").append($("<th>").text("상품폐기비용")),
			$("<tr>").addClass("sum").append($("<th>").text("당기순이익").css("color","blue").css("text-align","center"))
	];
	
	if(!standard) standard = today.getFullYear();
	
	let last = standard == today.getFullYear() ? today.getMonth() + 1 : 12;
	
	for(let i = 1; i <= last; i++){
		trTags[0].append($("<th>").text(standard + "년 " + (i < 10 ? "0"+i : i ) + "월"));
		for(let j = 1; j < trTags.length; j++)
			trTags[j].append($("<td>"));
	}
			
	
	$.ajax({
		url : "${cPath}${currentPage}",
		data : {
			standard:standard
		},
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			let result = resp;
			var sum = 0;
			let tridx = 1;
			let tdidx = 1;
			$.each(result,function(idx, list){
				let pass = true;
				while(pass){
					let tdTag = $(trTags[tridx]).children().eq(tdidx);
// 					console.log($(trTags[tridx]).children().first().text());
// 					console.log(list.account_name);
					if($(trTags[tridx++]).children().first().text() == list.account_name){
						if($(trTags[0]).children().eq(tdidx).text() == list.division){
							pass = false;
							tdTag.text(list.price);
							if(tridx==6)
							sum += list.price;
							if(tridx==7 || tridx==12)
							sum -= list.price;
						}
					}
					
					if(tridx==11) tdTag.text(sum==0?"":sum); 
					
					if(tridx == trTags.length) {
						$(trTags[trTags.length-1]).children().eq(tdidx).text(sum);
						sum = 0;
						tridx = 1;
						tdidx++;
					}
// 					console.log($(trTags[tridx++]).children().first().text());
// 					console.log(trTags.length);
// 					break;
				}
			});
			console.log(trTags[0].children().length);
			for(let i = tdidx; i < trTags[0].children().length; i++){
				$(trTags[trTags.length-1]).children().eq(i).text(sum);
				sum = 0;
			}
			$("#head").html(trTags[0]);
			trTags.splice(0,1);
			$("#listBody").html(trTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
}
</script>
