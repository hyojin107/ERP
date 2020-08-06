<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>감가상각비현황</h1><br>
<table>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<text>자산유형</text>
					<select name="account_no" class="form-control mr-2">
						<option value="">
							<spring:message code='all'/>
						</option>
						<c:forEach items="${accountList }" var="account">
							<option value="${account.account_no }"
								${account.account_no==account_no?"selected":"" } >${account.account_name }
							</option>
						</c:forEach>
					</select>
					<text>조회기간</text>
					<select name="startyear" id='syear' class="form-control mr-2" required="required">
					</select>년
					<select name="startmonth" id='smonth' class="form-control mr-2">
					</select>월
					~
					<select name="endyear" id='eyear' class="form-control mr-2" required="required">
					</select>년
					<select name="endmonth" id='emonth' class="form-control mr-2">
					</select>월
					<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn">
				</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr id='thead' >
			<th class='basic'>자산유형</th>
			<th class='basic'>자산코드</th>
			<th class='basic'>자산명</th>
			<th class='basic'>자산상태</th>
			<th class='basic'>합계</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
</table>
<form id="searchForm" action="${cPath }/account/fixAssets/fixMinus">
	<input type="hidden" name="account_no" value="${vo.account_no}"/>
	<input type="hidden" name="startyear" value="${vo.startyear }"/>
	<input type="hidden" name="startmonth" value="${vo.startmonth }"/>
	<input type="hidden" name="endyear" value="${vo.endyear }"/>
	<input type="hidden" name="endmonth" value="${vo.endmonth }"/>
</form>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">전표 상세내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary">수정</button>
      </div>
    </div>
  </div>
</div>

<div id='s'></div>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script>
var listBody = $("#listBody");
var searchForm = $("#searchForm").paging({
	searchUI:"#searchUI",
	searchBtn:"#searchBtn",
	byAjax:true,
	success:function(resp){
		var thead = $("thead").find("th").not(".basic").remove();
		var date1 = new Date($("#syear"),$("#smonth").val()==""?0:$("#smonth").val()-1,1);
		var date2 = new Date($("#eyear"),$("#emonth").val()==""?11:$("#emonth").val()-1,1);
		
		var years = date2.getFullYear() - date1.getFullYear();

		var months = date2.getMonth() - date1.getMonth();

		var differentMonth = years * 12 + months + 1;
		
		var sumsum = [differentMonth+1];
		var sum = [differentMonth+1];
		
		
		for(var i = 0; i < differentMonth; i++){
			thead.append($("<th>").text(date1.getFullYear()+'년 '+(date1.getMonth+1)+'월'));
			date1.setMonth(date1.getMonth()+1);
		}
		
		let fixList = resp;
		let trTags = [];
		if(fixList.length>0){
			var change = fixList[0].account_name;
			$.each(fixList, function(idx, fix){
				let trTag = $("<tr>");
				if(change != fix.account_name){
					change = fix.account_name;
					var tr = $("<tr>").append(
							$("<td>").attr("colspan", $(".basic").length-1).text("소계")
							,$("<td>").text(sum[0])
					);
					sumsum[0] += sum[0];
					for(var i = 0; i < differentMonth; i++){
						tr.append($("<td>").text(sum[i+1]));
						sumsum[i+1] += sum[i+1];
					}
					sum = [differentMonth+1];
					trTags.push(tr);

				}
				trTag.append(
							$("<td>").text(fix.account_name)
							, $("<td>").text(fix.fixassets_no)
							, $("<td>").text(fix.assets_name)
							, $("<td>").text(fix.status)
							, $("<td>").text(fix.total)
						);
				sum[0] += fix.total;
				var j = 0;
				for(var i = 0; i < differentMonth; i++){
					var day = thead.find("th").not("basic")[i].text();
					var fixMinusList = fix.fixMinusList;
					var cost = 0;
					if(fixMinusList!=null && fixMinusList.length > j){
						if(day == fixMinusList[j].amor_date)
							cost = fixMinusList[j++].amor_cost;
					}				

					trTag.append($("<td>").text(cost));
					sum[i+1] += cost;
				}
				trTags.push(trTag);
			});
			var tr = $("<tr>").append(
					$("<td>").attr("colspan", $(".basic").length-1).text("누계")
					,$("<td>").text(sumsum[0])
			);
			for(var i = 0; i < differentMonth; i++){
				tr.append($("<td>").text(sumsum[i+1]));
			}
			trTags.push(tr);
		}else{
			trTags.push($("<tr>").html($("<td colspan='6'>").text("조건에 맞는 고정자산이 없습니다.")));
		}
		listBody.html(trTags);
		listBody.data("currentpage", resp.currentPage);
		searchForm.find("[name='page']").val("");
	}
}).submit();

for(var i = ${fixDate.startyear}; i <= ${fixDate.endyear}; i++){
	$("#syear").append($("<option>").text(i).val(i));
	$("#eyear").append($("<option>").text(i).val(i));
}
for(var i=1;i<13;i++){
	$("#smonth").append($("<option>").text(i).val(i));
	$("#emonth").append($("<option>").text(i).val(i));
}
var startmonth = ${fixDate.startmonth};
var endmonth = ${fixDate.endmonth};
var startyear = ${fixDate.startyear};
var endyear = ${fixDate.endyear};
$("#syear").on("change", function(){
	var sval = $(this).val();
	var eyear = $("#eyear");
	var optionlist = $("#smonth").find("option");
	if(sval==startyear&&sval!=endyear){
		$.each(optionlist, function(idx, option){
			if(option.value < startmonth){
				$(option).hide();
			}else $(option).show();
		});
		if($("#smonth").val()<startmonth) $("#smonth").val(startmonth);
	}else if(sval==startyear&&sval==endyear){
		$.each(optionlist, function(idx, option){
			if(option.value < startmonth|| option.value>endmonth){
				$(option).hide();
			}else $(option).show();
		});
		if($("#smonth").val()<startmonth) $("#smonth").val(startmonth);
		else if($("#smonth").val()>endmonth) $("#smonth").val(endmonth);
	}else if(sval==endyear){
		$.each(optionlist, function(idx, option){
			if(option.value>endmonth){
				$(option).hide();
			}else $(option).show();
		});
		if($("#smonth").val()>endmonth) $("#smonth").val(endmonth);
	}else{
		$.each(optionlist, function(idx, option){
			$(option).show();
		})
	}
	$.each(eyear.find("option"), function(idx, option){
		if(option.value < sval){
			$(option).hide();
		}else $(option).show();
	})
	if(eyear.val()<sval) eyear.val(sval);
	if(eyear.val()==sval) monthconnect();
	$("#eyear").change();
});
$("#eyear").on("change", function(){
	var eval = $(this).val(); 
	var eoptionlist = $("#emonth").find("option");
	if(eval==startyear&&eval!=endyear){
		$.each(eoptionlist, function(idx, option){
			if(option.value < startmonth){
				$(option).hide();
			}else $(option).show();
		});
		if($("#emonth").val()<startmonth) $("#emonth").val(startmonth);
	}else if(eval==startyear&&eval==endyear){
		$.each(eoptionlist, function(idx, option){
			if(option.value < startmonth|| option.value>endmonth){
				$(option).hide();
			}else $(option).show();
		});
		if($("#emonth").val()<startmonth) $("#emonth").val(startmonth);
		else if($("#emonth").val()>endmonth) $("#emonth").val(endmonth);
	}else if(eval==endyear){
		$.each(eoptionlist, function(idx, option){
			if(option.value>endmonth){
				$(option).hide();
			}else $(option).show();
		});
		if($("#emonth").val()>endmonth) $("#emonth").val(endmonth);
	}else{
		$.each(optionlist, function(idx, option){
			$(option).show();
		})
	}
	if($("#eyear").val()==$("#syear").val()) monthconnect();
});
$("#smonth").on("change", function(){
	if($("#syear").val()==$("#eyear").val()) monthconnect();
	$("#eyear").change();
});
function monthconnect(){
	var month = $("#smonth").val();
	var max = $("#eyear").val() == endyear ? endmonth : 12;
	$.each($("#emonth").find("option"), function(idx,option){
		if(option.value<month || option.value > max){
			$(option).hide();
		}else $(option).show();
	});
	if($("#emonth").val()<month) $("#emonth").val(month);
}
$("#syear").change();
$("#eyear").change();
</script>