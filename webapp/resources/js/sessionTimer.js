/**
 * 
 */

$.fn.sessionTimer = function (timeout){
	console.log(this);
	const self = this;
	const initTimeout = timeout;
	var msgOutId = null;
	
	function formatting(timeValue){
		let min = Math.trunc(timeValue/60);
		let sec = timeValue%60;
		return min+":"+sec;
	}
	function init(){
		msgArea = self.find("#msgArea").hide();
		timeValue = initTimeout;
		if(msgOutId){
			clearTimeout(msgOutId);
		}
		msgOutId = setTimeout(function(){
			msgArea.show();
		}, (initTimeout - 60)*1000);
	}
	init();
	
	var timerArea = self.find("#timerArea");
	if(!timerArea || timerArea.length==0){
		timerArea = $("<div>").prop({id:"timerArea"})
		self.prepend(timerArea);
	}
	var msgBtn = msgArea.find(".msgBtn").on("click",function(){
		let btnId = $(this).prop("id");
		if(btnId == "yesBtn"){
			init();
		}
		msgArea.hide();
	});
	
	var timerId = setInterval(function(){
		if(--timeValue <= 0){
			clearInterval(timerId);
		}else{
			timerArea.text(formatting(timeValue));
		}
	},1000);
	
	
	

// 	let timer = $("#timerArea");
// 	let msg = $("#msgArea");
// 	let change = setInterval(function(){
// 		timer.text(moment(new Date(start -= 1000)).format('m:ss'));
// 		if(start == 1000*60) msg.show(); 
// 		if(start == 0) clearInterval(change);
// 	},1000);
// 	$(".msgBtn").on("click",function(){
// 		msg.hide();
// 	})
// 	$("input").eq(0).on("click",function(){
// 		timer.text(moment(new Date(start)).format('m:ss'));
// 	})
}