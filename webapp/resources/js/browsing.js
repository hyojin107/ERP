/**
 * 
 */
$.fn.browse=function(obj){
	const browsingURL = obj.browsingURL;
	const eleClass = obj.eleClass;
	const processURL = obj.processURL;
	const browseTag = this;
	
	var commandProcess = function(obj){
//		console.log(obj);
		$.ajax({
			url:processURL,
			data:{
				command:obj.command,
				file:obj.file.prop("id"),
				dest:obj.dest?obj.dest.prop("id"):""
			},
			method:"post",
			dataType:"json",
			success:function(resp){
				console.log(resp);
				if(resp.status==200){
					obj.src.find("."+eleClass).trigger("refresh");
					if(obj.dest){
						obj.dest.find("."+eleClass).trigger("refresh");
					}
				}else{
					alert(resp.message);
				}
			},
			error : function(errorResp){
				console.log(errorResp.status + " : " + errorResp.responseText);
			}
		});
	};
	
	var toggler = this.on("click", "."+eleClass, function(){
		let liTag = $(this).parent();
		let caretTag = $(this);
		let base = liTag.prop("id");
		let already = $(this).next("ul.nested:first");
		let mainTag = $("main");
//		if(mainTag.find("#copy").prop("clicked") == "clicked"){
//			alert();
//		}
			
		if(already && already.length > 0){
			liTag.find(".nested:first").toggleClass("active");
			caretTag.toggleClass("caret-down");
			return;
		}
		$.ajax({
			url : browsingURL,
			data : {
				base: base
			},
			method : "get",
			dataType : "json",
			success : function(resp) {
				console.log(resp);
				if(!resp) return;		//해당 폴더에 자식이 한명도 없다면
				let ulTag = $("<ul>").addClass("nested").sortable({
					connectWith: ".folder>.nested",
					items:"> li.file",
					receive:function(event, ui){
//						console.log(event);
//						console.log(ui);
//						console.log($(this).parent("li").prop("id"));
						let dest = $(this).parent("li");
						let src = ui.sender.parent("li");
						let commandObj = {
							command : event.ctrlKey?"COPY":"MOVE",
							file:ui.item,
							dest:dest,
							src:src
						};
						commandProcess(commandObj);
					}
				});
				$(resp).each(function(idx, wrapper){
					let liTag = $("<li>").prop({
						"id":wrapper.id,
						"class":wrapper.clzName
					});
					if(wrapper.directory){
						liTag.html($("<span>").addClass(eleClass).text(wrapper.name).css("display","inline-block"));
					}else{
						liTag.text(wrapper.name).addClass("dropdown-item")
							.on("click", function(){
								if(!$(this).hasClass("active")){
									browseTag.find("li.file").removeClass("active");
								}
								$(this).toggleClass("active");
							});
//						$(this).on("click", function(){
//							$("<button>").prop("id","button1");
//							
//						});
					}
					ulTag.append(liTag);
				});
				caretTag.after(ulTag);
				liTag.find(".nested:first").toggleClass("active");
				caretTag.toggleClass("caret-down");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}).on("refresh", "."+eleClass, function(){
		let already = $(this).next("ul.nested:first");
		already.remove();
		$(this).trigger("click");
	});
	$(document).on("keyup", function(event){
//		console.log(event);
		if(event.keyCode==46){
			let file = browseTag.find("li.active");
			if(file.length>0 && confirm("삭제하시겠습니까?")){
				let commandObject = {
					command:"DELETE",
					file:file,
					src:file.parents("li.folder:first")
				};
				commandProcess(commandObject);
			}
		}
	});
	
	return this;
}
//$.browsing = function(contextPath){

$("#browser").on("click", ".file", function(){
	$(".btnCopy").remove();
	let btn = $("<button/>",{"text":"복사", "class":"btnCopy", "id":"copy"});
	let btn2 = $("<button/>",{"text":"이동", "class":"btnCopy", "id":"move"});
	let btn3 = $("<button/>",{"text":"삭제", "class":"btnCopy", "id":"del"});
	$(this).append(btn).append(btn2).append(btn3);
});


