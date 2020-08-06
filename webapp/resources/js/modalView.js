/**
 * <pre>
 * 사원목록/거래처 목록 조회 후, 클릭한 값을 input태그에 입력되게 함
 * </pre>
 * @author 송효진
 * @since 2020. 7. 10
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 	수정일         수정자       	수정내용
 * --------     --------    ----------------------
 * 2020. 7. 10       송효진       	최초작성
 * Copyright (c) 2020 by DDIT All right reserved
 * </pre>
 */ 

//$.modalView = function(objParam){
function modalView(objParam){
	const noText = $(objParam.noText);		//사원 클릭 시, 입력될 태그 지정
	const nameText = $(objParam.nameText);	//사원 클릭 시, 입력될 태그 지정
	const clickBtn = $(objParam.clickBtn);				//모달창을 띄울 버튼 지정
	const urlPath = objParam.urlPath;				//"${cPath}/buy/document/empModal"/
	const title = objParam.title;					//모달 제목
	
//	var exampleModal = $("#exampleModal").modal({
//		show:false
//	}).on("hidden.bs.modal", function(){
//		exampleModal.find(".modal-body").empty();
//	});
	
	var typeTable;
	if(urlPath.search("emp")>0){
		typeTable="#empTable";
	}else{
		typeTable="#buyerTable";
	}
	
	//담당자 모달창
	function loadModalView(){
		$("#exampleModalLabel").text(title);
		$.ajax({
			url : urlPath,
			dataType : "html",
			success : function(resp) {
				exampleModal.find(".modal-body").html(resp);
				exampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
		$(document).on("click", typeTable+" tr", function(){
			let no;
			let name;
			if(urlPath.search("emp")>0){
				no = $(this).find(".emp_no").text();
				name = $(this).find(".emp_name").text();				
			}else{
				no = $(this).find(".buyer_no").text();
				name = $(this).find(".buyer_name").text();								
			}
			exampleModal.modal("hide");
			
			noText.val(no);
			nameText.val(name);
		}).css({ cursor:"pointer" });
	}
	clickBtn.on("click", function(){
		loadModalView();
	});
	
}



