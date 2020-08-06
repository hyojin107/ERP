/**
 * 
 */
function loadPurView(purVO){ //상세보기 데이터 삽입
	$("#exampleModalLabel").text("매입서 목록");
	let view = $("<table>").addClass("table table-bordered").append(
			$("<tr>").append($("<th>").text("매입번호"), $("<td>").text(purVO.pur_code)  ),
			$("<tr>").append($("<th>").text("발주번호"), $("<td>").text(purVO.or_code)  ),
			$("<tr>").append($("<th>").text("매입 일자"), $("<td>").text(purVO.pur_date)  ),
			$("<tr>").append($("<th>").text("발주 일자"), $("<td>").text(purVO.or_date)  ),
			$("<tr>").append($("<th>").text("거래처코드"), $("<td>").text(purVO.buyerVO.buyer_no)  ),
			$("<tr>").append($("<th>").text("거래처명"), $("<td>").text(purVO.buyerVO.buyer_name)  ),
			$("<tr>").append($("<th>").text("매입 개수"), $("<td>").text(purVO.matCnt)  ),
			$("<tr>").append($("<th>").text("작성자"), $("<td>").text(purVO.emp_name)  ),
			$("<tr>").append($("<th>").text("작성자 부서"), $("<td>").text(purVO.dep_name)  )
	);
	//서브테이블 만들기
	let matTr = "<tr><td colspan='2'>";
	matTr += "<table><h4>원자재 발주 물품</h4>";
	matTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr>";
	for(var i=0; i<purVO.matList.length; i++){
		matTr += "<tr><td>"+purVO.matList[i].mat_no+"</td>";
		matTr += "<td>"+purVO.matList[i].mat_name+"</td>";
		matTr += "<td>"+purVO.matList[i].lprod_name+"</td>";
		matTr += "<td>"+purVO.matList[i].mat_stand_size+"</td>";
		matTr += "<td>"+purVO.matList[i].ormat_qty+"</td>";
		matTr += "<td>"+purVO.matList[i].cost+"</td>";
	}
	matTr += "</table></tr>";
	
	let itemTr = "<tr><td colspan='2'>";
	itemTr += "<table><h4>일반 발주 물품</h4>";
	itemTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr>";
	for(var i=0; i<purVO.itemList.length; i++){
		itemTr += "<tr><td>"+purVO.itemList[i].item_no+"</td>";
		itemTr += "<td>"+purVO.itemList[i].item_name+"</td>";
		itemTr += "<td>"+purVO.itemList[i].item_lprod+"</td>";
		itemTr += "<td>"+purVO.itemList[i].item_stand_size+"</td>";
		itemTr += "<td>"+purVO.itemList[i].item_qty+"</td>";
		itemTr += "<td>"+purVO.itemList[i].item_cost+"</td></tr>";
	}
	itemTr += "</table></tr>";
	
	view.append(matTr).append(itemTr);
	
	exampleModal.find(".modal-body").html(view);
	exampleModal.data("purCode", purVO.pur_code);
	exampleModal.modal("show");
}
