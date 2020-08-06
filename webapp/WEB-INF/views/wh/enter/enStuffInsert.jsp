<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


  <style type="text/css">
  
  .stuffOK {
  border-left: 5px solid greey;
      background: ghostwhite;
  
  }
  .stuffFAIL{
  border-left: 5px solid red;
      background: ghostwhite;
  }
  
  </style>


  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>HnJ ERP</title>
  <!-- jQuery -->
  <script src="/ERP/resources/plugins/jquery/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="/ERP/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- IonIcons -->
  <link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/ERP/resources/dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <link href="https://unpkg.com/bootstrap-table@1.17.1/dist/bootstrap-table.min.css" rel="stylesheet">
  <script type="text/javascript" src="/ERP/resources/js/bootstrap-4.5.0-dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://unpkg.com/bootstrap-table@1.17.1/dist/bootstrap-table.min.js"></script>
  
</head>
<body>

<select id = "wareList"  class="dynamicElement form-control col-md-6" data-url = "${cPath }/warehouse/warelist" name = "store_no">
<option>창고선택</option>
</select>

<div class = "row">
<div class = "col-8">
 <iframe src="${cPath}/warehouse/shape" style="width: 100%; height: 750px" id = "storeBox">
   </iframe>
</div>

<div class = "col-4 overflow-auto" style="height: 750px" >
<a><i class= 'fa fa-archive fa-2x'></i>원자재 목록</a>
<div class = "col-4 cardlist">

 <div class="card" style="width: 18rem;">
  <div class="card-body stuffFAIL">
    <h3 class ='stuff_name' >설탕</h3>
    <p class="card-text stuff_cnt">5개</p>
    <div>
    <a href="#" class="btn btn-primary instuff">입고</a>
    <div class="counter" style="
    display: inline;
    position: absolute;

    right: 30px;
    ">
      <i class="fa fa-sort fa-2x" aria-hidden = "true"></i>
      <h2 class="timer count-title count-number" style="display: inline;">100</h2>
    </div>
    
    </div>
  </div>
</div>

</div>
</div>
</div>
<hr>


  <table
  id="table"
  data-toggle="table"
  data-height="460"
   >
  <thead>
    <tr>
      <th data-field="sector_no">구역번호</th>
      <th data-field="stuff_no">품명</th>
      <th data-field="stuff_date">입고일자</th>
      <th data-field="stuff_cnt">입고수량</th>
      <th data-field="operate" data-formatter="operateFormatter" data-events="operateEvents">삭제</th>
    </tr>
  </thead>
</table>



   <input type="hidden" value="${lstore_no }" name = "lstore_no">
   <input type="hidden" value="${code }" name = "code">


   <script type="text/javascript" src="${cPath}/resources/js/dynamicSelect.js"></script>
<script type="text/javascript">

var prod_lgu = "${lstore_no}"
var optionPtrn = "<option value='%V'>%T</option>";
var parentData = opener.parent.setRow()
var sector_no = null;
var stuff_count = 0;

//카드 생성
$.each(parentData.stufflist,function(index,item){
	
	stuff_count++;
	let card = $(".card").eq(0).clone()
	card.find(".stuff_name").text(item.stuff_name)
	card.find(".stuff_cnt").text(item.stuff_cnt + item.stuff_size)
	card.find(".count-number").text(item.stuff_cnt).attr("name",stuff_count)
	
	$(".cardlist").append(card)
	console.log(card)
})
$(".card").children().eq(0).remove()


$(".instuff").on("click",function(){
	
	let count_number = $(this).parent().parent().find(".count-number");
	
	
	
})

//카드 생성 종료


$.ajax({
	url : "${cPath }/warehouse/warelist",
	data: {LwareHouse_no: prod_lgu},
	dataType : "json", // Accept:application/json, Content-Type:application/json
	success : function(resp){
		
		var html = "<option value>창고 선택</option>";
		$.each(resp, function(idx, buyer){
			html += optionPtrn.replace("%V", buyer.store_no).replace("%T", buyer.store_name);
		});
		prod_buyerTag.html(html);
		
	},
	error : function(errorResp) {
		console.log(errorResp.status + ":" + errorResp.responseText);
	}
});


var prod_buyerTag = $("#wareList").data("success", function(resp){
	var html = "<option value>창고 선택</option>";
	$.each(resp, function(idx, buyer){
		html += optionPtrn.replace("%V", buyer.store_no).replace("%T", buyer.store_name);
	});
	prod_buyerTag.html(html);
}).on("change", function(){
	
	console.log( parentData )
	let Store_no = $("#wareList").val()
	$('#storeBox')[0].contentWindow.changeJsonPath(Store_no)
})

function selectGrid(sector){
	sector_no = sector
	
	
	}
	


</script>

</body>
</html>