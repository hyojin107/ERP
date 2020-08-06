<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

    
   <html>
   
 
<div class="container">
    <div class="row">
        <div class="col-sm-7 col-md-9">
   <iframe src="${cPath}/warehouse/shape" style="width: 100%; height: 750px" id = "storeBox">
   </iframe>
        </div>
        <div class="col-md-3">
        
 <select id = "Lwarelist"  class="dynamicElement form-control col-md-6" data-url = "${cPath }/warehouse/lwarelist" name = "search.searchType">
 <option>창고 종류선택</option>
 </select>
<select id = "wareList"  class="dynamicElement form-control col-md-6" data-url = "${cPath }/warehouse/warelist" name = "store_no">
<option>창고선택</option>
</select>
        </div>
    </div>
  </div>


   <div class = "col-md-6">
   <table class = "table">
   
   <thead>
   <tr>
   <td>명칭</td>
   <td>총갯수</td>
   <td>단위</td>
   </tr>
   </thead>
	<tbody id = "storeList">
	</tbody>
   </table>
   </div>
   
   <div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원 정보 상세 조회</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id = "modalbody">
      
      </div>
      <div class="modal-footer">
      
        
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
   
   <script type="text/javascript" src="${cPath}/resources/js/dynamicSelect.js"></script>
   <script type="text/javascript">
   
   
   var optionPtrn = "<option value='%V'>%T</option>";
	var prod_lguTag = $("#Lwarelist").data("success", function(resp){
		var html = "";
		$.each(resp, function(idx, lprod){
			html += optionPtrn.replace("%V", lprod.lstore_no).replace("%T", lprod.lstore_name);			
		});
		prod_lguTag.append(html);
	}).on("change", function(){
		let prod_lgu = $(this).val();

		prod_buyerTag.trigger("renew", {
			LwareHouse_no : prod_lgu
		});
	});
	var trPtrn = "<tr data-toggle = 'modal' data-target = '#viewModal' data-remote='${cPath }/warehouse/sectorlist?store_no=%T&stuff_name=%V'>"
	var prod_buyerTag = $("#wareList").data("success", function(resp){
		var html = "<option value>창고 선택</option>";
		$.each(resp, function(idx, buyer){
			html += optionPtrn.replace("%V", buyer.store_no).replace("%T", buyer.store_name);
		});
		prod_buyerTag.html(html);
	}).on("change", function(){ // 창고가 선택이 되었을 때
		let store_no = $("#wareList").val()
		let searchType = $("#Lwarelist").val().trim()
		
		let path = "${cPath}/warehouse/callware"
		let setvalue = {searchType : searchType,store_no : store_no}
		$.ajax({url : path,data : setvalue,method : "post",dataType : "json", 
			success : function(resp) {
					// resp가 mat인지 prod인지 식별 가능해야한다.
					let trArr = []
					console.log(resp)
					console.log($(resp.matList).length)
					
					if($(resp.matList).length > 0 ){
						$.each(resp,function(idx, ele){
							let tr = trPtrn.replace("%T", ele.store_no).replace("%V",ele.matList[0].mat_name)
							let trElement = $(tr).append(
									$("<td>").text(ele.matList[0].mat_name),
									$("<td>").text(ele.matList[0].mat_cnt),
									$("<td>").text(ele.matList[0].mat_stock_size)
							)
							trArr.push(trElement)
						})
					}else{
						$.each(resp,function(idx, ele){
							let tr = trPtrn.replace("%T", ele.store_no).replace("%V",ele.prodList[0].prod_name)
							let trElement = $(tr).append(
									$("<td>").text(ele.prodList[0].prod_name),
									$("<td>").text(ele.prodList[0].prod_cnt),
									$("<td>").text(ele.prodList[0].prod_stock_size)
							)
							trArr.push(trElement)
						})
					$("#storeList").html(trArr)
					}
			}
		})
				let Store_no = $("#wareList").val()
				$('#storeBox')[0].contentWindow.changeJsonPath(Store_no)
	})
	
	$(".dynamicElement").dynamicSelect();
   
   
	function selectGrid(sector_no){
		let path = "${cPath}/warehouse/callsector"
		
		$.ajax({

			url : path,
			data : {sector_no : sector_no},
			method : "post",
			dataType : "json", // Accept,text/html , Content-Type:text/html accept와 
			success : function(resp) {
				console.log(resp)
			},
			error : function(error) {

				console.log(error.status + " : " + error.responseText);
			}
		})
	}
   
   
   $("#storeList").on("click","tr", function(){
	   
		var modal = $(this); 
		var modalbody = $(".modal-body")
		
		modalbody.load(modal.data("remote"));

	}).css({
			cursor:"pointer"
		});
   
   
//    $.ajax({

// 		url : "${cPath}/warehouse ",
// 		method : "GET",
// 		dataType : "JSON", // Accept,text/html , Content-Type:text/html accept와 
// 		success : function(resp) {
			
// 			console.log(resp)
// 			let optionhtml = "<option>창고선택</option>"
			
// 			$.each(resp, function(idx, wareHouse){
				
// 				optionhtml += optionPtrn.replace("%V", wareHouse.store_no).replace("%T",wareHouse.store_name)
// 			})
// 			$("#wareList").html(optionhtml)
// 		},
// 		error : function(error) {

// 			console.log(error.status + " : " + error.responseText);
// 		}
// 	})

   </script>
   
   
   </html>