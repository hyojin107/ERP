/**
 * 
 */
$.fn.paging = function(objParam){
	const searchForm = this;
	const searchUI = $(objParam.searchUI);
	const searchBtn = $(objParam.searchBtn);
	const pagination = $(objParam.pagination);
	const pageParam = objParam.pageParam;
	
	pagination.on("click", "a", function(event){
		event.preventDefault();
		let page = $(this).data(pageParam);
		searchForm.find("[name='"+pageParam+"']").val(page);
		searchForm.submit();
	});
	searchBtn.on("click", function(){
		searchForm.find("[name='"+pageParam+"']").val("");
		let children = searchUI.children(":input");
//	 		console.log(children);
		$(children).each(function(idx, input){
			let name = $(this).attr("name");
			if(name){
				let value = $(this).val();
				searchForm.find("[name='"+name+"']").val(value);
			}
		});
		searchForm.submit();
	});
	
	if(objParam.byAjax){
		const success = objParam.success;	
		searchForm.on("submit", function(event){
			event.preventDefault();
			let action = $(this).attr("action");
			let parameters = $(this).serialize();
			let method = $(this).attr("method");
			$.ajax({
				url : action?action:"",
				data : parameters,
				method : method?method:"get",
				dataType : "json", // Accept:application/json, Content-Type:application/json
				success : success,
				error : function(errorResp) {
					console.log(errorResp.status + ":"+ errorResp.responseText);
				}
			});
			return false;
		});
	}
	return this;
}	