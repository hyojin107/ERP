/**
 * 
 */

var toggler = $("#browser").on("click", ".caret", function(){
	let liTag = $(this).parent();
	let caretTag = $(this);
	let base = liTag.prop("id");
	let already = $(this).next("ul.nested:first");
	if(already && already.length>0){
		liTag.find(".nested:first").toggleClass("active");
		$(this).toggleClass("caret-down");
		return;
	}
	$.ajax({
		data : {
			base:base
		},
		method : "get",
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			console.log(resp)
			if(!resp) return;
			let ulTag = $("<ul>").addClass("nested");
			$(resp).each(function(idx, wrapper){
				let liTag = $("<li>").prop({
								"id":wrapper.id,
								"class":wrapper.clzName
							});
				if(wrapper.directory){
					liTag.html($("<span>").addClass("caret").text(wrapper.name));
				}else{
					liTag.text(wrapper.name);
				}
				ulTag.append(liTag);
			});
			caretTag.after(ulTag);
			liTag.find(".nested:first").toggleClass("active");
			caretTag.toggleClass("caret-down");
		},
		error : function(errorResp) {
			console
					.log(errorResp.status + ":"
							+ errorResp.responseText);
		}
	});
	
});
// 		var i;

// 		for (i = 0; i < toggler.length; i++) {
// 		  toggler[i].addEventListener("click", function() {
// 		    this.parentElement.querySelector(".nested").classList.toggle("active");
// 		    this.classList.toggle("caret-down");
// 		  });
// 		}
