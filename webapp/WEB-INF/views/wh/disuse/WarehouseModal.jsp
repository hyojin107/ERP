<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<select id = "Lwarelist"  class="dynamicElement form-control col-md-6" data-url = "${cPath }/warehouse/lwarelist" name = "search.searchType">
 <option>창고 종류선택</option>
 </select>
 
<select id = "wareList"  class="dynamicElement form-control col-md-6" data-url = "${cPath }/warehouse/warelist" name = "store_no">
<option value ="">창고선택</option>
</select>




    
  
    
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
var prod_buyerTag = $("#wareList").data("success", function(resp){
	var html = "<option value>창고 선택</option>";
	$.each(resp, function(idx, buyer){
		html += optionPtrn.replace("%V", buyer.store_no).replace("%T", buyer.store_name);
	});
	prod_buyerTag.html(html);
}).on("change", function(){ // 창고가 선택이 되었을 때
	let store_no = $("#wareList").val()
	let searchType = $("#Lwarelist").val().trim()
	
	let Store_no = $("#wareList").val()
				$('#storeBox')[0].contentWindow.changeJsonPath(Store_no)
				
})

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

$(".dynamicElement").dynamicSelect();
</script>