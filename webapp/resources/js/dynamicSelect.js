/**
 * 
 */
$.fn.dynamicSelect = function(){
	this.each(function(){
		let url = $(this).data("url");
		let success = $(this).data("success");
		let obj = {
			url:url
			, success:success
		}
		dynamicElementGen(obj);
	});
	this.on("renew", function(event, parameter){
 		let obj = {
			url:$(this).data("url"),
			success: $(this).data("success"),
			data:parameter
		}
		dynamicElementGen(obj);
	});
	function dynamicElementGen(obj){
		$.ajax({
			url : obj.url,
			data: obj.data?obj.data:{},
			dataType : "json", // Accept:application/json, Content-Type:application/json
			success : obj.success,
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	return this;
}