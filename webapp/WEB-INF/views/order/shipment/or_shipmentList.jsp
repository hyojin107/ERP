<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 23       송효진 	          최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<!-- <?xml version="1.0" encoding="UTF-8" ?> -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${cPath }/resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="${cPath }/resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css">

<h3>출하서 조회</h3>

<table id="myTable" class="table table-hover">
	<thead class="table-primary">
		<tr>
			<th scope="col">출하등록 번호</th>
			<th scope="col">출하일</th>
			<th scope="col">출고요청일</th>
			<th scope="col">거래처명</th>
			<th scope="col">담당자명</th>
		</tr>
	</thead>
</table>


<!-- 모달창 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">출하서 상세보기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<!-- DataTables -->
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


<script type="text/javascript">
	
	//dataTable 세팅
	var myDataTable= $("#myTable").DataTable({
		bPaginate: true,
		searching: true,
	    "destroy":true,
	    "responsive": true,
	    "autoWidth": false,
	    stateSave: true,
	    dom: 'lfrtBip',
	    buttons: [
	        'excel', 'print'
	    ],
	    ajax:{
	       url: "${cPath}/order/shipment"
	       ,dataType:"json"
	    },
	    columns:[
	          {data:"ship_no"}
	          ,{data:"ship_p_date"}
	          ,{data:"ship_date"}
	          ,{data:"orderpVO.buyer_name"}
	          ,{data:"emp_name"}
	    ],
	    "columnDefs": {
			className: "dt-head-center"
		}
	});

	$('#myTable tbody').on('click', 'tr', function () {
		var data = myDataTable.row(this).data();
		console.log(data);
		let view = $("<table>").addClass("table table-bordered").append(
			$("<tr>").append($("<th>").text("출하등록번호"), $("<td>").text(data.ship_no)  ),
			$("<tr>").append($("<th>").text("출하일"), $("<td>").text(data.ship_p_date)  ),
			$("<tr>").append($("<th>").text("출고요청일"), $("<td>").text(data.ship_date)  ),
			$("<tr>").append($("<th>").text("거래처코드"), $("<td>").text(data.orderpVO.buyer_no)  ),
			$("<tr>").append($("<th>").text("거래처명"), $("<td>").text(data.orderpVO.buyer_name)  ),
			$("<tr>").append($("<th>").text("담당자명"), $("<td>").text(data.orderpVO.emp_name)  )
		);
		
		//서브테이블 만들기
		let prodTr = "<tr><td colspan='2'>";
		prodTr += "<table><h4>구매요청 물품</h4>";
		prodTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격</th><th>규격단위</th><th>수량</th></tr>";
		for(var i=0; i<data.orderpVO.orderList.length; i++){
			prodTr += "<tr><td>"+data.orderpVO.orderList[i].prod_no+"</td>";
			prodTr += "<td>"+data.orderpVO.orderList[i].prod_name+"</td>";
			prodTr += "<td>"+data.orderpVO.orderList[i].lprod_name+"</td>";
			prodTr += "<td>"+data.orderpVO.orderList[i].prod_stand_size+"</td>";
			prodTr += "<td>"+data.orderpVO.orderList[i].orp_qty+"</td>";
			prodTr += "<td>"+data.orderpVO.orderList[i].orp_price+"</td></tr>";
		}
		prodTr += "</table></td></tr>";
		view.append(prodTr);
		
		$("#exampleModal").find(".modal-body").html(view);
		$('#exampleModal').modal();
	});
	
	
</script>




