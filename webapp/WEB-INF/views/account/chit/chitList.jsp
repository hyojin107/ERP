<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="${cPath }/resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="${cPath }/resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css    ">
<h1>전표승인</h1>
<br>
<ul class="nav nav-pills nav-tabs">
	  <li class="nav-item" id="status_all">
	    <a class="nav-link active status" data-toggle="tab" href="#">전체</a>
	  </li>
	  <li class="nav-item" id="status_ing">
	    <a class="nav-link status" data-toggle="tab" href="#">요청</a>
	  </li>
	  <li class="nav-item" id="status_ok">
	    <a class="nav-link status" data-toggle="tab" href="#">승인</a>
	  </li>
</ul>
<form id="searchForm" action="${cPath }/account/chit">
<input type="hidden" name='sign_status' value="${sign_status }">
</form>

<div id="tablediv">
<table class="table table-bordered table-hover text-left" id="data-table"style='width : 100%'>
	<thead class="table-primary">
		<tr class="thead  center">
			<th></th>
			<th>전표코드</th>
			<th>전표일자</th>
			<th>매출/매입</th>
			<th>거래처명</th>
			<th>가액</th>
			<th>전표상태</th>
		</tr>
	</thead>
<!-- 	<tbody id="listBody"> -->

<!-- 	</tbody> -->
</table>
</div>
<button class="btn btn-success up" data-no='L002'>승인</button> 
<button	class="btn btn-warning up" data-no='L001'>승인취소</button> 
<!-- <button class="btn btn-success">삭제</button> -->

	<input type="hidden" name="page" value="${param.page }" />


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">전표 상세내역</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<form action="${cPath }/account/chit" id="upform">
	<input type="hidden" name="_method" value="put">
	<input type="hidden" name="chit_no" id="chit_no">
	<input type="hidden" name="sign_status" id="sign_status">
</form>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/paging.js"></script>

<script src="${cPath }/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<script src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js   "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.flash.min.js        "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js         "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js    "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js      "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js        "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.print.min.js        "></script>
<!-- dynamicSelect -->
<script type="text/javascript" src="${cPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
var listBody = $("#listBody").clone();

function format ( d ) {
    // `d` is the original data object for the row
    let result = '<table  border="0" style="padding-left:50px;width:100%;">'+
    			'<tr><td>No</td><td>품목명</td><td>단가</td><td>수량</td><td>적요</td><td>가액</td></tr>'
    	for(let i = 0; i < d.chitList.length; i++){
    		result += '<tr><td>'+(i+1)+"</td><td>"+d.chitList[i].product+'</td><td>'+d.chitList[i].price.toLocaleString()+'원</td><td>'+
    					d.chitList[i].qty+'</td><td>'+(d.chitList[i].summary==null?'':d.chitList[i].summary)+
    							'</td><td>'+(d.chitList[i].qty*d.chitList[i].price).toLocaleString()+'원</td></tr>'; 
    	}
    result += '</table>';
        return  result;
}


function search(){
	jQuery(function($){
		var table = $("#data-table").DataTable({
	    ajax: {
	    	url: "${cPath }/account/chit", 
   			dataSrc: '' 
	    },
		columns: [
	    	{ data: "buyer_no"}, 
			{ className:      'details-control',data: "chit_no" },
			{ className:      'details-control',data: "chit_date" },
			{ className:      'details-control',data: "buy_sell" },
			{ className:      'details-control',data: "buyer_name" },
			{ className:      'details-control',data: "pay" },
			{ className:      'details-control',data: "sign_status" }
		]
// 	    ,stateSave: true
	    ,order: [ [ 2, "desc" ],[1,"desc"] ]
	    ,columnDefs: [
			{ targets: 5 , render: $.fn.dataTable.render.number( ',' , '.' , 0 , '' , '원' ) }]
	    , dom: 'lfrtBip',
// 	    dom : '<"top"Blf>rt<"bottom"ip>',
        buttons: [ 
           'excel', 'print'
        ],
        "language": {
            "emptyTable": "데이터가 없습니다.",
            "lengthMenu": "페이지당 _MENU_ 개씩 보기",
            "info": "현재 _START_ - _END_ / _TOTAL_건",
            "infoEmpty": "데이터 없음",
            "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
            "zeroRecords": "일치하는 데이터가 없습니다.",
            "loadingRecords": "로딩중...",
            "processing":     "잠시만 기다려 주세요...",
            "paginate": {
                "next": "다음",
                "previous": "이전"
            },
        },
        responsive: true
	    });
	    clkfunc();
		clk(table);
		$('.status').on('click', function () {
			let text = this.text=='전체'?'':this.text;
			table.column(6).search(text).draw();
		});
		update(table);
	});

}
search();

clk = function(table){ $('#data-table tbody').on('click', 'td.details-control', function () {
    var tr = $(this).closest('tr');
    var row = table.row( tr );

    console.log($(this).children());
    
    if ( row.child.isShown() ) {
        // This row is already open - close it
        row.child.hide();
        tr.removeClass('shown');
    }
    else {
        // Open this row
        row.child( format(row.data()) ).show();
        tr.addClass('shown');
    }
} )};



var exampleModal = $("#exampleModal").modal({
	show:false
}).on("hidden.bs.modal", function(){
	exampleModal.find(".modal-body").empty();
});

var clkfunc = function(){$("#data-table").on("click", "tr", function(e){
		if($(e.target).hasClass("details-control")) return;
		var check = $(e.target).parent().find("input");
		if($(e.target).val()=='on') return;
		if($(this).attr("class")=="thead") return;
			if(!check.is(":checked")) {
				check.prop("checked",true);
			}
			else check.prop("checked",false);
}).css({cursor:"pointer"})};



var update = function(table){
	$(".up").on("click", function(){
	var first_sign = $("#sign_status").val();
	var no = $(this).data("no");
	
	
	var text = $(this).text();
	if(confirm("선택된 전표를 " +text+" 하시겠습니까?")){
		$.each($("input"),function(idx, input){
			if($(input).is(":checked")) {
				upda($(input),no,text);
			}
		});
	ajaxList(table);
	
	}
});
}
var ajaxList = function(table){
	   $.ajax({
                  url: "${cPath }/account/chit" 
                  ,dataType:"json"
                  ,success: function(resp){
               	  let page = $("#data-table_paginate").find(".active").children().text();
                   table.clear();
                   table.rows.add(resp);
                   table.draw();
                   $($("#data-table_paginate").find("a")).each(function(idx, item){
               		if($(item).text() == page) {
               			$(item).click();
               		}
               	});
            }
         });
	}


function upda(inputtag, sign_status, text){
	$("#chit_no").val(inputtag.parent().next().text());
	$("#sign_status").val(sign_status);
	var parameters = $("#upform").serialize();
	var action = $("#upform").attr("action");
	$.ajax({
		url : action,
		data : parameters,
		method : "post",
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			inputtag.prop("checked",!inputtag.is(":checked"));
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
	};
</script>